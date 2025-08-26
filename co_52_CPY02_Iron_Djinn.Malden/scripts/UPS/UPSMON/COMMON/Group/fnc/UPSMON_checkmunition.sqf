/****************************************************************
File: UPSMON_checkmunition.sqf
Author: Azroul13

Description:
	Check if unit in the group is out of munition
Parameter(s):
	<--- leader
Returns:
	Array of units who needs ammo
****************************************************************/

private ["_npc","_units","_result","_unit","_weapon","_magazineclass","_magazines","_weapon","_sweapon","_mags","_magazinescount","_smagazineclass"];
	
_npc = _this select 0;
_units = units _npc;
_result = [];
_minmag = 2;	

{
	if (!IsNull _x) then
	{
		if (alive _x) then
		{
			if (vehicle _x == _x) then
			{
				_unit = _x;
				_magsneeded = [[],[]];
				_weapon = primaryWeapon _unit;
				_sweapon = secondaryWeapon _unit;
				_magazineclass = getArray (configFile / "CfgWeapons" / _weapon / "magazines");
				_smagazineclass = [];
				if (_sweapon != "") then {_smagazineclass = getArray (configFile / "CfgWeapons" / _sweapon / "magazines");};
				_mags = magazinesAmmoFull _unit;
				
				if (count _smagazineclass > 0) then
				{
					_magazinescount = {(_x select 0) in _smagazineclass} count _mags;
					_arr = [];
					{_arr pushBack _x} forEach _smagazineclass;
					_magsneeded set [0,_arr];
					if (_magazinescount == 0) then
					{
						if (!(_unit in _result)) then
						{
							_result pushBack _unit;
						};
					};
				};
				
				if (count _magazineclass > 0) then
				{
					_magazinescount = {(_x select 0) in _magazineclass} count _mags;
					_arr = [];
					{_arr pushBack _x} forEach _magazineclass;
					_magsneeded set [1,_arr];
					if (_magazinescount <= 2) then
					{
						if (!(_unit in _result)) then
						{
							_result pushBack _unit;
						};
					};
				};
				
				if (_unit in _result) then
				{
					if (UPSMON_AllowRearm) then
					{
						[_unit,_magsneeded] spawn UPSMON_Rearm;
					};
				};
			};
		};
	};
		
} forEach _units;

_result