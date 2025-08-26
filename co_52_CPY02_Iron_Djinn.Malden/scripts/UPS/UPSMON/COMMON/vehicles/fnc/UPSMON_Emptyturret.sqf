/****************************************************************
File: UPSMON_Emptyturret.sqf
Author: Azroul13

Description:
	Get number of empty turret
Parameter(s):
	<--- vehicle
Returns:
	number
****************************************************************/

private ["_turretpath","_number"];

_turretpath = _this call UPSMON_fnc_commonTurrets;
	
_number = 0;
	
{
	if (IsNull (_this turretUnit _x)) then {_number = _number + 1;};
} forEach _turretpath;
	
_number
