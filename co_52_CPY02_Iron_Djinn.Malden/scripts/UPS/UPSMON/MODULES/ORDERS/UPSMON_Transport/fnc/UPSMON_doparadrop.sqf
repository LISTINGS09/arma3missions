/****************************************************************
File: UPSMON_doparadrop.sqf
Author: Azroul13

Description:
	Eject the group from the helicopter. 

Parameter(s):
	<--- Vehicle which unload his cargo
	<--- Group disembarking
Returns:
	nothing
****************************************************************/

private["_transport","_grp","_unitsout","_grps"];				

_transport = _this select 0;
_unitsout = _this select 1;
_grp = _this select 2;

_transport setVariable ["UPSMON_disembarking",true];
_grp setVariable ["UPSMON_disembarking",true];


_grps = [];
_grps pushBack _grp;

if (!alive _transport) exitWith{};	

{
	if (!(group _x in _grps)) then {_grps pushBack (group _x)};
} forEach _unitsout;

{
	_x setVariable ["UPSMON_disembarking",true];
} forEach _grps;

//dogetout each of _jumpers
[_transport,_unitsout] call UPSMON_EjectUnits;

sleep 3;

[_transport] call UPSMON_Returnbase;

_timeout = 100 + time;
	
//Waits until all getout of heli
{
	waituntil {!canMove _x || !alive _x || movetofailed _x  || time > _timeout || isTouchingGround _x};
	_x switchMove "AmovPercMstpSrasWrflDnon";
} forEach _unitsout;


_transport setVariable ["UPSMON_disembarking",false];
{
	_x setVariable ["UPSMON_disembarking",false];
	if (_x getVariable ["UPSMON_InTransport",false]) then {_x setVariable ["UPSMON_InTransport",false]};
	if (_x getVariable ["UPSMON_Grpmission",""] == "WAITTRANSPORT") then {_x setVariable ["UPSMON_Grpmission","PATROL"]};
} forEach _grps;