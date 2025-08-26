/****************************************************************
File: UPSMON_artilleryBatteryout.sqf
Author: Azroul13

Description:
		Mortar units repack the static weapon
Parameter(s):

Returns:
	nothing
****************************************************************/
private ["_batteryunits","_staticteam"];

_batteryunits = _this select 0;

if (typename (_batteryunits select 0) == "ARRAY") then
{
	_staticteam = _batteryunits select 0;
	{
		if (!alive _x) exitWith {_batteryunits = [];};
	} forEach _staticteam; 
				
	if (count _batteryunits > 0) then
	{
		[_staticteam select 0,_staticteam select 1] call UPSMON_Packbag;
	};
		
};