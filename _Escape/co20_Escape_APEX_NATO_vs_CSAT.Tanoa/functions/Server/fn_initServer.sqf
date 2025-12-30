//waitUntil{!isNil("BIS_fnc_init")};
if(!isServer) exitWith {};
{ _x setDynamicSimulationDistance ((dynamicSimulationDistance _x) * 2) } forEach ["Group","Vehicle","EmptyVehicle"];
																											
["Server started."] spawn a3e_fnc_debugmsg;
if(isNil("a3e_var_commonLibInitialized")) then {
	call compile preprocessFileLineNumbers "Scripts\DRN\CommonLib\CommonLib.sqf";
};


//Parse the parameters
call a3e_fnc_parameterInit;

call compile preprocessFileLineNumbers "Scripts\Escape\Functions.sqf";
call compile preprocessFileLineNumbers "Scripts\Escape\AIskills.sqf";

if(!isNil("A3E_Param_Debug")) then {
	if((A3E_Param_Debug)==0 && !(missionNameSpace getVariable ["a3e_debug_overwrite",false])) then {
		A3E_Debug = false;
	} else {
		A3E_Debug = true;
		["Debug mode active!."] spawn a3e_fnc_debugmsg;
	};
} else {
	A3E_Debug = true;
	["Warning! Debug was set to true because of missing param!."] spawn a3e_fnc_debugmsg;
};

if(is3DENPreview) then {
	A3E_Debug = true;
	
	//Delete AI in Preview:
	{
		if (!isPlayer _x) then {
			[_x] joinSilent grpNull;
			deleteVehicle _x;
		};
	} forEach units group player;
	["Debug mode active!."] spawn a3e_fnc_debugmsg;
};

publicVariable "A3E_Debug";

//ACE Revive
AT_Revive_Camera = A3E_Param_ReviveView; //Needs to be stored on server now
ACE_MedicalServer = false;
if (isClass(configFile >> "CfgPatches" >> "ACE_Medical")) then {
	ACE_MedicalServer = true;
	["ace_unconscious", {params["_unit", "_isDown"]; [_unit,_isDown] spawn ACE_fnc_HandleUnconscious;}] call CBA_fnc_addEventHandler;
};
publicVariable "ACE_MedicalServer";

//Load Statistics
[] spawn A3E_fnc_LoadStatistics;

// Add crashsite here
//##############

[A3E_Param_EnemyFrequency] call compile preprocessFileLineNumbers "Units\UnitClasses.sqf";

// prison is created locally, clients need flag texture path
publicVariable "A3E_VAR_Flag_Ind";

// Developer Variables
createCenter A3E_VAR_Side_Opfor;
createCenter A3E_VAR_Side_Ind;
createCenter civilian;

A3E_VAR_Side_Blufor setFriend [A3E_VAR_Side_Ind, 0];
A3E_VAR_Side_Ind setFriend [A3E_VAR_Side_Blufor, 0];

A3E_VAR_Side_Blufor setFriend [A3E_VAR_Side_Opfor, 0];
A3E_VAR_Side_Opfor setFriend [A3E_VAR_Side_Blufor, 0];
	
if ((missionNameSpace getVariable ["A3E_Param_War_Torn",0]) == 0) then {
	A3E_VAR_Side_Opfor Setfriend [A3E_VAR_Side_Ind, 1];
	A3E_VAR_Side_Ind setFriend [A3E_VAR_Side_Opfor, 1];
} else {
	A3E_VAR_Side_Opfor Setfriend [A3E_VAR_Side_Ind, 0];
	A3E_VAR_Side_Ind setFriend [A3E_VAR_Side_Opfor, 0];
};

[] spawn A3E_fnc_weather;

private _hour = A3E_Param_TimeOfDay;
switch (A3E_Param_TimeOfDay) do {
    case 24: {  _hour = round(random(24)) };
    case 25: {
		_hour = 6+round(random(10));  //Between 0600 and 1600
	};
	case 26: { 
		_hour = 17 + round(random(11)); //Between 1700 and 0400
		_hour = _hour % 24;
	};
    default { _hour = A3E_Param_TimeOfDay };
};
private _date = date;
_date set [3,_hour];
_date set [4,0];

a3e_var_Escape_hoursSkipped = _hour - (date select 3);
publicVariable "a3e_var_Escape_hoursSkipped";
		
