/****************************************************************
File: UPSMON_CreateSmokeCover.sqf
Author: Azroul13

Description:
	Throw a grenade
Parameter(s):

Returns:

****************************************************************/
private ["_target","_units","_i","_vehicle","_role","_mags"];	

_units = _this select 0;
_targetpos = _this select 1;

_i = 0;

{
	if (_i >= 3) exitWith {};
	if (alive _x) then
	{
		if (vehicle _x == _x) then
		{
			if (!([_x] call UPSMON_InBuilding)) then
			{
				if ("SmokeShell" in (magazines _x)) then
				{
					if (_x getVariable ["UPSMON_Supstate",""] != "SUPRESSED") then
					{
						_targetpos = [(_targetpos select 0) + ((random 10) - (random 20)) , (_targetpos select 1) + ((random 10) - (random 15)),_targetpos select 2]; 
						[_x,_targetpos] spawn UPSMON_throw_grenade;
						_i = _i + 1;
					};
				};
			};
		}
		else
		{
			_vehicle = vehicle _x;
			if (getNumber  (configFile >> "CfgVehicles" >> typeOf _vehicle >> "gunnerHasFlares") > 0) then
			{
				_role = assignedVehicleRole _vehicle;
				if (count _role > 1) then
				{
					_mags = _vehicle weaponsTurret (_role select 1);
					_smoke = false;
					{
						if (_x == "SmokeLauncher") then
						{
							_smoke = true;
						};
					} forEach _mags;
					
					if (_smoke) then
					{
						_i = 3;
						[_vehicle] call UPSMON_DoSmokeScreen;
					};
				};
			};
		};
	};
} forEach _units;