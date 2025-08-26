
private ["_npc"];

_npc = _this select 0;
_grp = group _npc;

if (!IsNull _npc && alive _npc && _grp in UPSMON_NPCs) then
{
	_grp setVariable ["UPSMON_Removegroup",true];

	waituntil {!alive _npc || !(_grp in UPSMON_NPCs)};

	if (alive _npc) then
	{
		_this execvm "Scripts\UPSMON.sqf";
	};
 };