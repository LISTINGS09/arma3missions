/*
	Author: 2600K / Josef Zemanek

	Description:
	Enemy Reinforcements Spawner
	
	_nul = [getMarkerPos "Objective"] execVM "scripts\qrfSpawn.sqf";
	
	Any marker containing text 'safezone' will not spawn units.
	Any marker containing text 'spawn' will act as an additional spawn point.
*/

if !isServer exitWith {};

params [
	"_location",		// Hunt/Search location.
	["_delay", 400],	// Seconds between waves.
	["_waveMax",5],		// Maximum Wave #
	["_spawnDist",1500]	// Spawning Distance
];

switch (typeName _location) do {
	case "STRING": {_location = getMarkerPos _location};
	case "OBJECT": {_location = getPos _location};
};

if !(_location isEqualType []) exitWith { "Invalid Object/Position" call BIS_fnc_errorMsg; };

// Configuration - Pick ONE side.
// EAST - FIA
_side = EAST;
_Soldier = ["O_G_Soldier_SL_F","O_G_Soldier_AR_F","O_G_Soldier_LAT_F","O_G_Soldier_F"];
_Sentry = [configFile >> "CfgGroups" >> "East" >> "OPF_G_F" >> "Infantry" >> "O_G_InfTeam_Light"];
_Team = [configFile >> "CfgGroups" >> "East" >> "OPF_G_F" >> "Infantry" >> "O_G_InfTeam_Light"];
_Squad = [configFile >> "CfgGroups" >> "East" >> "OPF_G_F" >> "Infantry" >> "O_G_InfSquad_Assault"];
_Truck = ["O_G_Van_01_transport_F"];
_Light = ["O_G_Offroad_01_armed_F","O_G_Offroad_01_AT_F","O_MRAP_02_hmg_F","O_LSV_02_armed_F"];
_Medium = [["I_APC_Wheeled_03_cannon_F","[_grpVeh,['Guerilla_01',1],TRUE] call BIS_fnc_initVehicle;"],["I_APC_Wheeled_03_cannon_F","[_grpVeh,['Guerilla_03',1],TRUE] call BIS_fnc_initVehicle;"]];
_Heavy = ["O_APC_Tracked_02_AA_hex_F",["O_MBT_04_cannon_F","[_grpVeh,['Grey',1],['showCamonetHull',1,'showCamonetTurret',0]] call BIS_fnc_initVehicle;"],["O_MBT_04_cannon_F","[_grpVeh,['Jungle',1],TRUE] call BIS_fnc_initVehicle;"]];
_Air = ["O_Heli_Light_02_unarmed_F","O_Heli_Transport_04_bench_F"];
_CAS = ["B_Heli_Light_01_dynamicLoadout_F"];

