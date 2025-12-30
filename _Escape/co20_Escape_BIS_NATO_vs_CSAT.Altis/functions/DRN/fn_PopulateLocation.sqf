if (!isServer) exitWith {};

params ["_locationObject", "_side", "_maxGroupsCount", ["_debug", false]];

_locationObject params ["_markerName", "_null", "_soldierObjects", "_locationPos"];

private _maxGroupSize = ceil ((count _soldierObjects) / _maxGroupsCount);

if (_debug) then {
    player sideChat "Populating location '" + _markerName + "'";
};

diag_log format["[ESCAPE]: Populating Location: %1 [%5] (%2) - %3 units in %4 groups", _markerName, _locationPos, count _soldierObjects, _maxGroupSize, _side];

private _groupMemberCount = _maxGroupSize;

private _group = createGroup [_side, true];
private _spawnPos = [_markerName] call drn_fnc_CL_GetRandomMarkerPos;

{
	private _soldierObject = _x;
	
	_x params ["_soldierType", "_skill", "_spawned", "_damage"];
	
    if ((!_spawned) && _damage < 0.75) then {
		if (count units _group > _maxGroupSize) then {
			if (_forEachIndex > 0) then { sleep 1 };
            _group = createGroup [_side, true];            
            _spawnPos = [_markerName] call drn_fnc_CL_GetRandomMarkerPos;
        };
        
        private _soldier = _group createUnit [_soldierType, _spawnPos, [], 0, "FORM"];
		
        _soldier setDamage _damage;
		_soldier call drn_fnc_Escape_OnSpawnGeneralSoldierUnit;
		
        if (count units _group == 1) then {
			_soldier setUnitRank "SERGEANT";
			private _script = [_group, _markerName] spawn A3E_fnc_Patrol;
			_group setVariable["A3E_GroupPatrolScript", _script];
        };

		_soldierObject set [2, true];
		_soldierObject set [4, _soldier];
	};
} forEach _soldierObjects;

_garrison = [_side, nil, _markername, _locationObject] spawn drn_fnc_GarrisonUnits;