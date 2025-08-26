/****************************************************************
File: UPSMON_BackToNormal.sqf
Author: Azroul13

Description:

Parameter(s):
	<--- group
Returns:
	Nothing
****************************************************************/
private["_npc","_Ucthis","_behaviour"];	

_grp = _this select 0;

_grp setVariable ["UPSMON_Grpstatus","GREEN"];

if (_grp getVariable ["UPSMON_NOWP",0] > 0) then
{
	[_grp,((_grp getVariable "UPSMON_Origin") select 0),"MOVE",((_grp getVariable "UPSMON_Origin") select 1),((_grp getVariable "UPSMON_Origin") select 2),((_grp getVariable "UPSMON_Origin") select 3),"YELLOW",1] spawn UPSMON_DocreateWP;
}
else
{
	_grp setbehaviour ((_grp getVariable "UPSMON_Origin") select 1);
	_grp setspeedmode ((_grp getVariable "UPSMON_Origin") select 2);
	_grp setformation ((_grp getVariable "UPSMON_Origin") select 3);
};

_grp setVariable ["UPSMON_Grpmission",_grp getVariable "UPSMON_OrgGrpmission"];
