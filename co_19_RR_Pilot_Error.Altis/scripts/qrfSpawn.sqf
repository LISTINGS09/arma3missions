/*
	Author: 2600K / Josef Zemanek v1.36

	Description:
	Enemy Reinforcements Spawner
	
	_nul = [getMarkerPos "Objective"] execVM "scripts\qrfSpawn.sqf";
	_nul = [thisTrigger] execVM "scripts\qrfSpawn.sqf";
	
	Any marker containing text 'safezone' will not spawn units.
	Any marker containing text 'spawn' will act as an additional spawn point.
*/
ZQR_version = 1.38;
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

// WEST - NATO (VANILLA)
_side = WEST;
ZMM_WESTMan = ["B_Soldier_F","B_soldier_LAT_F","B_Soldier_F","B_soldier_AR_F","B_Soldier_F","B_Soldier_TL_F","B_Soldier_F",selectRandom["B_Soldier_AA_F","B_Soldier_AT_F"]];
_Truck = [configFile >> "CfgGroups" >> "West" >> "BLU_F" >> "Motorized" >> "BUS_MotInf_Reinforce"];
_Light = ["B_MRAP_01_gmg_F","B_MRAP_01_hmg_F","B_LSV_01_AT_F","B_LSV_01_armed_F"];
_Medium = [["B_AFV_Wheeled_01_up_cannon_F","[_grpVeh,false,['showCamonetTurret',0.3,'showCamonetHull',0.5]] call BIS_fnc_initVehicle;"],["B_APC_Wheeled_01_cannon_F","[_grpVeh,false,['showCamonetTurret',0.3,'showCamonetHull',0.5,'showSLATHull',0.6,'showSLATTurret',0.3]] call BIS_fnc_initVehicle;"],["B_APC_Tracked_01_rcws_F","[_grpVeh,false,['showCamonetHull',0.3]] call BIS_fnc_initVehicle;"]];
_Heavy = [["B_APC_Tracked_01_AA_F","[_grpVeh,false,['showCamonetTurret',0.3,'showCamonetHull',0.5]] call BIS_fnc_initVehicle;"],["B_MBT_01_TUSK_F","[_grpVeh,false,['showCamonetTurret',0.3,'showCamonetHull',0.5]] call BIS_fnc_initVehicle;"]];
_Air = ["B_Heli_Light_01_F","B_Heli_Transport_01_F",["B_Heli_Transport_03_F","[_grpVeh,['Black',1]] call BIS_fnc_initVehicle;"]];
_CAS = ["B_Heli_Light_01_dynamicLoadout_F",["B_Heli_Attack_01_dynamicLoadout_F","_grpVeh setPylonLoadout [3,'PylonRack_12Rnd_missiles'];_grpVeh setPylonLoadout [4,'PylonRack_12Rnd_missiles'];"],["B_Plane_CAS_01_dynamicLoadout_F","_grpVeh setPylonLoadout [3,'PylonRack_7Rnd_Rocket_04_HE_F'];_grpVeh setPylonLoadout [4,'PylonMissile_1Rnd_Mk82_F'];_grpVeh setPylonLoadout [5,'PylonMissile_1Rnd_BombCluster_03_F'];_grpVeh setPylonLoadout [6,'PylonMissile_1Rnd_BombCluster_03_F'];_grpVeh setPylonLoadout [7,'PylonMissile_1Rnd_Mk82_F'];_grpVeh setPylonLoadout [8,'PylonRack_7Rnd_Rocket_04_AP_F'];"]];

if isNil "_side" exitWith { systemChat "QRFSpawn.sqf - ERROR - No Side defined!"; diag_log "QRFSpawn.sqf - ERROR - No Side defined!"; };