// Functions.
ZRF_fnc_CreateReinforcements = {
	params [
		"_targetPos",
		"_posArray",
		"_side",
		"_unitClass"
	];
	
	_reinfGrp = grpNull;
	_grpVeh = objNull;
	_vehType = "";
	_sleep = TRUE;
	_tooClose = FALSE;
	_dir = 0;
	_customInit = "";
	
	if (count _posArray == 0) exitWith {};
	
	_startingPos = selectRandom _posArray;
	_startingPos set [2,0];
	_dir = _startingPos getDir _targetPos;
	_manArray = missionNamespace getVariable [format["ZRF_%1Soldier", _side], ["B_Soldier_F"]];
	
	// If _unitClass is array, extract the custom init.
	if (_unitClass isEqualType []) then {
		_customInit = _unitClass select 1;
		_unitClass = _unitClass select 0;
	};
	
	// Check if _unitClass is an air vehicle.
	_isAir = FALSE;
	if (_unitClass isEqualType "") then {
		if ("Air" in ([(configFile >> "CfgVehicles" >> _unitClass), TRUE] call BIS_fnc_returnParents)) then { _isAir = TRUE };
	};
	
	// Don't spawn object if too close to any players.
	_maxDist = if _isAir then {1000} else {500};
	{
		if (alive _x && _x distance2D _startingPos < _maxDist) exitWith { _tooClose = true};
	} forEach (playableUnits + switchableUnits);
	
	if _tooClose exitWith { [_targetPos, _posArray, _side, _unitClass] spawn ZRF_fnc_CreateReinforcements; };
	
	if (_unitClass isEqualType "") then {
		_vehType = toLower getText (configFile >> "CfgVehicles" >> _unitClass >> "vehicleClass");
		_veh = createVehicle [_unitClass, _startingPos, [], 0, if _isAir then {"FLY"} else {"NONE"}];
	
		if _isAir then {
			_sleep = FALSE;
			_veh setDir (_veh getDir _targetPos);
		} else {
			_veh setDir _dir;
		};
		
		if (_vehType == "car") then {
			_soldierArr = [];
		
			for [{_i = 1}, {_i <= count (fullCrew [_veh, "", true])}, {_i = _i + 1}] do {
				_soldierArr pushBack (selectRandom _manArray);
			};
		
			_reinfGrp = [[_veh, 15, random 360] call BIS_fnc_relPos, _side, _soldierArr] call BIS_fnc_spawnGroup;
			_grpVeh = _veh;
			_reinfGrp addVehicle _grpVeh;
			_wp = _reinfGrp addWaypoint [position _veh, 0];
			_wp setWaypointType "GETIN NEAREST";
		} else {
			createVehicleCrew _veh;
			
			// Convert crew if using another faction vehicle.
			if (([getNumber (configFile >> "CfgVehicles" >> _unitClass >> "Side")] call BIS_fnc_sideType) != _side) then {
				_reinfGrp = createGroup _side;
				(crew _veh) join _reinfGrp;
			};
			
			_reinfGrp = group effectiveCommander _veh;
			_grpVeh = vehicle leader _reinfGrp;
		};
	} else {
		_reinfGrp = [_startingPos, _side, _unitClass] call BIS_fnc_spawnGroup;
		_grpVeh = (position leader _reinfGrp) nearestObject "Car";
		
			if (leader _reinfGrp distance2D _grpVeh < 75) then {
				_vehType = "car";
				{unassignVehicle _x; [_x] orderGetIn FALSE} forEach units _reinfGrp;
				_reinfGrp addVehicle _grpVeh;	
				_wp = _reinfGrp addWaypoint [position _grpVeh, 0];
				_wp setWaypointType "GETIN NEAREST";
		};
	};
	
	// Run custom init for vehicle (set camos etc).
	if !(_customInit isEqualTo "") then { call compile _customInit; };
	
	if !_isAir then {
		_newWP = _reinfGrp addWaypoint [_targetPos, 100];
		_newWP setWaypointType "SAD";
	
		_newWP = _reinfGrp addWaypoint [_targetPos, 100];
		_newWP setWaypointType "GUARD";
		
		if (_vehType == "car") then {
			_null = [_reinfGrp, _startingPos, _grpVeh, _targetPos] spawn {
				params ["_selGrp", "_startPos", "_selVeh", "_destPos"];

				_leader = leader _selGrp;
							
				waitUntil{sleep 15; if (_leader distance2D _destPos < 400 || !alive _leader || !canMove _selVeh) exitWith {true}; false; };
				
				if (!alive _leader || !canMove _selVeh) exitWith {};
				
				[_leader] joinSilent grpNull;
				_newGrp = group _leader;
				
				[commander _selVeh] joinSilent (group _leader);
				[gunner _selVeh] joinSilent (group _leader);
				
				_selGrp leaveVehicle _selVeh;
				{unassignVehicle _x; [_x] orderGetIn FALSE; _x allowFleeing 0} forEach units _selGrp;
				
				waitUntil{sleep 1; if ({vehicle _x == _selVeh} count units _selGrp == 0 || !alive _leader || !canMove _selVeh) exitWith {true}; false; };
				
				if (!alive _leader || !canMove _selVeh) exitWith {};
				
				_leader assignAsDriver _selVeh;
				[_leader] orderGetIn TRUE;
				
				if (vehicle _leader == _selVeh) then {
					_leader setPos position _selVeh;
					_leader moveInDriver _selVeh;
				};
				
				sleep 20;
				
				if (canFire _selVeh) then {
					_newWP = _newGrp addWaypoint [_destPos, 100];
					_newWP setWaypointType "GUARD";
				} else {
					_newWP = _newGrp addWaypoint [_startPos, 0];
					waitUntil{sleep 0.5; if (_selVeh distance2D _startPos < 50 || !alive _leader || !canMove _selVeh) exitWith {true}; false; };
					if (!alive _leader || !canMove _selVeh) exitWith {};
					_selVeh deleteVehicleCrew driver _selVeh;
					deleteGroup _newGrp;
					deleteVehicle _selVeh;
				};
			};
		};
	} else {
		// Unit is a transport.
		_reinfGrp setBehaviour "CARELESS";
		_soldierArr = [selectRandom _manArray];
		
		for [{_i = 1}, {_i <= (([_unitClass, true] call BIS_fnc_crewCount) - ([_unitClass, false] call BIS_fnc_crewCount))}, {_i = _i + 1}] do {
			_soldierArr pushBack (selectRandom _manArray);
		};

		_paraUnit = [[0,0,0], _side, _soldierArr] call BIS_fnc_spawnGroup;
		{
			_x assignAsCargo _grpVeh;
			[_x] orderGetIn TRUE;
			_x moveInCargo _grpVeh;
			_x allowFleeing 0;
		} forEach units _paraUnit;
		
		_landPos = [_targetPos, 300, random 360] call BIS_fnc_relPos;		
		_unloadWP = _reinfGrp addWaypoint [_landPos, 100];
		_unloadWP setWaypointStatements ["TRUE", "(vehicle this) land 'GET OUT'; {unassignVehicle _x; [_x] orderGetIn FALSE} forEach ((crew vehicle this) select {group _x != group this})"];
		_newWP = _reinfGrp addWaypoint [waypointPosition _unloadWP, 0];
		_newWP setWaypointStatements ["{group _x != group this && alive _x} count crew vehicle this == 0", ""];
		
		_weapCount = 0;
		{
			_weapCount = _weapCount + count (vehicle player weaponsTurret _x);
		} forEach ([[-1]] + (allTurrets vehicle player)); 
		
		// If has turrets hang around AO, otherwise despawn.
		if (_weapCount > 1) then {
			_newWP = _reinfGrp addWaypoint [_targetPos, 0];
			_newWP setWaypointType "LOITER";
			_newWP setWaypointBehaviour "AWARE";
		} else {
			_newWP = _reinfGrp addWaypoint [_startingPos, 0];
			_null = [_reinfGrp, _startingPos] spawn {
				params ["_reinfGrp","_startingPos"];
				_heli = vehicle leader _reinfGrp;
				waitUntil{sleep 5; if ((leader _reinfGrp) distance2D _startingPos > 200 || !alive (leader _reinfGrp) || !canMove _heli) exitWith {true}; false; };
				waitUntil{sleep 0.5; if ((leader _reinfGrp) distance2D _startingPos < 200 || !alive (leader _reinfGrp) || !canMove _heli) exitWith {true}; false; };
				if (!alive (leader _reinfGrp) || !canMove _heli) exitWith {};
				{_heli deleteVehicleCrew _x} forEach crew _heli;
				deleteGroup _reinfGrp;
				deleteVehicle _heli;
			};
		};
		for [{_i = 0}, {_i < 3}, {_i = _i + 1}] do {
			_newWP = _paraUnit addWaypoint [_targetPos, 100];
			_newWP setWaypointType "SAD";
		};
		_newWP = _paraUnit addWaypoint [_targetPos, 100];
		_newWP setWaypointType "GUARD";
	};

	if (_sleep) then {
		sleep random 20;
	};
};

