/****************************************************************
File: UPSMON_GetGroupformation.sqf
Author: Azroul13

Description:
	Get unit behaviour
Parameter(s):
	<--- leader
	<--- UPSMON parameters
Returns:
	---> formation
****************************************************************/
private["_npc","_Ucthis","_formation"];	

_npc = _this select 0;
_Ucthis = _this select 1;

_formation = Formation _npc;

// set formation modes (or not)
if ("COLUMN" in _UCthis) then {_formation = "COLUMN";};
if ("STAG COLUMN" in _UCthis) then {_formation = "STAG COLUMN";};
if ("WEDGE" in _UCthis) then {_formation = "WEDGE";};
if ("VEE" in _UCthis) then {_formation = "VEE";};
if ("LINE" in _UCthis) then {_formation = "LINE";};	
if ("FILE" in _UCthis) then {_formation = "FILE";};	

_formation	
