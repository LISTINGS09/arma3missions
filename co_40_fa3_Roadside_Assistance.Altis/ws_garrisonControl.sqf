if !(isServer) exitWith {};
_garrisons = ["garrisonLogic"] call ws_fnc_collectObjects;
_units = [];
_groups = [];
{
    _unitsx = ((_x getVariable "ws_garrisonSettings") call ws_fnc_createGarrison);
    _units append _unitsx;
    _groups pushBack group (_unitsx select 0);
} forEach _garrisons;

_units execVM "f\setAISkill\f_setAISkill.sqf";

_groups spawn {
    waitUntil {hostagesRescued};

    {
        _grp = createGroup east;
        units _x joinSilent _grp;
        _wp = _grp addWaypoint [position leader _grp,50];
        _wp setWaypointType "SAD";
    } forEach _this;
};