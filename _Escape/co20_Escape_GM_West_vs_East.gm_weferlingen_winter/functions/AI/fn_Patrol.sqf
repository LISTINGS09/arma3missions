params["_group",["_markerName","noMarker"]];
if(!isserver) then { diag_log "Escape Warning: AI patrol script executed locally." };
private _oncomplete = "";

if(_markerName == "noMarker") then {
	_markerName = _group getVariable ["a3e_homeMarker","noMarker"];
};

if((random 100)<=25) then {
	//Switch randomly to House Patrol
	private _houses = nearestObjects [leader _group, ["House", "Building"], 50];
	if(count(_houses) > 0) exitWith {
		[_group,_markerName] spawn A3E_fnc_PatrolBuildings;
	};
};

[_group,"PATROL"] call a3e_fnc_SetTaskState;

private _destinationPos = [];
private _counter = 0;
	
if(_markerName != "noMarker") then {
	_destinationPos = [_markerName] call a3e_fnc_RandomMarkerPos;
	while {surfaceIsWater [_destinationPos select 0, _destinationPos select 1]  && _counter<50} do {
		_destinationPos = [_markerName] call a3e_fnc_RandomMarkerPos;
		_counter = _counter + 1;
	};
	_oncomplete = format["if(isserver) then {[group this,""%1""] spawn a3e_fnc_Patrol;};",_markerName];
	
	_group setVariable ["a3e_homeMarker",_markerName,false];
} else {
	private _leader = (leader _group);
	private _searchRange = 3000;
	private _players = [] call A3E_fnc_GetPlayers;
	_destinationPos = [_players,_searchRange] call a3e_fnc_RandomPatrolPos;
	if(str _destinationPos == "[0,0,0]") then {
		_destinationPos = getpos _leader;
	};
	

	while {(_destinationPos distance _leader)>(_searchRange*1.5) && _counter<50} do {
			_destinationPos = [_players,_searchRange] call a3e_fnc_RandomPatrolPos;
			_counter = _counter + 1;
	};
	_oncomplete = "if(isserver) then {[group this,nil] spawn a3e_fnc_Patrol;};";
};

private _waypoint = [_group,_destinationPos,"MOVE","COLUMN","LIMITED","SAFE",_oncomplete] call a3e_fnc_move;
if(!isNil("_waypoint")) then {
	_waypoint setWaypointTimeout [0, 15, 30];
};