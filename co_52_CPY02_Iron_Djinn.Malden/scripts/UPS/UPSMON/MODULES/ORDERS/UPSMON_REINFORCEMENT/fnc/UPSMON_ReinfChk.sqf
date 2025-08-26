/****************************************************************
File: UPSMON_GetReinfPos.sqf
Author: Azroul13

Description:
	The script will assign a combat waypoint to the group

Parameter(s):
	<--- Group
	<--- lastposition
Returns:
	nothing
****************************************************************/

private ["_grp","_ratio","_typeOfgrp","_result"];
	
_grp = _this select 0;
_ratio = _this select 1;
_typeOfgrp = _this select 2;

_result = false;

if (UPSMON_reinforcement) then
{ 
	if (!(_grp getVariable ["UPSMON_ONRADIO",false])) then
	{
		if (_ratio >= 1) then
		{
			if (_grp getVariable ["UPSMON_Grpmission",""] != "AMBUSH") then
			{
				if (_grp getVariable ["UPSMON_Grpmission",""] != "RETREAT") then
				{
					if (!("air" in _typeOfgrp)) then
					{
						_result = true;
					};
				};
			}
		};
	};
};

_result