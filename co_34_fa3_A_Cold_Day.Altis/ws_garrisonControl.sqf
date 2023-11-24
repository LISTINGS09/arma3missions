if !(isServer) exitWith {};

sleep .01;
_garrisons = ["garrisonLogic"] call ws_fnc_collectObjects;
_units = [];
{
_units append ((_x getVariable "ws_garrisonSettings") call ws_fnc_createGarrison);
} forEach _garrisons;

_units execVM "f\setAISkill\f_setAISkill.sqf";
{
	[_x,{_this spawn dc_fnc_coldBreath}] remoteExec ["BIS_fnc_call",0,true];
} forEAch _units;