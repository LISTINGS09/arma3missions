if (!isServer) exitWith {};

_fireTeams = [
    ["B_Soldier_TL_F","B_Soldier_AR_F","B_Soldier_AR_F","B_Soldier_LAT_F","B_Soldier_F","B_Soldier_F"],
    ["B_Soldier_TL_F","B_Soldier_AR_F","B_Soldier_M_F","B_Soldier_LAT_F","B_Soldier_F","B_Soldier_F"],
    ["B_Soldier_TL_F","B_Soldier_AR_F","B_medic_F","B_Soldier_LAT_F","B_Soldier_F","B_Soldier_F"],
    ["B_Soldier_TL_F","B_Soldier_AR_F","B_Soldier_A_F","B_Soldier_LAT_F","B_Soldier_F","B_Soldier_F"]
];

_units = [];

_grp = createGroup west;
{
    _units pushBack (_grp createUnit [_x,position _this, [], 0, "FORM"]);
    sleep .5;
} forEach (_fireteams call BIS_fnc_selectRandom);
[_grp, position _this, 150] call BIS_fnc_taskPatrol;

for "_i" from 1 to 2 do {
    _grp = createGroup west;
    {
        _units pushBack (_grp createUnit [_x,position _this, [], 0, "FORM"]);
        sleep .5;
    } forEach (_fireteams call BIS_fnc_selectRandom);
    _grp addWaypoint [position _this, 50] setWaypointType "HOLD";
};

_units execVM "f\setAISkill\f_setAISkill.sqf";
_units execVM "f\assignGear\f_assignGear_AI.sqf";