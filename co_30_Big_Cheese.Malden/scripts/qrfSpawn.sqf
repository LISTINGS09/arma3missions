/*
	Author: 2600K / Josef Zemanek v1.32

	Description:
	Enemy Reinforcements Spawner
	
	_nul = [getMarkerPos "Objective"] execVM "scripts\qrfSpawn.sqf";
	_nul = [thisTrigger] execVM "scripts\qrfSpawn.sqf";
	
	Any marker containing text 'safezone' will not spawn units.
	Any marker containing text 'spawn' will act as an additional spawn point.
*/
if !isServer exitWith {};

params [
	"_location",		// Hunt/Search location.
	["_delay", 300],	// Seconds between waves.
	["_waveMax",6],		// Maximum Wave #
	["_spawnDist",1500]	// Spawning Distance
];

switch (typeName _location) do {
	case "STRING": {_location = getMarkerPos _location};
	case "OBJECT": {_location = getPos _location};
};

if !(_location isEqualType []) exitWith { systemChat "[QRF] ERROR Invalid Object/Position"; diag_log text "[QRF] ERROR Invalid Object/Position"; };

// Configuration - Pick ONE side.

// EAST - SPETSNAZ (VANILLA)
_side = EAST;
ZMM_EASTMan = ["O_R_Soldier_TL_F","O_R_Soldier_AR_F","O_R_Soldier_LAT_F","O_R_Soldier_GL_F"];
_Sentry = [configFile >> "CfgGroups" >> "East" >> "OPF_R_F" >> "SpecOps" >> "O_R_InfSentry"];
_Team = [configFile >> "CfgGroups" >> "East" >> "OPF_R_F" >> "SpecOps" >> "O_R_InfTeam"];
_Squad = [configFile >> "CfgGroups" >> "East" >> "OPF_R_F" >> "SpecOps" >> "O_R_InfSquad"];
_Truck = [configFile >> "CfgGroups" >> "East" >> "OPF_R_F" >> "SpecOps" >> "O_T_MotInf_Reinforcements"];
_Light = ["O_T_MRAP_02_hmg_ghex_F","O_T_LSV_02_armed_F"];
_Medium = [["O_T_APC_Wheeled_02_rcws_ghex_F","[_grpVeh,false,['showCamonetHull',0.5,'showSLATHull',0.5]] call BIS_fnc_initVehicle;"],["O_T_APC_Tracked_02_cannon_ghex_F","[_grpVeh,false,['showSLATHull',0.5]] call BIS_fnc_initVehicle;"]];
_Heavy = [["O_T_APC_Tracked_02_AA_ghex_F","[_grpVeh,false,['showSLATHull',0.5,'showCamonetHull',0.5,'showCamonetTurret',0.3]] call BIS_fnc_initVehicle;"],["O_T_MBT_02_cannon_ghex_F","[_grpVeh,false,['showCamonetHull',0.5,'showCamonetTurret',0.3]] call BIS_fnc_initVehicle;"],["O_T_MBT_04_cannon_F","[_grpVeh,false,['showCamonetHull',0.5,'showCamonetTurret',0.3]] call BIS_fnc_initVehicle;"]];
_Air = [["O_Heli_Light_02_unarmed_F","[_grpVeh,['Black',1]] call BIS_fnc_initVehicle;"],["O_Heli_Transport_04_bench_F","[_grpVeh,['Black',1]] call BIS_fnc_initVehicle;"]];
_CAS = ["O_T_VTOL_02_infantry_dynamicLoadout_F",["O_Heli_Light_02_dynamicLoadout_F","[_grpVeh,['Black',1]] call BIS_fnc_initVehicle;_grpVeh setPylonLoadout [2,'PylonRack_12Rnd_missiles'];"],["O_Heli_Attack_02_dynamicLoadout_F","[_grpVeh,['Black',1]] call BIS_fnc_initVehicle; _grpVeh setPylonLoadout [1,'PylonRack_19Rnd_Rocket_Skyfire']; _grpVeh setPylonLoadout [4,'PylonRack_19Rnd_Rocket_Skyfire'];"],"O_Plane_CAS_02_dynamicLoadout_F"];

