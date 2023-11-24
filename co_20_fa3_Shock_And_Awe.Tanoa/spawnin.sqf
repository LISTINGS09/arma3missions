if ((isNil "hc" && !isServer) || (!isNil "hc" && (isServer || hasInterface))) exitWith {};

_spawns = [zone1spawn,zone2spawn,zone3spawn] call ws_fnc_collectObjectsNum;

_groups = [];

while {true} do {
	if ({toLower faction _x == "blu_ctrg_f"} count playableUnits == 0) exitWith {};
	_target = playableUnits call BIS_fnc_selectRandom;
	while {toLower faction _target != "blu_ctrg_f"} do {
		_target = playableUnits call BIS_fnc_selectRandom;
	};

	systemChat "Workgin!";
	
	if ({side _x == independent || side _x == east} count allUnits < 130) then {
		// weed out bad spawns (too close to CTRG or too many men spawned here
		// bad spawns are bad spawns forever to prevent cleared buildings from magically repopulating
		_idx = 0;
		while {_idx < count _spawns} do {
			_spawn = _spawns select _idx;
			if ({toLower faction _x == "blu_ctrg_f" && _x distance _spawn < 150} count playableUnits > 0 ||
				_spawn getVariable ["timesUsed",0] >= 2) then {
				_spawns deleteAt _idx;
			} else {
				_idx = _idx + 1;
			};
		};
		
		if (count _spawns == 0) exitWith {};
		
		// pick a close-ish spawn
		_closestDistance = 999999999;
		{
			if (_x distance _target < _closestDistance) then {
				_closestDistance = _x distance _target;
			};
		} forEach _spawns;
		_potentialSpawns = [];
		{
			if (_x distance _target < _closestDistance + 150 max 350) then {
				_potentialSpawns pushBack _x;
			};
		} forEach _spawns;
		_spawn = _potentialSpawns call BIS_fnc_selectRandom;

		{
			if (_x distance _spawn < 75) then {
				_x setVariable ["timesUsed",(_x getVariable ["timesUsed",0]) + 1];
			};
		} forEach _spawns;
		
		/*
		_marker = createMarker [format ["%1",random 1],position _spawn];
		_marker setMarkerShape "ICON";
		_marker setMarkerType "mil_circle";
		_marker spawn {
			_t0 = time;
			waitUntil {
				_scale = .5 - ((_t0 - time) / 30);
				_this setMarkerSize [_scale,_scale];
			};
		};
		*/
		if (random 1 < .75) then {
			_grp = createGroup independent;
			{ _grp createUnit [_x,getPosATL _spawn,[],0,"NONE"] } forEach ["I_C_Soldier_Para_2_F","I_C_Soldier_Para_4_F","I_C_Soldier_Para_1_F","I_C_Soldier_Para_1_F","I_C_Soldier_Para_1_F","I_C_Soldier_Para_1_F"];
			[units _grp,"f\assignGear\f_assignGear_AI.sqf"] remoteExec ["execVM",2];
			_grp setBehaviour "COMBAT";
			_grp addWaypoint [getPosATL _spawn,0] setWaypointType "SAD";
			_groups pushBack _grp;
			_grp deleteGroupWhenEmpty true;
			_grp enableDynamicSimulation true;
		} else {
			_grp = createGroup east;
			{ _grp createUnit [_x,getPosATL _spawn,[],0,"NONE"] } forEach ["O_T_Soldier_TL_F","O_T_Soldier_AR_F","O_T_Soldier_F","O_T_Soldier_F","O_T_Soldier_F","O_T_Soldier_F"];
			_grp setBehaviour "getPosATL";
			_grp addWaypoint [position _spawn,0] setWaypointType "SAD";
			_groups pushBack _grp;
			_grp deleteGroupWhenEmpty true;
			_grp enableDynamicSimulation true;
		};
	};
	
	// every so often send a group to hunt down ctrg
	if (random 1 < .4) then {
		_wp = _groups call BIS_fnc_selectRandom addWaypoint [[getPosATL _target,random 100,random 360] call BIS_fnc_relPos,0];
		_wp setWaypointBehaviour "COMBAT";
		_wp setWaypointType "SAD";
	};
	
	sleep 20;
};