// PREPERATION
_safePositions = [];
_spawns = [];

missionNamespace setVariable [format["ZRF_%1Soldier", _side], _Soldier]; // Variable array for function reference.

{	
	if (["safezone", toLower _x] call BIS_fnc_inString) then { _safePositions pushBack _x; };
} forEach allMapMarkers;

// White list custom spawns.
{	
	if (["spawn", toLower _x] call BIS_fnc_inString) then { _spawns pushBack getMarkerPos _x; };
} forEach allMapMarkers;

// Collect all roads 2km around the location that are not in a safe location.
for [{_i = 0}, {_i <= 360}, {_i = _i + 1}] do {
	_pos = [_location, _spawnDist, _i] call BIS_fnc_relPos;
	_roads = (_pos nearRoads 50) select {((boundingBoxReal _x) select 0) distance2D ((boundingBoxReal _x) select 1) >= 25};
	_exclude = false;
	
	{
		if (_pos inArea _x) exitWith {_exclude = true};
	} forEach _safePositions;
	
	if (count _roads > 0 && !_exclude) then {
		_road = _roads select 0;
		if ({_x distance2D _road < 100} count _spawns == 0) then {
			_connected = roadsConnectedTo _road;
			_nearestRoad = objNull;
			{if ((_x distance _location) < (_nearestRoad distance _location)) then {_nearestRoad = _x}} forEach _connected;
			_spawns pushBackUnique position _nearestRoad;
		};
	};
};

