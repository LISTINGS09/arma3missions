// Initialization for server
if (!isServer) exitWith {};

if (isNil "a3e_var_villageMarkersInitialized") exitWith {
    [] spawn {
        player sideChat "Scripts\DRN\VillageMarkers\InitVillageMarkers.sqf must be called before call to Scripts/DRN/VillagePatrols/InitVillagePatrols.sqf.";
        sleep 10;
    };
};

params ["_side",["_fnc_onSpawnGroup",{}],["_debug",false]];

if (_debug) then {
	private _message = "Initializing aquatic patrols.";
	diag_log _message;
	player sideChat _message;
};

a3e_arr_aquaticPatrols_Markers = [];
drn_fnc_AquaticPatrols_OnSpawnGroup = _fnc_OnSpawnGroup;

// Create spawn triggers around each village
{
    private _aquaticPatrolZoneName = "a3e_aquaticPatrolMarker" + str _forEachIndex;
	_x params ["_aquaticPatrolZonePos","_aquaticPatrolZoneDir","_aquaticPatrolZoneType","_aquaticPatrolZoneSize"];

	private _aquaticPatrolZone = [_aquaticPatrolZoneName, _aquaticPatrolZonePos, random 1, []];
	a3e_arr_aquaticPatrols_Markers set [_forEachIndex, _aquaticPatrolZone];

	// Set village trigger
	private _trigger = createTrigger["EmptyDetector", _aquaticPatrolZonePos, false];
	_trigger setTriggerInterval 5;
	_trigger setTriggerArea[A3E_Param_EnemySpawnDistance*3, A3E_Param_EnemySpawnDistance*3, 0, false];
	_trigger setTriggerActivation["ANYPLAYER", "PRESENT", true];
	_trigger setTriggerTimeout [1, 1, 1, true];
	_trigger setTriggerStatements["this", "_nil = [a3e_arr_aquaticPatrols_Markers select " + str _forEachIndex + ", " + str _debug + "] spawn drn_fnc_PopulateAquaticPatrol;", "_nil = [a3e_arr_aquaticPatrols_Markers select " + str _forEachIndex + ", " + str _debug + "] spawn drn_fnc_DepopulateAquaticPatrol;"];
	
	if (_debug) then {
		_message = "Initialized aquatic patrols: " + str _forEachIndex;
		diag_log _message;
		player sideChat _message;
	};
} forEach a3e_patrolBoatMarkers;



