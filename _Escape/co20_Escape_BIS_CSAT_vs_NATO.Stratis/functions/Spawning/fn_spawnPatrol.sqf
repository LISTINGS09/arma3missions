params["_pos","_side","_count"];

_count = _count - 1;
private _possibleInfantryTypes = if(_side == A3E_VAR_Side_Opfor) then { missionNameSpace getVariable ["a3e_arr_Escape_InfantryTypes",[]] } else { missionNameSpace getVariable ["a3e_arr_Escape_InfantryTypes_Ind",[]] };

if(count _possibleInfantryTypes <= 0) then {
	["Escape warning: Infantry array for village initialization is empty. a3e_arr_Escape_InfantryTypes may contain an error."] call a3e_fnc_debugmsg;
};

private _leaderArray = _possibleInfantryTypes;
private _unitArray = _possibleInfantryTypes;

//Create a Group
private _group = createGroup [_side, true];

[format["Creating %2 Group at %1 (%3)",_pos,_side,_count]] call a3e_fnc_debugmsg;

_unit = _group createUnit [selectRandom _leaderArray, _pos, [], 0, "FORM"];
[_unit] spawn A3E_fnc_onEnemySoldierSpawn;

for "_i" from 1 to _count do {
   _unit = _group createUnit [selectRandom _unitArray, _pos, [], 0, "FORM"];
   [_unit] spawn A3E_fnc_onEnemySoldierSpawn;
};

_group