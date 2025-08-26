/****************************************************************
File: UPSMON_GetArtitarget.sqf
Author: Azroul13

Description:
	Get the most interesting target for Arti.

Parameter(s):
	<--- Array of enies
	<--- position of the calling leader
Returns:
	Target
****************************************************************/

private ["_enies","_currpos","_target","_list","_points"];

_enies = _this select 0;
_currpos = _this select 1;

_target = ObjNull;
_list = [];

{	
	if (alive _x) then 
	{																								
		if (_currpos vectordistance (getposATL _x) > 300) then
		{
			if (!((vehicle _x) isKindOf "AIR")) then
			{
				_points = 0;
				if (vehicle _x != _x) then
				{
					if ((vehicle _x) isKindOf "STATICWEAPON") then
					{
						_points = _points + 100;
					};
				
					if ((vehicle _x) isKindOf "CAR" || (vehicle _x) isKindOf "TANK") then
					{
						if (Speed _x < 10) then
						{
							_armor  = getNumber  (configFile >> "CfgVehicles" >> (typeOf (vehicle _x)) >> "armor");
							if (_armor > 500) then
							{
								_points = _points + 100;
							}
							else
							{
								_points = _points + 50;
							};
							
							if (!(IsNull (Gunner (vehicle _x)))) then
							{
								_points = _points + 100;
							};
						};
					};
					
					_cfgArtillery = getnumber (configFile >> "cfgVehicles" >> (typeOf (vehicle _x)) >> "artilleryScanner");
					
					if (_cfgArtillery == 1) then
					{
						_points = _points + 200;
					};
				}
				else
				{
					if ([_x] call UPSMON_Inbuilding) then
					{
						_points = _points + 100;
					};
					
					_eniesnear = [_x,_enies] call UPSMON_Eniesnear;
					
					if (_eniesnear > 4) then
					{
						_points = _points + (20 * (_eniesnear));
					};
				};
				
				_list pushBack [_x,_points];
			};
		};
	};										
} forEach _enies;

if (count _list > 0) then
{
	_list = [_list, [], {_x select 1}, "DESCEND"] call BIS_fnc_sortBy;
	_target = (_list select 0) select 0;
};

_target