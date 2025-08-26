/****************************************************************
File: UPSMON_FireGun.sqf
Author: Azroul13

Description:
	
Parameter(s):

Returns:

****************************************************************/
private ["_grp","_assignedvehicles","_target","_gunner","_vehicle","_mags","_ammo","_gun","_weapon","_targetpos"];	

_grp = _this select 0;	
_assignedvehicles = _this select 1;
_target = _this select 2;

_gunner = ObjNull;
_munition = "";


{
	if (alive _x) then
	{
		_vehicle = _x;
		if (!(_vehicle isKindOf "CAManBase")) then
		{
			if (!IsNull (gunner _vehicle)) then
			{
				if (alive (gunner _vehicle)) then
				{
					_mags = magazinesAmmo _vehicle;
					_gun = false;
					{
						if (_x select 1 > 0) then
						{
							_ammo = tolower gettext (configFile >> "CfgMagazines" >> _x select 0 >> "ammo");
							if (_ammo isKindOf "ShellBase") exitWith
							{
								_gun = true;
								_munition = _x select 0;
							};
						};
					} forEach _mags;
					
					if (_gun) then
					{
						_gunner = gunner _vehicle;
					};
				};
			}
		};
	};
} forEach _assignedvehicles;

if (!IsNull _gunner) then
{
	_weapon = (weapons (vehicle _gunner)) select 0;
	_gunner selectWeapon _weapon;
	_targetpos = getposATL _target;
	[_gunner,_targetpos,1.5] call UPSMON_DOwatch;
	sleep 2;
	_gunner doTarget _target;
	sleep 2;
	if (alive _gunner) then
	{
		if ([_gunner,_target,1000,270] call UPSMON_HasLos) then
		{
			_grp setVariable ["UPSMON_GrpinAction",true];
			(vehicle _gunner) fire _weapon;
			sleep 2;
			_gunner dowatch ObjNull;
		};
	};
};
