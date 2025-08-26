/****************************************************************
File: UPSMON_Returnbase.sqf
Author: Azroul13

Description:
	Make the transport return to the base

Parameter(s):
	<--- Vehicle
Returns:
	nothing
****************************************************************/

private["_transport","_grp","_basepos"];				

_transport = _this select 0;
_grp = group _transport;

_basepos = (_grp getVariable "UPSMON_Origin") select 0;

if (!alive _transport) exitWith{};

if (_transport isKindOf "Air") then
{
	_grp setVariable ["UPSMON_Transportmission",["LANDBASE",_basepos,ObjNull]];
	_grp setVariable ["UPSMON_ChangingLZ",false];
	[_grp,_basepos,"MOVE","COLUMN","FULL","CARELESS","YELLOW",1,UPSMON_flyInHeight] call UPSMON_DocreateWP;
}
else
{
	_grp setVariable ["UPSMON_Transportmission",["RETURNBASE",_basepos,ObjNull]];
	[_grp,_basepos,"MOVE","COLUMN","NORMAL","SAFE","YELLOW",1] call UPSMON_DocreateWP;
};