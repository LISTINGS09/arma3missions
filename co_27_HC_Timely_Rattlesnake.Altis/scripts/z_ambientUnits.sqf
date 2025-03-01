// Zeus Community Ambient Units
// Author: 2600K
// Generates Ambient Garrison and Patrols
//
// Usage: _nul = [] execVM "scripts\z_ambientUnits.sqf";
ZAU_version = 1.0;
if !isServer exitWith {};

// Unit Variables
// CHOOSE ONE SIDE AND ONE ARRAY OF MEN!

private _side = WEST;
ZMM_WESTMan = ["B_Soldier_F","B_soldier_LAT_F","B_Soldier_F","B_soldier_AR_F","B_Soldier_F","B_Soldier_TL_F","B_Soldier_F",selectRandom["B_Soldier_AA_F","B_Soldier_AT_F"]]; // WEST - NATO (VANILLA)

sleep 5;

// User Variables
if (isNil "ZAU_Debug" ) 		then { ZAU_Debug = false };		// Show Markers
if (isNil "ZAU_DistMax" ) 		then { ZAU_DistMax = 600 };		// Max distance to find buildings.
if (isNil "ZAU_DistMin" ) 		then { ZAU_DistMin = 400 }; 	// Min distance to spawn.
if (isNil "ZAU_UnitsMax" ) 		then { ZAU_UnitsMax = 20 * (missionNamespace getVariable ["f_param_ZMMDiff", 1]) };		// Max units active at once.
if (isNil "ZAU_UnitsChance" ) 	then { ZAU_UnitsChance = 60 }; 	// Overall chance to spawn
if (isNil "ZAU_UnitsGarrison" ) then { ZAU_UnitsGarrison = [2,4] select ((count allPlayers) >= 10) }; // # of units in garrison
if (isNil "ZAU_UnitsPatrol" ) 	then { ZAU_UnitsPatrol = [2,4] select ((count allPlayers) >= 10) }; 	// # of units in patrols
if (isNil "ZAU_SleepTime" ) 	then { ZAU_SleepTime = 30 }; 	// Seconds between checks
if (isNil "ZAU_SafeAreas" ) 	then { ZAU_SafeAreas = ((allMapMarkers select { "cover" in toLower _x || "safezone" in toLower _x}) - ["bis_fnc_moduleCoverMap_border"]) + (missionNamespace getVariable ["ZCS_var_BlackList",[]]) };
// Script Variables
ZAU_Loop = true;
ZAU_UnitsActive = [];

private _loopNo = 1;

private _fnc_log = {
	params ["_text"];
	systemChat _text;
	diag_log text _text;
};

