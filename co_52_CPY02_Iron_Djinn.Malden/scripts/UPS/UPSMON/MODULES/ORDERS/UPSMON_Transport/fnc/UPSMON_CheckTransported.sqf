/****************************************************************
File: UPSMON_CheckTransport.sqf
Author: Azroul13

Description:
	Return if the group keep doing transport

Parameter(s):
	<--- Group
Returns:
	Group transported
****************************************************************/

private["_grp","_grouptransported"];				

_grp = _this select 0;
_grouptransported = ObjNull;

if (!IsNull ((_grp getVariable ["UPSMON_Transportmission",[]]) select 2)) then 
{
	if ({alive _x && !(captive _x)} count units ((_grp getVariable ["UPSMON_Transportmission",[]])select 2) > 0) then
	{
		if (_grp getVariable ["UPSMON_Grpmission",""] == "WAITTRANSPORT") then
		{
			_grouptransported = (_grp getVariable ["UPSMON_Transportmission",[]])select 2;
		};
	};
};

_grouptransported