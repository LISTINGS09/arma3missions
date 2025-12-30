private["_static","_gunner","_group","_side","_possibleInfantryTypes","_unit"];
params [["_static",objNull], ["_side",A3E_VAR_Side_Ind]];

if !(_static emptyPositions "gunner" > 0)  exitWith {};

private _group = createGroup [_side, true];
_group enableDynamicSimulation true;
private _possibleInfantryTypes = if (_side == A3E_VAR_Side_Ind) then { a3e_arr_Escape_InfantryTypes_Ind } else { a3e_arr_Escape_InfantryTypes };

if !(isNull _static) then {
	_unit = _group createUnit [selectRandom _possibleInfantryTypes, getPos _static, [], 5, "NONE"];    
	_unit assignAsGunner _static;
	_unit moveInGunner _static;
	[_unit] call A3E_fnc_onEnemySoldierSpawn;
} else {
	_unit = objNull;
};

_unit