// DEBUG: Show Spawn Markers
/*{
	_mrkr = createMarkerLocal [format ["fdfds%1", _forEachIndex], _x];
	(format ["fdfds%1", _forEachIndex]) setMarkerTypeLocal "mil_dot";
	(format ["fdfds%1", _forEachIndex]) setMarkerTextLocal str _forEachIndex;
} forEach _spawns;*/


// MAIN
// Spawn waves.
for [{_wave = 1}, {_wave < _waveMax}, {_wave = _wave + 1}] do {
	// Stop spawns if no-one is nearby.
	if (({ _location distance2D _x < (_spawnDist + 1000) } count (switchableUnits + playableUnits)) isEqualTo 0) exitWith {};
	
	switch (_wave) do {
		case 1: {
			[_location, _spawns, _side, selectRandom _Truck] call ZRF_fnc_CreateReinforcements;
			[_location, _spawns, _side, selectRandom _Light] call ZRF_fnc_CreateReinforcements;
			[_location, _spawns, _side, selectRandom _Air] call ZRF_fnc_CreateReinforcements;
		};
		case 2: {
			[_location, _spawns, _side, selectRandom _Truck] call ZRF_fnc_CreateReinforcements;
			[_location, _spawns, _side, selectRandom _Medium] call ZRF_fnc_CreateReinforcements;
			[_location, _spawns, _side, selectRandom _Air] call ZRF_fnc_CreateReinforcements;
		};
		case 3: {
			[_location, _spawns, _side, selectRandom _Light] call ZRF_fnc_CreateReinforcements;
			[_location, _spawns, _side, selectRandom _Medium] call ZRF_fnc_CreateReinforcements;
			[_location, _spawns, _side, selectRandom _Medium] call ZRF_fnc_CreateReinforcements;
			[_location, _spawns, _side, selectRandom _CAS] call ZRF_fnc_CreateReinforcements;
		};
		case 4: {
			[_location, _spawns, _side, selectRandom _Medium] call ZRF_fnc_CreateReinforcements;
			[_location, _spawns, _side, selectRandom _Medium] call ZRF_fnc_CreateReinforcements;
			[_location, _spawns, _side, selectRandom _Heavy] call ZRF_fnc_CreateReinforcements;
			[_location, _spawns, _side, selectRandom _Air] call ZRF_fnc_CreateReinforcements;
		};
		case 5: {
			[_location, _spawns, _side, selectRandom _Medium] call ZRF_fnc_CreateReinforcements;
			[_location, _spawns, _side, selectRandom _Heavy] call ZRF_fnc_CreateReinforcements;
			[_location, _spawns, _side, selectRandom _Heavy] call ZRF_fnc_CreateReinforcements;
		};
	};

	_tNextWave = time + _delay;	
	waitUntil {sleep 1; time > _tNextWave};
};