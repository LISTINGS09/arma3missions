/****************************************************************
File: UPSMON_findnearestenemy.sqf
Author: Azroul13

Description:

Parameter(s):
	<--- Unit
Returns:
	---> Array of allied groups
	---> Array of enies units
****************************************************************/

private["_npc","_targets","_enemies","_allies","_enemySides","_friendlySides","_side","_unit"];

_npc = _this select 0;
_npcpos= getposATL _npc;
_enemies = [];
_suspectenies = [];
_allies  = [];
_targets = [];
	
if (_npc isKindOf "CAManBase") then 
{_targets = _npc nearTargets 800;};
if (_npc isKindOf "car") then 
{
	if ((!isNull gunner (vehicle _npc)) && (gunner (vehicle _npc) == _npc) ) then 
	{_targets = _npc nearTargets 1000;} else {_targets = _npc nearTargets 500;};
};
if (_npc isKindOf "Tank" || _npc isKindOf "Wheeled_APC" || _npc isKindOf "Ship") then 
{
	if (((!isNull gunner (vehicle _npc)) && (gunner (vehicle _npc) == _npc)) || ((!isNull commander (vehicle _npc)) && (commander (vehicle _npc) == _npc))) then 
	{_targets =  _npc nearTargets 1500;} else {_targets = _npc nearTargets 500;};
};
if (_npc isKindOf "StaticWeapon") then 
{_targets = _npc nearTargets 1000;};
if (_npc isKindOf "air") then 
{
	if ((driver (vehicle _npc) == _npc) || ((!isNull gunner (vehicle _npc)) && (gunner (vehicle _npc) == _npc))) then 
	{_targets = _npc nearTargets 2000;};
};
	
_enemySides = _npc call BIS_fnc_enemySides;
_friendlySides = _npc call BIS_fnc_friendlySides;
	
{
	_position = (_x select 0);
	_cost = (_x select 3);
	_unit = (_x select 4);
	_side = (_x select 2);
	_accuracy = (_x select 5);
		
	if (_side in _enemySides) then
	{
		if (alive _unit) then
		{
			if (alive _npc) then
			{
				if (count crew _unit > 0) then
				{
					if ((side driver _unit) in _enemySides) then
					{
						if (_accuracy < 20) then
						{
							_enemies pushBack _unit;
							_kv = _npc knowsAbout _unit;
							_unit setVariable ["UPSMON_TargetInfos",[_position,_accuracy,_cost,_kv]];
							//[_position,"ColorRed"] call fnc_createMarker;
						}
						else
						{
							if (_accuracy < 100) then
							{
								_suspectenies pushBack _unit;
								_unit setVariable ["UPSMON_TargetInfos",[_position,_accuracy,_cost,time]];
							};
						};
					};
				};
			};
		};
	};
	if (_unit == leader group _unit) then
	{
		if (_unit != _npc) then
		{
			if (_side in _friendlySides) then
			{
				if (group _unit in UPSMON_NPCs) then
				{
					if (round ([getposATL (leader (group _unit)),_npcpos] call UPSMON_distancePosSqr) <= UPSMON_sharedist) then
					{
						if (count crew _unit > 0) then
						{
							if ((side driver _unit) in _friendlySides) then
							{
								_allies pushBack (group _unit);
								//[_position,"ColorBlue"] call fnc_createMarker;
							};
						};
					};
				};
			};
		};
	};
		
} forEach _targets;

//if (UPSMON_Debug>0) then {diag_log format ["Targets found by %1: %2",_npc,_enemies];};
	
_result = [_enemies,_allies,_suspectenies];
_result