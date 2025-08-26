/****************************************************************
File: UPSMON_surrended.sqf
Author: MONSADA

Description:
	Function to surrender AI soldier
Parameter(s):

Returns:

****************************************************************/
private ["_grp"];

_grp = _this select 0;

UPSMON_NPCs = UPSMON_NPCs - [_grp];

{
	if (alive _x) then
	{
		[_x] spawn UPSMON_DoSurrender;
	};
} forEach units _grp;