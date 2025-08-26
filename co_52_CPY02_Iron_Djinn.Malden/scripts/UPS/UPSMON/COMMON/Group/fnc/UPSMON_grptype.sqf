/****************************************************************
File: UPSMON_grptype.sqf
Author: Azroul13

Description:
	get the type of the group
Parameter(s):
	<--- leader
Returns:
	----> Group type ("Isman"/"Iscar"/"IsAir"/"Isboat"/"Isdiver")
****************************************************************/
private [];

_npc = _this select 0;
_type = "";

if ("LandVehicle" countType [vehicle _npc]>0) then {_type = "Iscar"};
if ("Ship" countType [vehicle _npc]>0) then {_type = "Isboat"};
if ("Air" countType [vehicle _npc]>0) then {_type = "IsAir"};
if (["diver", (typeOf (leader _npc))] call BIS_fnc_inString) then {_type = "Isdiver"};
if (_type == "") then {_type = "Isman"};

_type