// Functions.
zmm_fnc_spawnUnit = {
	params [
		["_targetPos", []],
		["_posArray", []],
		"_side",
		["_unitClass", ""],
		["_tries", 1]
	];

	if (_unitClass isEqualTo "") exitWith { diag_log format["[QRF] SpawnUnit - Empty Unit Passed: %1 (%2)", _unitClass, _side] };
	if (_tries > 10) exitWith {};

	diag_log format["[QRF] SpawnUnit - Passed %1: %2 [%3] Try:%4", _targetPos, _unitClass, _side, _tries];

	private _startClass = _unitClass;
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
	private _enemyMen = missionNamespace getVariable [format["ZMM_%1Man", _side], ["B_Soldier_F"]];

	// If _unitClass is array, extract the custom init.
	if (_unitClass isEqualType []) then { _customInit = _unitClass # 1; _unitClass = _unitClass # 0 };

	// If _unitClass is a number, fill it with random units.
	if (_unitClass isEqualType 1) then { 
		private _enemyTeam = [];
		for "_i" from 0 to (_unitClass - 1) do {  _enemyTeam set [_i, selectRandom _enemyMen] };
		_unitClass = _enemyTeam;
	};

	// Check if _unitClass is an air vehicle.
	_isAir = false;
	if (_unitClass isEqualType "") then {
		if ("Air" in ([(configFile >> "CfgVehicles" >> _unitClass), true] call BIS_fnc_returnParents)) then { _isAir = true; _startingPos set [2, 500]; };
	};

	// Don't spawn object if too close to any players.
	if ({ alive _x && _x distance2D _startingPos < (if _isAir then {1000} else {500})} count allPlayers > 0 && isMultiplayer) exitWith { 
		sleep 30;
		[_targetPos, _posArray, _side, _startClass, _tries + 1] call zmm_fnc_spawnUnit;
	};

	if (_unitClass isEqualType "") then {
		_vehType = toLower getText (configFile >> "CfgVehicles" >> _unitClass >> "vehicleClass");
		_vehName = toLower getText (configFile >> "CfgVehicles" >> _unitClass >> "displayName");
		_grpVeh = createVehicle [_unitClass, _startingPos, [], 0, if _isAir then {"FLY"} else {"NONE"}];
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
			private _soldierArr = [];
			private _cargoNo = (count fullCrew [_grpVeh, "", true]) min 12;
			for "_i" from 1 to _cargoNo do { _soldierArr pushBack (if (_cargoNo > 4) then { selectRandom _enemyMen } else { _enemyMen#0 }) }; // Random units for cargo
		
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
	if !(isNil "_customInit") then { 
		if !(_customInit isEqualTo "") then { call compile _customInit; };
	};

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
		private _cargoNo = ((count fullCrew [_grpVeh, "", true]) - (count fullCrew [_grpVeh, "", false])) min 12;
		
		// No cargo seats so assume its CAS
		if (_cargoNo > 1) then {
			_reinfGrp setBehaviour "CARELESS";
			_soldierArr = [];
			
			for "_i" from 1 to _cargoNo do { _soldierArr pushBack (selectRandom _enemyMen) };

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
					{ if (_rGrp knowsAbout _x < 4) then { _rGrp reveal [_x, 4] } } forEach (allPlayers select {_x distance2D leader _rGrp < 2500 && stance _x != "PRONE" });
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

zmm_fnc_spawnPara = {
	params [["_location", [0,0,0]], ["_side", EAST], ["_vehicle", ""]];

	private _man = missionNamespace getVariable [format["ZMM_%1Man",_side],["O_Soldier_F"]];

	sleep random 30;

	private _groupMax = 99; // Maximum para groups
	private _groupSize = 8; // Units number per para group

	_startPos = _location getPos [3000, random 360];

	// Split out init from class.
	private _customInit = "";
	if (_vehicle isEqualType []) then { _customInit = _vehicle # 1; _vehicle = _vehicle # 0 };

	private _grpVeh = createVehicle [_vehicle, _startPos, [], 0, "FLY"];
	private _dirTo =  _grpVeh getDir _location;
	private _dirFrom =  (_grpVeh getDir _location) + 180;
	_grpVeh setDir _dirTo;
	//_grpVeh flyInHeight 200;

	// Run the custom init 
	if !(isNil "_customInit") then { 
		if !(_customInit isEqualTo "") then { call compile _customInit; };
	};

	createVehicleCrew _grpVeh;
	(group effectiveCommander _grpVeh) deleteGroupWhenEmpty true;

	// Convert crew if using another sides vehicle.
	if (([getNumber (configFile >> "CfgVehicles" >> _vehicle >> "Side")] call BIS_fnc_sideType) != _side) then {
		_grp = createGroup [_side, true];
		(crew _grpVeh) join _grp;
	};

	private _grp = group effectiveCommander _grpVeh;

	// Find the number of seats we can hold
	private _cargoMax = ([_vehicle, true] call BIS_fnc_crewCount) - ([_vehicle, false] call BIS_fnc_crewCount);

	if (_cargoMax < 1) exitWith { _grpVeh setDamage 1 };

	// Create Para Group
	private _paraList = [];
	private _cargoLeft = _cargoMax;

	// Work out how many groups we can have without overfilling the vehicle.
	for [{_i = 0}, {_i <= ceil (_cargoMax / _groupSize)}, {_i = _i + 1}] do {
		if (_cargoLeft - _groupSize >= _groupSize) then {
			_paraList set [_i,_groupSize];
		} else {
			// Only part of a group can be added, if its worth adding include it.
			if (_cargoLeft > 2) then {
				_paraList set [_i,_groupSize];
			};
		};
		
		_cargoLeft = _cargoLeft - _groupSize;
	};

	// If there are more groups than allowed, remove them.
	if (count _paraList > _groupMax) then { _paraList resize _groupMax };

	// Create the groups and store them in a variable
	private _grpVehVar = [];
	private _grpVehCount = 0;

	{
		private _paraUnits = [];	
		for [{_i = 1}, {_i <= _x}, {_i = _i + 1}] do { _paraUnits pushBack (selectRandom _man) };

		_grpPara = [[0,0,0], _side, _paraUnits] call BIS_fnc_spawnGroup;

		{ _x moveInAny _grpVeh } forEach units _grpPara;
		
		_wp = _grpPara addWaypoint [_location, 0];
		_wp setWaypointType 'SAD';
		_wp = _grpPara addWaypoint [_location, 0];
		_wp setWaypointType 'GUARD';
		
		sleep 0.5;

		_grpVehVar pushBack _grpPara;
		
		_grpVehCount = _grpVehCount + _x;
	} forEach _paraList;

	_grpVeh setVariable ['var_dropGroup', _grpVehVar];

	// Set pilot wayPoints
	_wp = _grp addWaypoint [_startPos, 0];
	_wp setWaypointType "MOVE";
	_wp setWaypointSpeed "FULL";
	_wp setWaypointBehaviour "CARELESS";
	_wp setWaypointStatements ["true","(vehicle this) setPilotLight true;"];

	// Set Pilots wayPoints

	private  _dropStart = _location getPos [_grpVehCount * 25, _dirFrom];
	private _tmp = createMarkerLocal ["dropStart", _dropStart];
	_tmp setMarkerTypeLocal "mil_dot";
	_tmp setMarkerTextLocal "Start";

	_wp = _grp addWaypoint [_dropStart, 0];
	_wp setWaypointType "MOVE";
	_wp setWaypointStatements ["true","
		(vehicle this) spawn {
			{
				{
					unassignVehicle _x;
					[_x] orderGetIn false;
					moveOut _x; 
					sleep 0.5;
					_pc = createVehicle ['Steerable_Parachute_F', (getPosATL _x), [], 0, 'NONE'];
					_pc setPosATL (getPosatl _x);
					_vel = velocity _pc;
					_dir = random 360;
					_pc setVelocity [(_vel#0) + (sin _dir * 10),  (_vel#1) + (cos _dir * 10), (_vel#2)];
					_x moveinDriver _pc;
				} forEach (units _x);
				sleep 1;
			} forEach (_this getVariable ['var_dropGroup',[]]);
		};
	"];

	private _dropDelete = _location getPos [3000, _dirTo];
	_wp = _grp addWaypoint [_dropDelete, 0];
	_wp setWaypointType "MOVE";
	_wp setWaypointCompletionRadius 500;
	_wp setWaypointStatements ["true","_delVeh = (vehicle this); { deleteVehicle (_x#0) } forEach (fullCrew _delVeh); deleteVehicle _delVeh; deleteGroup (group this);"];
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
	private _mrkr = createMarkerLocal [format ["mkr_road_%1", _forEachIndex], _x];
	_mrkr setMarkerPosLocal _x;
	_mrkr setMarkerTypeLocal "mil_dot";
	_mrkr setMarkerColorLocal "ColorYellow";
	_mrkr setMarkerTextLocal format["R%1",_forEachIndex];
} forEach _spawnRoad;

{
	private _mrkr = createMarkerLocal [format ["mkr_land_%1", _forEachIndex], _x];
	_mrkr setMarkerPosLocal _x;
	_mrkr setMarkerTypeLocal "mil_dot";
	_mrkr setMarkerColorLocal "ColorOrange";
	_mrkr setMarkerTextLocal format["L%1",_forEachIndex];
} forEach _spawnLand;

// Adjust Difficulty
if ((missionNamespace getVariable ["f_param_ZMMDiff",0]) > 0) then { _waveMax = _waveMax * f_param_ZMMDiff };

// MAIN
// Spawn waves.
for [{_wave = 1}, {_wave < _waveMax}, {_wave = _wave + 1}] do {
	// Stop spawns if no-one is nearby.
	if (({ _location distance2D _x < (_spawnDist + 1000) } count (switchableUnits + playableUnits)) isEqualTo 0 && isMultiplayer) exitWith {
		diag_log text format["[QRF] Aborting - No players within %1 meters!", _spawnDist + 1000];
	};
	
	diag_log text format["[QRF] Spawning - Wave %1/%2", _wave, _waveMax];
	
	switch (_wave) do {
		case 1; case 2; case 3: {
			[_location, _spawnLand, _side, 4] call zmm_fnc_spawnUnit;
		};
		case 4: {
			[_location, _spawnRoad, _side, selectRandom (_Air + _Truck)] call zmm_fnc_spawnUnit;
			[_location, _spawnLand, _side, 4] call zmm_fnc_spawnUnit;
		};
		default {
			[_location, _spawnRoad, _side, selectRandom (_Air + _Medium + _Truck)] call zmm_fnc_spawnUnit;
			[_location, _spawnLand, _side, 4] call zmm_fnc_spawnUnit;
			[_location, _spawnLand, _side, 4] call zmm_fnc_spawnUnit;
		};
	};

	_tNextWave = time + _delay;	
	waitUntil {sleep 10; time > _tNextWave};
};