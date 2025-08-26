/****************************************************************
File: UPSMON_PLANASSLT.sqf
Author: Azroul13

Description:
	The script will assign a patrol waypoint to the group

Parameter(s):
	<--- Group
	<--- attack position
	<--- last attack position
	<--- Type of group
Returns:
	nothing
****************************************************************/

private ["_grp","_attackpos","_lastattackpos","_typeOfgrp","_time","_attackdist"]; 
	
_grp = _this select 0;
_attackpos = _this select 1;
_lastattackpos = _this select 2;
_typeOfgrp = _this select 3;
_dist = _this select 4;
	
_grp setVariable ["UPSMON_Grpmission","ASSAULT"];

if (!(_grp getVariable ["UPSMON_searchingpos",false])) then
{
	_attackdist = 1000;
	if (count _lastattackpos > 0) then
	{
		_attackdist = ([_lastattackpos,_attackpos] call UPSMON_distancePosSqr);
	};

	if (_attackdist > 50 || count(waypoints _grp) == 0 || (_grp getVariable ["UPSMON_LastGrpmission",""] != "ASSAULT")) then
	{
		if (_grp getVariable ["UPSMON_TIMEORDER",time] <= time) then
		{
			[_grp,_attackPos,_typeOfgrp,_dist] spawn UPSMON_DOASSAULT;
			_time = time + 10;
			_grp setVariable ["UPSMON_TIMEORDER",_time];
		};
	};
};