while {ZAU_Loop} do {
	private _tempBuild = [];
	private _finalBuild = [];
	private _unitsToCheck = allPlayers select { (getPosATL _x)#2 < 5 && leader group _x == _x }; // All leaders on ground
	
	//format["[ZAU] INIT Loop #%1 - Players %2 - Units %3", _loopNo, count _unitsToCheck, count ZAU_UnitsActive] call _fnc_log;

	// Fade markers over time to allow units to spawn there later
	{ 
		if (_x find "mkr_ZAU_" > -1) then {
			if ((_x find "mkr_ZAU_spawn_" > -1 || _x find "mkr_ZAU_tracker_" > -1) && markerAlpha _x > 0) then {
				_x setMarkerAlphaLocal (markerAlpha _x - 0.01)
			} else {
				deleteMarker _x
			};
	}} forEach allMapMarkers;

	{ 
		private _unit = _x;

		// Breadcrumbs - These markers gradually fade and prevent units from spawning in those zones.
		if (allMapMarkers findIf { getMarkerPos _x distance2D _unit < (ZAU_DistMin*0.5) && _x find "mkr_ZAU_tracker_" > -1} == -1) then {
			private _mrkr = createMarkerLocal [format ["mkr_ZAU_tracker_%1_%2", _loopNo, _forEachIndex], _unit];
			_mrkr setMarkerShapeLocal "ELLIPSE";
			_mrkr setMarkerSizeLocal [ZAU_DistMin, ZAU_DistMin];
			_mrkr setMarkerColorLocal "ColorGrey";
			if !ZAU_Debug then { _mrkr setMarkerAlphaLocal 0; };
		};
			
		private _tempList = (_x nearObjects ["Building", ZAU_DistMax]) select { count (_x buildingPos -1) > 2 };
		
		// If the unit is in a safe zone, but the houses are outside, we can't skip this step.
		{
			private _bld = _x;
			//systemChat format["[ZAU] Loop #%1 - %2 - %3m", _forEachIndex, _bld, player distance2D _bld];
			if (_unitsToCheck findIf { _x distance2D _bld < ZAU_DistMin } < 0 && (allMapMarkers select { _x find "mkr_ZAU_tracker_" > -1 || _x in ZAU_SafeAreas }) findIf { _bld inArea _x } < 0 ) then { _tempBuild pushBackUnique _bld };
		} forEach (_tempList - _tempBuild);
				
		if (ZAU_Debug) then {
			private _mrkr = createMarkerLocal [format ["mkr_ZAU_player_%1", _forEachIndex], _unit];
			_mrkr setMarkerPosLocal getPos _unit;
			_mrkr setMarkerTypeLocal "mil_dot";
			_mrkr setMarkerColorLocal format["Color%1",_side];
			
			private	_mrkr = createMarkerLocal [format ["mkr_ZAU_max_%1", _forEachIndex], _unit];
			_mrkr setMarkerPosLocal getPos _unit;
			_mrkr setMarkerShapeLocal "ELLIPSE";
			_mrkr setMarkerBrushLocal "Border";
			_mrkr setMarkerSizeLocal [ZAU_DistMax, ZAU_DistMax];
			_mrkr setMarkerColorLocal format["Color%1",_side];
			
			private	_mrkr = createMarkerLocal [format ["mkr_ZAU_min_%1", _forEachIndex], _unit];
			_mrkr setMarkerPosLocal getPos _unit;
			_mrkr setMarkerShape "ELLIPSE";
			_mrkr setMarkerBrushLocal "Border";
			_mrkr setMarkerSizeLocal [ZAU_DistMin, ZAU_DistMin];
			_mrkr setMarkerColorLocal format["Color%1",_side];
		};
	} forEach _unitsToCheck;
	
	_finalBuild = [];
		
	// First Pass to filter the largest buildings within 100 of each other
	{
		private _bld = _x;
	
		if ( _tempBuild findIf { _bld != _x && 
			_bld distance2D _x < 100 && 
			count (_x buildingPos -1) > count (_bld buildingPos -1) } < 0 && 
			_finalBuild findIf { _bld distance2D _x < 100 } < 0 &&
			(allGroups select { side _x isEqualto _side } apply { leader _x }) findIf { _x distance2D _bld < 100 } < 0
		) then {		
			_finalBuild pushBack _x;
			
			if (ZAU_Debug) then {
				format["[ZAU] Building %1/%2 - Dist: %3 - %4 vs %5", _forEachIndex, count _tempBuild, round (_bld distance2D _x), count (_x buildingPos -1), count (_bld buildingPos -1)] call _fnc_log;
		
				private _mrkr = createMarkerLocal [ format ["mkr_ZAU_house_%1_%2", _loopNo, _forEachIndex], _bld];
				_mrkr setMarkerPosLocal getPos _bld;
				_mrkr setMarkerTypeLocal "mil_dot";
				_mrkr setMarkerSizeLocal [0.6,0.6];
				_mrkr setMarkerColorLocal "ColorGreen";
			};
		};
	} forEach _tempBuild;
		
	//format["[ZAU] Filter %1 vs %2 - %3", count _finalBuild, count _tempBuild, _finalBuild] call _fnc_log;
	
	{
		private _bld = _x;
		private _bMid = [0,0,0];
		
		if (ZAU_Debug) then {
			private _mrkr = createMarkerLocal [ format ["mkr_ZAU_house_%1_%2", _loopNo, _forEachIndex], _bld];
			_mrkr setMarkerPosLocal _bld;
			_mrkr setMarkerTypeLocal "mil_dot";
			_mrkr setMarkerColorLocal "ColorYellow";
			_mrkr setMarkerTextLocal format["AMB_%1_%2m",_loopNo, round (_bld distance2D player)];
		};
		
		// Find middle position in building.
		{ if (_bld distance _x < _bld distance _bMid) then { _bMid = _x } } forEach (_bld buildingPos -1);
		
		// Add Garrison
		if (count ZAU_UnitsActive < ZAU_UnitsMax && random 100 <= ZAU_UnitsChance) then {
			private _enemyMen = missionNamespace getVariable [format["ZMM_%1Man", _side], ["O_Solider_F"]];
			private _enemyTeam = [];
			for "_i" from 0 to ((ZAU_UnitsGarrison * (missionNamespace getVariable ["ZZM_Diff", 1])) - 1) do { _enemyTeam set [_i, selectRandom _enemyMen] };
			
			//format["[ZAU] Spawning Garrison at %1", _bMid] call _fnc_log;
			
			private _garrisonGroup = [_bMid, _side, _enemyTeam] call BIS_fnc_spawnGroup;
			_garrisonGroup deleteGroupWhenEmpty true;
						
			private _bpa = _bld buildingPos -1; 
			
			{
				private _unit = _x;
				if (count _bpa < 1) exitWith {};
				
				private _tempPos = selectRandom _bpa;
				_bpa = _bpa - [_tempPos];
				
				if (count (_tempPos nearEntities ["Man", 1]) < 1) then {
					_unit setPosATL _tempPos;				
					doStop _unit;
					_unit setUnitPos selectRandom ["UP","UP","MIDDLE"];
					_unit setDir random 360;
				};
			} foreach (units _garrisonGroup);

			_garrisonGroup enableDynamicSimulation true;
			
			ZAU_Count = (missionNamespace getVariable ["ZAU_Count", 0]) + 1;
			_garrisonGroup setGroupIdGlobal [format["ZAU_HOLD_%1", missionNamespace getVariable ["ZAU_Count", 0]]];
			
			sleep 1;
		};
			
		// Add Patrol
		if (count ZAU_UnitsActive < ZAU_UnitsMax && random 100 <= ZAU_UnitsChance) then {
			private _enemyMen = missionNamespace getVariable [format["ZMM_%1Man", _side], ["O_Solider_F"]];
			private _enemyTeam = [];
			for "_i" from 0 to ((ZAU_UnitsPatrol * (missionNamespace getVariable ["ZZM_Diff", 1])) - 1) do { _enemyTeam set [_i, selectRandom _enemyMen] };
			
			//format["[ZAU] Spawning Team at %1", _bMid] call _fnc_log;
			
			private _patrolGroup = [_bMid, _side, _enemyTeam] call BIS_fnc_spawnGroup;
			_patrolGroup deleteGroupWhenEmpty true;
			_patrolGroup enableDynamicSimulation true;
						
			if (random 1 > 0.3) then {
				[_patrolGroup, getPos _bld, 100 + random 100] call BIS_fnc_taskPatrol;
			};
			
			// Add to global list
			ZAU_UnitsActive append units _patrolGroup;
			
			{ _x addCuratorEditableObjects [units _patrolGroup, true] } forEach allCurators;
			
			if (ZAU_Debug) then {
				private _mrkr = createMarkerLocal [format ["mkr_ZAU_spawn_%1_%2", _loopNo, _forEachIndex], _bMid];
				_mrkr setMarkerPosLocal _bMid;
				_mrkr setMarkerTypeLocal "mil_dot";
				_mrkr setMarkerColorLocal format["Color%1",_side];
				_mrkr setMarkerTextLocal format["SP_%1_%2",_loopNo, _forEachIndex];
			};
			
			ZAU_Count = (missionNamespace getVariable ["ZAU_Count", 0]) + 1;
			_patrolGroup setGroupIdGlobal [format["ZAU_PATROL_%1", missionNamespace getVariable ["ZAU_Count", 0]]];
			
			sleep 1;
		};
	} forEach _finalBuild;
	
	{
		private _unit = _x;
		if (allPlayers findIf { _x distance2D _unit < (ZAU_DistMax * 1.5) } == -1) then { 
			//format["[ZAU] Deleting Unit %1", _unit] call _fnc_log;
			ZAU_UnitsActive deleteAt (ZAU_UnitsActive find _unit);
			deleteVehicle _x;
		};
	} forEach ZAU_UnitsActive;
	
	_loopNo = _loopNo + 1;
	sleep ZAU_SleepTime;
};