// Functions.
zmm_fnc_spawnUnit = {
	params [
		["_targetPos", []],
		["_posArray", []],
		"_side",
		["_unitClass", ""],
		["_tries", 1]
	];

	if (_unitClass isEqualTo "") exitWith { diag_log format["SpawnUnit - Empty Unit Passed: %1 (%2)", _unitClass, _side] };
	if (_tries > 10) exitWith {};

	systemChat format["SpawnUnit - Passed %1: %2 [%3] Try:%4", _targetPos, _unitClass, _side, _tries];

	private _reinfGrp = grpNull;
	private _grpVeh = objNull;
	private _vehType = "";
	private _sleep = true;
	private _dir = 0;
	private _customInit = "";

	// No positions to use
	if (count _posArray == 0 || count _targetPos == 0) exitWith {};

	// Fix any positions are not in array format
	{
		switch (typeName _x) do {
			case "STRING": { _posArray set [_forEachIndex, getMarkerPos _x] };
			case "OBJECT": { _posArray set [_forEachIndex, getPos _x] };
		};
	} forEach _posArray;

	private _startingPos = selectRandom _posArray;
	_startingPos set [2,0];
	_dir = _startingPos getDir _targetPos;
	private _manArray = missionNamespace getVariable [format["ZMM_%1Man", _side], ["B_Soldier_F"]];

	// If _unitClass is array, extract the custom init.
	if (_unitClass isEqualType []) then { _customInit = _unitClass # 1; _unitClass = _unitClass # 0 };

	// Check if _unitClass is an air vehicle.
	_isAir = false;
	if (_unitClass isEqualType "") then {
		if ("Air" in ([(configFile >> "CfgVehicles" >> _unitClass), true] call BIS_fnc_returnParents)) then { _isAir = true; _startingPos set [2, 500]; };
	};

	// Don't spawn object if too close to any players.
	if ({ alive _x && _x distance2D _startingPos < (if _isAir then {1000} else {500})} count allPlayers > 0 && isMultiplayer) exitWith { 
		sleep 30;
		[_targetPos, _posArray, _side, _unitClass, _tries + 1] call zmm_fnc_spawnUnit;
	};

	if (_unitClass isEqualType "") then {
		_vehType = toLower getText (configFile >> "CfgVehicles" >> _unitClass >> "vehicleClass");
		_vehName = toLower getText (configFile >> "CfgVehicles" >> _unitClass >> "displayName");
		_grpVeh = createVehicle [_unitClass, _startingPos, [], 15, if _isAir then {"FLY"} else {"NONE"}];
		_grpVeh setVehicleLock "LOCKEDPLAYER";
		[_grpVeh,[1, 0.5, 0.5]] remoteExec ["setVehicleTIPars"];

		if _isAir then {
			_sleep = false;
			_grpVeh setDir (_grpVeh getDir _targetPos);
			_grpVeh setVelocity [100 * (sin (_grpVeh getDir _targetPos)), 100 * (cos (_grpVeh getDir _targetPos)), 0];
		} else {
			_grpVeh setDir _dir;
		};
		
		_startingPos set [2,0]; // Reset Starting Pos
		
		if (_vehType == "car" || (!canFire _grpVeh && !_isAir)) then {
			_vehType = "car";
			_soldierArr = [];
		
			for "_i" from 1 to (count (fullCrew [_grpVeh, "", true])) do { _soldierArr pushBack (selectRandom _manArray) };
		
			_reinfGrp = [_grpVeh getPos [15, random 360], _side, _soldierArr] call BIS_fnc_spawnGroup;
			_reinfGrp addVehicle _grpVeh;
			
			{ if !(_x moveInAny _grpVeh) then { /* deleteVehicle _x */ }; uiSleep 0.1; } forEach (units _reinfGrp select { vehicle _x == _x });
			
			uiSleep 0.5;
			
			_reinfGrp selectLeader effectiveCommander _grpVeh;
		} else {
			createVehicleCrew _grpVeh;
			
			// Convert crew if using another faction vehicle.
			if (([getNumber (configFile >> "CfgVehicles" >> _unitClass >> "Side")] call BIS_fnc_sideType) != _side) then {
				_reinfGrp = createGroup [_side, true];
				(crew _grpVeh) join _reinfGrp;
			};
			
			_reinfGrp = group effectiveCommander _grpVeh;
		};	
	} else {
		_reinfGrp = [_startingPos, _side, _unitClass] call BIS_fnc_spawnGroup;
		
		_vehArray = (units _reinfGrp apply { assignedVehicle _x }) - [objNull];
		
		if (count (_vehArray arrayIntersect _vehArray) > 0) then {
			_grpVeh = (_vehArray arrayIntersect _vehArray)#0;
			_vehType = "car";
			
			uiSleep 0.5;
			
			{ if !(_x moveInAny _grpVeh) then { deleteVehicle _x }; uiSleep 0.1; } forEach (units _reinfGrp select { vehicle _x == _x });
			
			_reinfGrp selectLeader effectiveCommander _grpVeh;
		};
	};

	// Run custom init for vehicle (set camos etc).
	if !(_customInit isEqualTo "") then { call compile _customInit; };

	if !_isAir then {
		if (random 1 > 0.3) then {
			_newWP = _reinfGrp addWaypoint [_targetPos, 100];
			_newWP setWaypointType "SAD";
		};

		_newWP = _reinfGrp addWaypoint [_targetPos, 100];
		_newWP setWaypointType "GUARD";
		
		if (_vehType == "car") then {
			_null = [_reinfGrp, _startingPos, _grpVeh, _targetPos] spawn {
				params ["_selGrp", "_startPos", "_selVeh", "_destPos"];

				private _leader = effectiveCommander _selVeh;
							
				waitUntil{ uiSleep 10; if (_leader distance2D _destPos < (400 + random 200) || !alive _leader || !canMove _selVeh) exitWith {true}; false; };
				
				if (!alive _leader || !canMove _selVeh) exitWith {};
				
				// Leave team in if it can fire
				if (canFire _selVeh) then {
					_vehGrp = createGroup [side group _leader, true];
					[_leader, driver _selVeh, gunner _selVeh] joinSilent _vehGrp;
				};
				
				_selGrp leaveVehicle _selVeh;
				{unassignVehicle _x; [_x] orderGetIn false; _x allowFleeing 0} forEach units _selGrp;
				
				waitUntil{ uiSleep 1; if ({vehicle _x == _selVeh} count units _selGrp == 0 || !alive _leader || !canMove _selVeh) exitWith {true}; false; };
				
				if (!alive _leader || !canMove _selVeh) exitWith {};
								
				uiSleep 5;
				
				if (canFire _selVeh) then {
					if (random 1 > 0.7) then {
						_newWP = group _leader addWaypoint [_destPos, 100];
						_newWP setWaypointType "SAD";
					};
					
					_newWP = group _leader addWaypoint [_destPos, 100];
					_newWP setWaypointType "GUARD";
				} else {
					_newWP = group _leader addWaypoint [_startPos, 0];
					waitUntil{ uiSleep 0.5; if (_selVeh distance2D _startPos < 50 || !alive _leader || !canMove _selVeh) exitWith {true}; false; };
					if (!alive _leader || !canMove _selVeh) exitWith {};
					_selVeh deleteVehicleCrew driver _selVeh;
					deleteGroup group _leader;
					deleteVehicle _selVeh;
				};
			};
		};
	} else {
		private _paraGrp = grpNull;
		private _cargoNo = (count fullCrew [_grpVeh, "", true]) - (count fullCrew [_grpVeh, "", false]);
		
		// No cargo seats so assume its CAS
		if (_cargoNo > 1) then {
			_reinfGrp setBehaviour "CARELESS";
			_soldierArr = [];
			
			for "_i" from 1 to _cargoNo do { _soldierArr pushBack (selectRandom _manArray) };

			_paraGrp = [[0,0,0], _side, _soldierArr] call BIS_fnc_spawnGroup;
			
			{ if !(_x moveInAny _grpVeh) then { deleteVehicle _x }; uiSleep 0.1; } forEach (units _paraGrp select { vehicle _x == _x });
			
			_landPos = [_targetPos, 300, random 360] call BIS_fnc_relPos;		
			_unloadWP = _reinfGrp addWaypoint [_landPos, 100];
			_unloadWP setWaypointStatements ["true", "(vehicle this) land 'GET OUT'; {unassignVehicle _x; [_x] orderGetIn false} forEach ((crew vehicle this) select {group _x != group this})"];
			_newWP = _reinfGrp addWaypoint [waypointPosition _unloadWP, 0];
			_newWP setWaypointStatements ["{group _x != group this && alive _x} count crew vehicle this == 0", ""];
		};

		_weapCount = 0;
		{ _weapCount = _weapCount + count _x } forEach (([[-1]] + (allTurrets _grpVeh)) apply { (_grpVeh weaponsTurret _x) - [
			"rhsusf_weap_CMDispenser_ANALE39",
			"rhsusf_weap_CMDispenser_ANALE40",
			"rhsusf_weap_CMDispenser_ANALE52",
			"rhsusf_weap_CMDispenser_M130",
			"rhs_weap_CMDispenser_ASO2",
			"rhs_weap_CMDispenser_BVP3026",
			"rhs_weap_CMDispenser_UV26",
			"rhs_weap_MASTERSAFE",
			"rhsusf_weap_LWIRCM",
			"Laserdesignator_pilotCamera",
			"rhs_weap_fcs_ah64"]
		});
		
		// If has turrets hang around AO, otherwise despawn.
		if (_weapCount > 1) then {
			// TODO: Could be better? Make heli leave after a few SAD wps?
			_newWP = _reinfGrp addWaypoint [_targetPos, 0];
			_newWP setWaypointType "SAD";
			_newWP setWaypointCompletionRadius 300;
			_newWP setWaypointBehaviour "AWARE";
			_newWP = _reinfGrp addWaypoint [_targetPos, 1];
			_newWP setWaypointType "LOITER";
			_newWP setWaypointCompletionRadius 500;
			
			_null = [_reinfGrp, _startingPos, _targetPos] spawn {
				params ["_rGrp","_sPos","_tPos"];
								
				private _time = time + 600;
				while {	alive (vehicle leader _rGrp) && time < _time } do {
					uiSleep 30;
					{ if (_rGrp knowsAbout _x < 4) then { _rGrp reveal [_x, 4] } } forEach (allPlayers select {_x distance2D leader _rGrp < 2500 && vehicle _x == _x && stance _x != "PRONE" });
				};
			};
		} else {
			_newWP = _reinfGrp addWaypoint [_startingPos, 0];
			_null = [_reinfGrp, _startingPos] spawn {
				params ["_reinfGrp","_startingPos"];
				_heli = vehicle leader _reinfGrp;
				waitUntil{ uiSleep 5; if ((leader _reinfGrp) distance2D _startingPos > 200 || !alive (leader _reinfGrp) || !canMove _heli) exitWith {true}; false; };
				waitUntil{ uiSleep 0.5; if ((leader _reinfGrp) distance2D _startingPos < 200 || !alive (leader _reinfGrp) || !canMove _heli) exitWith {true}; false; };
				if (!alive (leader _reinfGrp) || !canMove _heli) exitWith {};
				{_heli deleteVehicleCrew _x} forEach crew _heli;
				deleteGroup _reinfGrp;
				deleteVehicle _heli;
			};
		};
		
		if (count units _paraGrp > 0) then {
			_newWP = _paraGrp addWaypoint [_targetPos, 100];
			_newWP setWaypointType "SAD";
			_newWP = _paraGrp addWaypoint [_targetPos, 100];
			_newWP setWaypointType "GUARD";
			_reinfGrp = _paraGrp;
		};
	};

	if (!isNull _reinfGrp) then { _reinfGrp deleteGroupWhenEmpty true };

	{ _x addCuratorEditableObjects [(units _reinfGrp) + [_grpVeh], true] } forEach allCurators;

	if (_sleep) then { sleep random 20 };
};

// PREPERATION
private _safePositions = [];
private _spawnRoad = [];
private _spawnLand = [];

if (!isNil "_Soldier") then { missionNamespace setVariable [format["ZMM_%1Man", _side], _Soldier]; }; // Variable array for function reference.

// Create safe-zones around spawn.
{
	if (_x in allMapMarkers) then {		
		_mkr = createMarkerLocal [format ["safezone_%1", _forEachIndex + 1000], getMarkerPos _x];
		_mkr setMarkerShapeLocal "ELLIPSE";
		_mkr setMarkerSizeLocal [1000,1000];
		_mkr setMarkerAlphaLocal 0.25;
	};
} forEach ["respawn_west","respawn_east","respawn_guerrila","respawn_civilian"];

{	
	if (["safezone_", toLower _x] call BIS_fnc_inString) then { _safePositions pushBack _x; };
} forEach allMapMarkers;

// White list custom spawns - Change this marker if needed!
{	
	if (["qrf_", toLower _x] call BIS_fnc_inString) then { _spawnLand pushBack getMarkerPos _x; };
} forEach allMapMarkers;

// Collect all roads 2km around the location that are not in a safe location.
for [{_i = 0}, {_i <= 360}, {_i = _i + 1}] do {
	private _posR = _location getPos [_spawnDist, _i];
	_roads = (_posR nearRoads 50) select {((boundingBoxReal _x) select 0) distance2D ((boundingBoxReal _x) select 1) >= 25};
	
	if (count _roads > 0 && { _posR inArea _x } count _safePositions == 0) then {
		_road = _roads select 0;
		if ({_x distance2D _road < 100} count _spawnRoad == 0) then {
			_connected = roadsConnectedTo _road;
			_nearestRoad = objNull;
			{if ((_x distance _location) < (_nearestRoad distance _location)) then {_nearestRoad = _x}} forEach _connected;
			_spawnRoad pushBackUnique position _nearestRoad;
		};
	};
	
	private _posL = _location getPos [(_spawnDist / 2), _i];
	
	if (!surfaceIsWater _posL && { _posL inArea _x } count _safePositions == 0) then {
		if ({_x distance2D _posL < 400} count _spawnLand == 0) then {
			_spawnLand pushBack _posL;
		};
	};	
};

// DEBUG: Show Spawn Markers in local
{
	_mrkr = createMarkerLocal [format ["mkr_road_%1", _forEachIndex], _x];
	(format ["mkr_road_%1", _forEachIndex]) setMarkerTypeLocal "mil_dot";
	(format ["mkr_road_%1", _forEachIndex]) setMarkerColorLocal "ColorYellow";
	(format ["mkr_road_%1", _forEachIndex]) setMarkerTextLocal format["R%1",_forEachIndex];
} forEach _spawnRoad;

{
	_mrkr = createMarkerLocal [format ["mkr_land_%1", _forEachIndex], _x];
	(format ["mkr_land_%1", _forEachIndex]) setMarkerTypeLocal "mil_dot";
	(format ["mkr_land_%1", _forEachIndex]) setMarkerColorLocal "ColorOrange";
	(format ["mkr_land_%1", _forEachIndex]) setMarkerTextLocal format["L%1",_forEachIndex];
} forEach _spawnLand;

// MAIN
// Spawn waves.
for [{_wave = 1}, {_wave < _waveMax}, {_wave = _wave + 1}] do {
	// Stop spawns if no-one is nearby.
	if (({ _location distance2D _x < (_spawnDist + 1000) } count (switchableUnits + playableUnits)) isEqualTo 0 && isMultiplayer) exitWith {
		diag_log text format["[QRF] Aborting - No players within %1 meters!", _spawnDist + 1000];
	};
	
	switch (_wave) do {
		case 1: {
			[_location, _spawnRoad, _side, selectRandom (_Light + _Truck)] call zmm_fnc_spawnUnit;
			[_location, _spawnRoad, _side, selectRandom (_Light + _Truck)] call zmm_fnc_spawnUnit;
			[_location, _spawnLand, _side, selectRandom _Team] call zmm_fnc_spawnUnit;
		};
		case 2: {
			[_location, _spawnRoad, _side, selectRandom (_Light + _Truck)] call zmm_fnc_spawnUnit;
			[_location, _spawnRoad, _side, selectRandom (_Light + _Truck)] call zmm_fnc_spawnUnit;
			[_location, _spawnLand, _side, selectRandom _Team] call zmm_fnc_spawnUnit;
		};
		case 3: {
			[_location, _spawnRoad, _side, selectRandom (_Light + _Truck)] call zmm_fnc_spawnUnit;
			[_location, _spawnRoad, _side, selectRandom (_Truck + _Medium)] call zmm_fnc_spawnUnit;
			[_location, _spawnLand, _side, selectRandom _Team] call zmm_fnc_spawnUnit;
		};
		case 4: {
			[_location, _spawnRoad, _side, selectRandom (_Light + _Truck)] call zmm_fnc_spawnUnit;
			[_location, _spawnRoad, _side, selectRandom (_Truck + _Medium)] call zmm_fnc_spawnUnit;
			[_location, _spawnLand, _side, selectRandom _Squad] call zmm_fnc_spawnUnit;
		};
		default {
			[_location, _spawnRoad, _side, selectRandom (_Light + _Truck)] call zmm_fnc_spawnUnit;
			[_location, _spawnRoad, _side, selectRandom (_Heavy + _Medium)] call zmm_fnc_spawnUnit;
			[_location, _spawnLand, _side, selectRandom _Squad] call zmm_fnc_spawnUnit;
		};
	};

	_tNextWave = time + _delay;	
	waitUntil {sleep 10; time > _tNextWave};
};