[_date] call bis_fnc_setDate;

setTimeMultiplier A3E_Param_TimeMultiplier;

// Game Control Variables, do not edit!
missionNameSpace setVariable ["a3e_var_Escape_AllPlayersDead", false, true];
missionNameSpace setVariable ["a3e_var_Escape_MissionComplete", false, true];

a3e_var_GrpNumber = 0;

if(isNil("A3E_Param_EnemySkill")) then { A3E_Param_EnemySkill = 1 };

private _enemyMinSkill = 0.40;
private _enemyMaxSkill = 0.60;

//Kudos to Semiconductor
switch (A3E_Param_EnemySkill) do { 
    // Convert value from params.hpp into acceptable range 
    case 0: { _enemyMinSkill = 0.10; _enemyMaxSkill = 0.30; }; 
    case 1: { _enemyMinSkill = 0.30; _enemyMaxSkill = 0.50; }; 
    case 2: { _enemyMinSkill = 0.40; _enemyMaxSkill = 0.60; }; 
    case 3: { _enemyMinSkill = 0.60; _enemyMaxSkill = 0.80; }; 
    case 4: { _enemyMinSkill = 0.80; _enemyMaxSkill = 0.95; }; 
    default { _enemyMinSkill = 0.40; _enemyMaxSkill = 0.60; }; 
}; 

a3e_var_Escape_enemyMinSkill = _enemyMinSkill;
a3e_var_Escape_enemyMaxSkill = _enemyMaxSkill;

private _searchChopperSearchTimeMin = (5 + random 10);
private _searchChopperRefuelTimeMin = (5 + random 10);
private _villagePatrolSpawnArea = (A3E_Param_VillageSpawnCount);

drn_searchAreaMarkerName = "drn_searchAreaMarker";

//Getting exclusion zones
if(isNil("A3E_ExclusionZones")) then {
  A3E_ExclusionZones = [];
  {
    if("A3E_ExclusionZone" in _x && _x != "A3E_ExclusionZone_") then {
      A3E_ExclusionZones pushBack _x;
	  if(!A3E_Debug) then {_x setMarkerAlpha 0;};
    };
  } forEach allMapMarkers;
};

// Choose a start position
if(isNil("A3E_ClearedPositionDistance")) then { A3E_ClearedPositionDistance = 500 };

if(isNil("a3e_var_guardedLocations")) then { a3e_var_guardedLocations = [] };

A3E_StartPos = [] call a3e_fnc_findFlatArea;
while {{A3E_StartPos inArea _x} count A3E_ExclusionZones > 0} do {
	A3E_StartPos = [] call a3e_fnc_findFlatArea;
};
publicVariable "A3E_StartPos";

A3E_Var_ClearedPositions = [];
A3E_Var_ClearedPositions pushBack A3E_StartPos;
A3E_Var_ClearedPositions pushBack (getMarkerPos "drn_insurgentAirfieldMarker");

private _backpack = [] call A3E_fnc_createStartpos;

//### The following is a mission function now

[true] call A3E_fnc_InitVillageMarkers; 
[true] call drn_fnc_InitAquaticPatrolMarkers; 

//Wait for players to actually arrive ingame. This may be a long time if server is set to persistent
waitUntil{uisleep 1; count([] call A3E_FNC_GetPlayers)>0};

[_enemyMinSkill, _enemyMaxSkill, A3E_Param_EnemyFrequency, A3E_Debug] execVM "Scripts\Escape\EscapeSurprises.sqf";

// Do these sequentially so the same spot isn't taken!
[] spawn {
	// Create communication centers
	[] call A3E_fnc_CreateComCenters;

	// Create Motor Pools
	[] call A3E_fnc_CreateMotorPools;

	// Create ammo depots
	[] call A3E_fnc_CreateAmmoDepots;

	//Spawn mortar sites
	[] call A3E_fnc_createMortarSites;
};

// Initialize search leader
[] call A3E_fnc_SearchleaderInit;

//Start the player detection script
[] call A3E_fnc_PlayerDetection;

// Run initialization for scripts that need the players to be gathered at the start position
[] spawn A3E_fnc_initVillages;

//Start local and remote statistic tracking
[] spawn {
	sleep 1;
	[] call A3E_fnc_startStatistics;
};

