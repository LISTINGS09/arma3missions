/****************************************************************
File: UPSMON_DORETREAT.sqf
Author: Azroul13

Description:
	
Parameter(s):
	<--- Group
	<--- position of the target)

Returns:
	nothing
****************************************************************/

private [_grp"","_AttackPos","_typeOfgrp","_assignedvehicles","_dir","_npc","_dist","_retreatPos","_behaviour","_combatmode","_wpformation","_speedmode"]; 	

_grp = _this select 0;
_AttackPos = _this select 1;
_typeOfgrp = _this select 2;
_assignedvehicles = _this select 3;

_dir = [];
_npc = leader _grp;
_dist = 100;

_grp setVariable ["UPSMON_searchingpos",true];

if ("car" in _typeOfgrp || "ship" in _typeOfgrp || "air" in _typeOfgrp) then
{
	_dist = 500;
};

if ("arti" in _typeOfgrp) then
{
	[_grp,_assignedvehicles,_grp getVariable ["UPSMON_GrpTarget",ObjNull]] call UPSMON_FireGun;
};
	
	
if (_AttackPos select 0 != 0 && _AttackPos select 1 != 0) then
{
	// angle from unit to target
	_dir1 = [_AttackPos,getposATL _npc] call UPSMON_getDirPos;
	_dir = [_dir1 +290,_dir1 +70];
}
else
{
	_dir = [getposATL _npc,(_grp getVariable "UPSMON_Origin") select 2] call UPSMON_getDirPos;
};
	
_retreatPos = [_npc,_AttackPos,_dir,_dist] call UPSMON_SrchRetreatPos;
		
_behaviour = "CARELESS";
_CombatMode = "BLUE";			
if (UPSMON_Debug>0) then {player sidechat format["%1 All Retreat!!!",_npc]};
_wpformation = "LINE";
_speedmode = "FULL";
	
[_grp,_targetpos,_wptype,_wpformation,_speedmode,_behaviour,_CombatMode,1] spawn UPSMON_DocreateWP;

_grp setVariable ["UPSMON_searchingpos",false];	
