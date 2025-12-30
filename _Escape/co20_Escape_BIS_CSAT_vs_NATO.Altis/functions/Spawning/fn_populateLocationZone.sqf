params["_zoneIndex"];

private _zone = A3E_Zones select _zoneIndex;
private _marker = _zone get "marker";
private _area = _zone get "zonearea";
private _side = _zone getorDefault ["side",A3E_VAR_Side_Ind];
private _type = _zone get "type";

private _patrolCount = switch(_type) do {
	case "COMCENTER": {	10 };
	case "MORTAR": { 4 };
	case "AMMODEPOT": { 6 };
	case "MOTORPOOL": { 8 };
	case "ROADBLOCK": { 2 };
	default { 4 };
};

private _groups = _zone getOrDefault ["groups",[]];
private _buildingsPositions = [_marker] call a3e_fnc_getBuildingsInMarker;

//Spawn some random units in the buildings:
private _guardCount = (4 max (_patrolCount * 0.8)) min count(_buildingsPositions);

[format["Populate Zone %1 - Garrison %2 - Patrols %3",_zoneIndex, _guardCount, _patrolCount],["Spawning","Garrison"],[_buildingsPositions]] call a3e_fnc_log;

private _possibleInfantryTypes = if(_side == A3E_VAR_Side_Opfor) then { a3e_arr_Escape_InfantryTypes } else { a3e_arr_Escape_InfantryTypes_Ind };

if (count _buildingsPositions > 0) then {
	//Garrison groups
	private _garrisonGrp = [[_marker] call BIS_fnc_randomPosTrigger,_side,_guardCount] call A3E_FNC_spawnPatrol;
	_groups pushBack _garrisonGrp;
	{
		private _bpos = selectRandom _buildingsPositions;
		if (count _bpos > 0) then { _x disableAI "PATH"; _x setPosATL _bpos };
	} forEach (units _garrisonGrp);
	// [_garrisonGrp, _marker] call A3E_fnc_GuardBuilding;
};

//General purpose patrol groups
for "_i" from 1 to _patrolCount do {
	private _pos = [_marker] call BIS_fnc_randomPosTrigger;
	private _unitCount = [] call a3e_fnc_getDynamicSquadSize;
	private _grp = [_pos,_side,_unitCount] call A3E_FNC_spawnPatrol;
	_groups pushBack _grp;
	[_grp, _marker] call A3E_fnc_Guard;
	sleep 0.1;
};
_zone set ["groups",_groups];