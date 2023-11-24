if !(isServer) exitWith {};
_garrisons = [garrisonLogic] call ws_fnc_collectObjectsNum;
_units = [];
{
_units append ((_x getVariable "ws_garrisonSettings") call ws_fnc_createGarrison);
} forEach _garrisons;

_units execVM "f\setAISkill\f_setAISkill.sqf";

{
    if (_x isKindOf "I_Soldier_lite_F") then {
        ["smg",_x] call f_fnc_assignGear;
    };
} forEach _units;