// Create search chopper
private _scriptHandle = [getMarkerPos "drn_searchChopperStartPosMarker", A3E_VAR_Side_Opfor, drn_searchAreaMarkerName, _searchChopperSearchTimeMin, _searchChopperRefuelTimeMin, _enemyMinSkill, _enemyMaxSkill, [], A3E_Debug] execVM "Scripts\Escape\CreateSearchChopper.sqf";
waitUntil {scriptDone _scriptHandle};

//Init trap spawning system for mines and other roadside surprises
call A3E_fnc_InitTraps;

// Spawn creation of start position settings
[A3E_StartPos, _backPack] spawn {
	params ["_startPos", "_backPack"];
 	 
    // Spawn guard
	private _guardCount = [-1,-1,3,8] call a3e_fnc_getDynamicSquadSize;
	private _i = 0;	
	for [{_i = 0}, {_i < (_guardCount)}, {_i = _i + 1}] do {
		private _weapon = a3e_arr_PrisonBackpackWeapons select floor(random(count(a3e_arr_PrisonBackpackWeapons)));
		_backpack addWeaponCargoGlobal[(_weapon select 0),1];
		_backpack addMagazineCargoGlobal[(_weapon select 1),3];
	};
	
    // Spawn more guards
    private _marker = createMarker ["drn_guardAreaMarker", _startPos];
    _marker setMarkerShape "ELLIPSE";
    _marker setMarkerSize [50, 50];
	_marker setMarkerAlpha 0;
	if(missionNameSpace getVariable["A3E_Debug",false]) then {
		_marker setMarkerAlpha 0.5;
	};

    private _guardGroups = [];
	private _guardGroup = grpNull;
    private _createNewGroup = true;
    
    for [{_i = 0}, {_i < _guardCount}, {_i = _i + 1}] do {        
        private _pos = [_marker] call drn_fnc_CL_GetRandomMarkerPos;
        while {_pos distance _startPos < 10} do {
            _pos = [_marker] call drn_fnc_CL_GetRandomMarkerPos;
        };
        
        if (_createNewGroup) then {
            _guardGroup = createGroup [A3E_VAR_Side_Ind, true];
            _guardGroups set [count _guardGroups, _guardGroup];
            _createNewGroup = false;
        };
        
        //(a3e_arr_Escape_StartPositionGuardTypes select floor (random count a3e_arr_Escape_StartPositionGuardTypes)) createUnit [_pos, _guardGroup, "", (0.5), "CAPTAIN"];
        _guardGroup createUnit [(a3e_arr_Escape_StartPositionGuardTypes select floor (random count a3e_arr_Escape_StartPositionGuardTypes)), _pos, [], 0, "FORM"];
        
        if (count units _guardGroup >= 2) then { _createNewGroup = true };
    };
    
    {
        private _guardGroup = _x;
        _guardGroup setFormDir floor (random 360);
        
        {
            private _unit = _x;
            _unit setUnitRank "CAPTAIN";
            { _unit unlinkItem _x } forEach (assignedItems _unit);
			if (ACE_MedicalServer) then {_unit addItem "ACE_epinephrine"};//Add Epinephrine for each unit
			removeBackpackGlobal _unit;
			
			if(random 100 < 80) then { removeAllPrimaryWeaponItems _unit };

			private _hmd = hmd _unit;
			if (_hmd isEqualTo "") then {
				private _cfgWeapons = configFile >> "CfgWeapons";
				{
					if (616 == getNumber (_cfgWeapons >> _x >> "ItemInfo" >> "type")) exitWith {
						_hmd = _x;
					};
				} forEach items _unit;
			};
			if (!(_hmd isEqualTo "") && {random 100 > 20 || {A3E_Param_NoNightvision == 1}}) then {
				_unit unlinkItem _hmd;
				_unit removeItem _hmd;
			};
			
			//This should remove all types of handgrenades (for example RHS)
            _unit removeMagazines "Handgrenade";            
            _unit setVehicleAmmo 0.3 + random 0.7;
        } forEach units _guardGroup;
        
        [_guardGroup, _marker] spawn A3E_fnc_Patrol;
    } forEach _guardGroups;
        
	//Add an alert trigger to the prison
	A3E_fnc_revealPlayers = {
		private _guardGroup = _this;
		{ _guardGroup reveal [_x,1.5] } forEach allPlayers;
	};
	A3E_fnc_soundAlarm = {
		params ["_guardGroups"];
		if(isNil("A3E_SoundPrisonAlarm")) then {
			A3E_SoundPrisonAlarm = true;
			publicvariable "A3E_SoundPrisonAlarm";
			{ _x spawn A3E_fnc_revealPlayers } forEach _guardGroups;
			sleep 30;
			A3E_SoundPrisonAlarm = false;
			publicvariable "A3E_SoundPrisonAlarm";
		};
	};
    // Start thread that waits for escape to start
    [_guardGroups] spawn {
        params ["_guardGroups"];
        
        sleep 5;
        
        while {isNil("A3E_EscapeHasStarted")} do {
			sleep 1;
            // If any member of the group is to far away from fence, then escape has started
            {
				if(_x getVariable ["A3E_PlayerInitializedServer",false]) then {
					// If any player have picked up a weapon, escape has started
					if ((_x distance A3E_StartPos) > 15 && (_x distance A3E_StartPos) < 100 || count weapons _x > 0) exitWith { missionNameSpace setVariable ["A3E_EscapeHasStarted", true, true] };
				};
            } forEach allPlayers;
        };
        
        // ESCAPE HAS STARTED
        //{
		//	[[[_x], {(_this select 0) setCaptive false;}], "BIS_fnc_spawn", _x, false] call BIS_fnc_MP;
		//} forEach call A3E_fnc_GetPlayers;
	   diag_log "Server: Escape has started.";
    };
	
	//Spawn alarm watchdog
	[_guardGroups] spawn {
		params ["_guardGroups"];
		while{isNil("A3E_SoundPrisonAlarm")} do {
			if(!isNil("A3E_EscapeHasStarted")) then {
				{
					private ["_guardGroup"];					
					_guardGroup = _x;
					{
						if((_guardGroup knowsAbout _x)>2.5) exitWith {
							[_guardGroups] call A3E_fnc_soundAlarm;
						};
					} forEach call A3E_fnc_GetPlayers;
				} forEach _guardGroups;
			};
			if(!isNil("A3E_PrisonGateObject")) then {
				if((A3E_PrisonGateObject animationPhase "Door_1_rot") > 0.5 ||
				(A3E_PrisonGateObject animationPhase "Door_2_rot") > 0.5) then {
					if(isNil("A3E_EscapeHasStarted")) then { missionNameSpace setVariable ["A3E_EscapeHasStarted", true, true] };
					[_guardGroups] call A3E_fnc_soundAlarm;
				};
			};
			sleep 0.5;
		};
	};
	
	//Watch for captive state
	[] spawn {
		while{isNil("A3E_EscapeHasStarted")} do {
			{
				if(isNil("A3E_EscapeHasStarted") && !(captive _x)) then { [_x, true] remoteExec ["setCaptive", _x, false] };
			} forEach call A3E_fnc_GetPlayers;
			sleep 0.5;
		};
		{ [_x, false] remoteExec ["setCaptive", _x, false] } forEach call A3E_fnc_GetPlayers;
	};
};

