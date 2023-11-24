if !(isServer) exitWith {};
_garrisons = ["garrisonLogic"] call ws_fnc_collectObjects;
_units = [];
{
    _unitsx = ((_x getVariable "ws_garrisonSettings") call ws_fnc_createGarrison);
    _units append _unitsx;
} forEach _garrisons;

_units execVM "f\setAISkill\f_setAISkill.sqf";
