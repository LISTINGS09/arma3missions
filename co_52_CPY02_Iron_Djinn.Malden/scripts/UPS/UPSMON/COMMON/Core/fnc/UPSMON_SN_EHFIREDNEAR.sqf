/****************************************************************
File: UPSMON_SN_EHFIREDNEAR.sqf
Author: Rafalsky

Description:

Parameter(s):

Returns:
	
****************************************************************/	
private ["_unit","_shooter","_dist"];

_unit = _this select 0;
_shooter = _this select 1;
_dist = _this select 2;

if (alive _unit) then
{
	if (!(_unit getVariable ["UPSMON_Civfleeing",false])) then
	{
		["FLEE",_unit,_shooter,_dist] spawn UPSMON_Civaction;
	};
};