//["A3E_FNC_AmbientAISpawn"] call A3E_FNC_Chronos_Register;
["A3E_FNC_RoadBlocks"] call A3E_FNC_Chronos_Register;
["A3E_FNC_AmbientPatrols"] call A3E_FNC_Chronos_Register;
["A3E_FNC_MilitaryTraffic"] call A3E_FNC_Chronos_Register;
["A3E_FNC_CivilianCommuters"] call A3E_FNC_Chronos_Register;
["A3E_FNC_TrackGroup_Update"] call A3E_FNC_Chronos_Register;

//Spawn Aquatic Patrols
[A3E_VAR_Side_Opfor, { { _x call A3E_fnc_onEnemySoldierSpawn } forEach units _this }, A3E_Debug] call drn_fnc_InitAquaticPatrols;

//Spawn crashsites
private _crashSiteCount = ceil(random(missionNameSpace getVariable["CrashSiteCountMax",3]));
for "_i" from 1 to _crashSiteCount step 1 do {
	private _pos = [] call A3E_fnc_findFlatArea;
	[_pos] call A3E_fnc_crashSite;
};

//Move to chronos
[] spawn {
	while {true} do {
		private _score = missionNameSpace getVariable ["A3E_Warcrime_Score",0];
		if(_score>500) then {
			_score = _score - 50;
			missionNameSpace setVariable ["A3E_Warcrime_Score",_score];
		};
		sleep 60;
	};
};