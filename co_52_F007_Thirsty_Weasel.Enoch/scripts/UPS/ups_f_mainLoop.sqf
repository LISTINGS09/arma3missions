params ["_group"];

// Remove group from loop
if (isNil "_group" || units _group select { alive _x } isEqualTo [] || {isPlayer _x} count units _group > 0) exitWith { 
	ZAI_UPSGroups = ZAI_UPSGroups - [_group];
	["DEBUG", format["[%1] Exiting - Null Group", _group]] call _ZAI_fnc_LogMsg 
};

private _id = _grp getVariable "ZAI_ID";
private _closeEnough = _group getVariable "ZAI_CLOSE";
private _groupLeader = leader _group;
private _wasHit = FALSE;
private _area = _group getVariable "ZAI_AREA";



// Check for damage to group
_newDamage = 0; 
{
	if (damage _x > 0.2) then {
		_newDamage = _newDamage + (damage _x); 
		// Increased since last check
		if (_newDamage > _lastDamage) then {
			["DEBUG", format["[%1] Taken Damage (%2/%3)", _groupIDx, _newDamage, _lastDamage]] call _ZAI_fnc_LogMsg;
			_lastDamage = _newDamage;
			_wasHit = TRUE;
			_currCycle = 1;
		};
	};
} forEach units _group;

// groups current position
_unitPos = getPos _groupLeader;
	
_foundEnemy = _groupLeader findNearestEnemy _unitPos;

// Enemy was detected plan attack route
if (_groupLeader distance2D _foundEnemy < _shareDist) then {

	// Final location depends of knowsAbout of enemy.
	_enemyOffset = (21 - ((_group knowsAbout _foundEnemy) * 5)) * 5;
	_attackPos = _foundEnemy getPos [random _enemyOffset, random 360];
	_attackPos set [2,0];
	
	// If no existing arty calls, request one.
	if ({ _x distance _attackPos < _safeDist } count (missionNamespace getVariable [format["ZAI_%1_ArtyQueue", side _group],[]]) == 0) then { 
		missionNamespace setVariable [format["ZAI_%1_ArtyQueue", side _group],(missionNamespace getVariable [format["ZAI_%1_ArtyQueue", side _group],[]]) + [_attackPos]];
	};
	
	// Send to other non-infantry allies in range.
	if (!_noShare && _group knowsAbout _foundEnemy >= 1.5) then {
		{
			_kbType = (group _x) getVariable ["ZAI_Type",[]];
			_kb = switch (true) do {
				case ("VEHICLE" in _kbType): { 2 };
				case ("ARMOURED" in _kbType): { 3 };
				case ("STATIC" in _kbType): { 3 };
				case ("AIR" in _kbType): { 4 };
				default { 1.5 };
			};
			
			if (_x knowsAbout _foundEnemy < _kb) then {
				["DEBUG", format["[%1] Revealing %2 to %3 (%4 to %5)", _groupIDx, _foundEnemy, group _x, _x knowsAbout _foundEnemy, _kb]] call _ZAI_fnc_LogMsg;
				(group _x) reveal [_foundEnemy, _kb];
			};
		} forEach (_alliedUnitList select { 
			alive _x &&
			local _x &&
			((_x distance _foundEnemy < _shareDist) || "STATIC" in (_x getVariable ["ZAI_Type",[]])) &&
			leader _x == _x && 
			(_group getVariable ["ZAI_AREA", _area]) == _area
		});
	};
	
	// Recently reacted, enemy going too fast or too far
	if (time < _lastTime || (getPosATL _foundEnemy) # 0 > 25) exitWith {};

	["DEBUG", format["[%1] Spotted %2 - %3m", _groupIDx, name _foundEnemy, round (_groupLeader distance2D _foundEnemy)]] call _ZAI_fnc_LogMsg;
	
	// In contact with target so request an immediate fire mission at target position.
	if (_wasHit) then {
		_group enableAttack true; // Re-enable attack orders if they were disabled.
		 
		// If infantry were shot, return fire
		if (_isMan) then {
			{ 
				_x setUnitPosWeak "DOWN";
				_x doWatch _foundEnemy;
				if (random 1 > 0.5) then { sleep 1; _x selectWeapon "throw"; _x forceWeaponFire ["SmokeShellMuzzle","SmokeShellMuzzle"] };
			} forEach units _group;
			
			(selectRandom units _group) suppressFor (10 + random 10);
		};
	};
				
	_lastTime = time + _alertTime; // Update delay timer.
	
	// Don't order statics to move!
	if (_isStatic || !_isSoldier) exitWith {};
	
	// If waiting for contact, allow the group to move.
	_holdMove = FALSE;
			
	// If distance is shorter then safe distance, use that instead.
	_moveDist = _safeDist min (_groupLeader distance _foundEnemy);
	
	_avoidPos = _groupLeader getRelPos [_moveDist,(_groupLeader getRelDir _foundEnemy) - (90 + random 25 - random 25)]; // Left of Unit
	_flankPos = _foundEnemy getRelPos [_moveDist,(_foundEnemy getRelDir _groupLeader) + (90 + random 25 - random 25)]; // Left of Target
	
	_avoidPosR = _groupLeader getRelPos [_moveDist,(_groupLeader getRelDir _foundEnemy) + (90 + random 25 - random 25)]; // Right of Unit
	_flankPosR = _foundEnemy getRelPos [_moveDist,(_foundEnemy getRelDir _groupLeader) - (90 + random 25 - random 25)]; // Right of Target
			
	// Flank left or right.
	if (random 1 > 0.5) then { _avoidPos = _avoidPosR; _flankPos = _flankPosR };	
	
	// Find a suitable road nearby
	if (!isNull _groupVehicle) then {
		_avoidRoad = [_avoidPos, 100] call BIS_fnc_nearestRoad;
		if (!isNull _avoidRoad) then { _avoidPos = getPos _avoidRoad };
	
		_flankRoad = [_flankPos, 100] call BIS_fnc_nearestRoad;
		if (!isNull _flankRoad) then { _flankPos = getPos _flankRoad };
	};
	
	// Find a valid movement position
	_movePos = _avoidPos;
	{
		if (_x#0 inArea _areaMarker) exitWith { _movePos = _x#0 };
	} forEach (selectBestPlaces [_foundEnemy, _safeDist,"(6*hills + 2*forest + 4*houses + 1.5*meadow + 2*trees) - (1000*sea) - (100*deadbody)", 100, 5]);
			
	_evadeWPs = [_avoidPos, _flankPos, _attackPos];
	
	{ 
		// Remove any WPs on water
		if (surfaceIsWater _x) then { _evadeWPs deleteAt _forEachIndex };
	} forEach _evadeWPs;	
	
	// No WPs left, exit.
	if (count _evadeWPs == 0) exitWith {}; 
	
	// Remove movePos if on water
	if (surfaceIsWater _movePos) then { _movePos = selectRandom _evadeWPs };
	
	// Clear wayPoints	
	while {count wayPoints _group > 1} do { deleteWaypoint ((wayPoints _group)#0); sleep 0.5; };
	
	// Infantry in contact, fight directly or run.
	if (_wasHit && _isMan) then {
		if (count units _group > 2) then {
			// Attack Enemy
			_wp = _group addWaypoint [_attackPos, 0];
			_wp setWaypointType "SAD";
			_wp setWaypointSpeed "FULL";
			_wp setWaypointFormation "WEDGE";
			_group setCurrentWaypoint _wp;
			_group enableAttack true;
			
			[_group, "Task", "ATTACK"] call _ZAI_fnc_setGroupVariable;
		} else {
			// Smoke and run
			_smoke = "SmokeShell" createVehicle (_groupLeader getPos [random 3, ( _attackPos getDir _groupLeader)]); 
			_wp = _group addWaypoint [( _groupLeader getPos [_safeDist, ( _attackPos getDir _groupLeader)]), 0];
			_wp setWaypointSpeed "FULL";
			_wp setWaypointStatements ["true", "(group this) enableAttack true"];
			_wp setWaypointFormation "WEDGE";
			_group setCurrentWaypoint _wp;
			_group enableAttack false;
			{ doStop _x; _x doFollow _groupLeader } forEach units _group; // Regroup
			
			[_group, "Task", "RETREAT"] call _ZAI_fnc_setGroupVariable;
		};
	} else {
		// Follow a vector - Favour movement over direct attacks.
		// EVADE - Find a good position to move to.
		// FLANK - Relocate but do not move on enemy.
		// ATTACK - Directly attack.
		// ASSAULT - Flank and then move on enemy.
		_taskType = selectRandom ["EVADE","EVADE","FLANK","ATTACK","ASSAULT"];
		switch (_taskType) do {
			case "EVADE": {
				[_group,"Task",_taskType] call _ZAI_fnc_setGroupVariable;
				_evadeWPs = [_movePos];
			};
			case "FLANK": {
				[_group,"Task",_taskType] call _ZAI_fnc_setGroupVariable;
				_evadeWPs = _evadeWPs - [_attackPos];
			};
			case "ATTACK": {
				[_group,"Task",_taskType] call _ZAI_fnc_setGroupVariable;
				_evadeWPs = _evadeWPs - [_avoidPos] - [_flankPos];
			};
			default {
				[_group,"Task",_taskType] call _ZAI_fnc_setGroupVariable;
			};
		};

		// Issue each WP from array
		{
			_wp = _group addWaypoint [_x, 0];
			_wp setWaypointType "MOVE";
			_wp setWaypointSpeed "NORMAL";
			_wp setWaypointBehaviour "AWARE";
			_wp setWaypointCompletionRadius (_closeEnough / 2);
			
			if (_isMan) then { _wp setWaypointFormation "WEDGE"; };
			
			if (_forEachIndex == 0) then { _group setCurrentWaypoint _wp };
			if (_x isEqualTo _flankPos && !canFire (vehicle _groupLeader)) then { _wp setWaypointType "GETOUT"; _wp setWaypointStatements ["true", "{ unassignVehicle _x; [_x] orderGetIn false; } forEach units this;"]; };
			if (_x isEqualTo _attackPos) then { _wp setWaypointSpeed "FULL"; _wp setWaypointType "SAD"; };
		} forEach _evadeWPs;
		
		["DEBUG", format["[%1] Task %2 - %3 WPs added.", _groupIDx, _taskType, count _evadeWPs]] call _ZAI_fnc_LogMsg;
	};

	_lastTime = time + _alertTime; // Update delay timer.
};
			
// If we're active and can move, see if anyone needs help or we're out of Wps.
if (!_isStatic && !_holdMove) then {

	// Find any ZAI groups in combat (ignore all other AIs)
	_combatArea = (_alliedUnitList findIf { side _group == side _x && _groupLeader distance leader _x < (_shareDist * 2) && behaviour leader _x == "COMBAT" && alive leader _x } > 0);

	// Find new WP if we don't have one
	if ((count wayPoints _group) - (currentWaypoint _group) isEqualTo 0) then {	
		// find a new target that's not too close to the current position
		_newGrpPos = getPos _groupLeader;				
					
		_tries = 0;					
		while {(_unitPos distance2D _newGrpPos) < _minDist} do {
			_tries = _tries + 1;
			_tempPos = [_areaMarker] call BIS_fnc_randomPosTrigger;					
			_roads = (_tempPos nearRoads _safeDist) select { count (roadsConnectedTo _x) > 0};
			_water = surfaceIsWater _tempPos;
			
			// Air takes any location.
			if _isAir exitWith { _newGrpPos = _tempPos };
			
			// Boats need water.
			if (_water && _isBoat) exitWith { _newGrpPos = _tempPos };
			
			// Cars need a road
			if (!_water && (_isCar || _isTank) && !(_roads isEqualTo [])) exitWith { _newGrpPos = getPos (_roads#0) };
			
			// Infantry
			if (!_water && _isMan && !(_roads isEqualTo []) && random 1 > 0.5) exitWith { _newGrpPos = getPos (_roads#0) };
			if (!_water && _isMan) exitWith { _newGrpPos = _tempPos; };
			
			if (_tries > 25) exitWith { 
				["WARNING", format["[%1] Tried %2 times to find WP [%3]",_groupIDx, _tries, _groupType]] call _ZAI_fnc_LogMsg;
				_newGrpPos = _tempPos
			};
			
			sleep 0.1;
		};
		
		_newGrpPos set [2,0];
		
		["DEBUG", format["[%1] Found WP %2 %3m after %4 tries (Combat: %5)",_groupIDx, _newGrpPos, round (_unitPos distance2D _newGrpPos), _tries, (!isNull _foundEnemy || _combatArea )]] call _ZAI_fnc_LogMsg;

		_wp = _group addWaypoint [_newGrpPos, 25];
		_wp setWaypointType (["MOVE","SAD"] select _isAir);
		_wp setWaypointCompletionRadius (_closeEnough / 2);
		
		_wp setWaypointCombatMode "YELLOW";
		_wp setWaypointFormation "FILE";
		_wp setWaypointBehaviour (["SAFE", "AWARE"] select (!isNull _foundEnemy || _combatArea ));
		_wp setWaypointSpeed (["LIMITED", "NORMAL"] select (!isNull _foundEnemy || _combatArea ));
		
		_group setCurrentWaypoint _wp;
		[_group, "Task", "PATROL"] call _ZAI_fnc_setGroupVariable;
		
		if ("Man" in _groupType) then { _groupLeader commandMove _newGrpPos; { doStop _x; _x doFollow _groupLeader } forEach units _group; }; // Regroup
	} else {
		// Go alert if unit wanders into a hot area.
		if (_combatArea && behaviour leader _group == "SAFE") then {
			_group setBehaviour "AWARE";
			_group setSpeedMode "NORMAL";
		};
	};
};

// Artillery Support
if _isArty then {					
	private _artyQueue = missionNamespace getVariable [format["ZAI_%1_ArtyQueue", side _group],[]];
	private _artyRadius = 0;
	private _artyTarget = [0,0,0];
	
	if (count _artyQueue == 0) exitWith {};
	
	if (!canFire _groupVehicle) exitWith { 
		_isArty = false;
		["DEBUG", format["[%1] Artillery Aborted (Gun Cannot Fire)", _groupIDx]] call _ZAI_fnc_LogMsg;
	};
	
	if (_lastTime > time) exitWith {
		["DEBUG", format["[%1] Artillery Waiting (Ready: %2s - Waiting: %3)", _groupIDx, _lastTime - time, count _artyQueue]] call _ZAI_fnc_LogMsg;
	};
	
	// Filter fire positions from any requests.
	{
		_artyRadius = if (_x distance (nearestBuilding _x) < 25) then { ZAI_artyUrban } else { ZAI_artyRural };
		private _artyEntities = (_x nearEntities (_artyRadius - 50)) select { !isAgent teamMember _x && side _x in [WEST, EAST, INDEPENDENT, CIVILIAN] };
		
		_bluClose = { side _x in [side _group, CIVILIAN] } count _artyEntities;
		_opfClose = { side _x != side _group && side _x != CIVILIAN } count _artyEntities;

		// Valid Target - Exit loop
		if (_opfClose > 0 && _bluClose < _opfClose) exitWith {				
			_artyTarget = _x;
			["DEBUG", format["[%1] Artillery Target Found %2 (BLU: %3 OPF: %4)", _groupIDx, _artyTarget, _bluClose, _opfClose]] call _ZAI_fnc_LogMsg;
		};
		
		// Invalid Target
		_artyQueue = _artyQueue - [_x];
		["DEBUG", format["[%1] Artillery Removing %2 (BLU: %3 OPF: %4)", _groupIDx, _x, _bluClose, _opfClose]] call _ZAI_fnc_LogMsg;
	} forEach _artyQueue;
	
	// Update the queue list, removing any requests near the target area.
	missionNamespace setVariable [format["ZAI_%1_ArtyQueue", side _group], (_artyQueue - (_artyQueue select { _x distance _artyTarget <= _artyRadius }))];
	
	if (_artyTarget isEqualTo [0,0,0]) exitWith { 
		_lastTime = time + 10;
		["DEBUG", format["[%1] Artillery Aborted - No Valid Targets", _groupIDx]] call _ZAI_fnc_LogMsg;
	};
	
	if !(_artyTarget inRangeOfArtillery [[_groupLeader], (getArtilleryAmmo [_groupVehicle] select 0)]) exitWith {
		_lastTime = time + 10;
		["DEBUG", format["[%1] Artillery Aborted - Invalid Range", _groupIDx]] call _ZAI_fnc_LogMsg;
	};

	["DEBUG", format["[%1] Artillery Mission Started %2", _groupIDx, _artyTarget]] call _ZAI_fnc_LogMsg;
	
	_tempSmoke = "SmokeShellRed" createVehicle (_artyTarget getPos [random 5, random 360]); 
	
	sleep 30;
	
	for "_i" from 1 to 6 do {
		_groupLeader commandArtilleryFire [(_artyTarget getPos [random _artyRadius, random 360]), (getArtilleryAmmo [vehicle _groupLeader] select 0), 1];
		["DEBUG", format["[%1] Artillery Mission Round Out (%2 of 6)", _groupIDx, _i]] call _ZAI_fnc_LogMsg;
		sleep 5 + random 10;
	};
	
	(vehicle _groupLeader) setVehicleAmmo 1;
	missionNamespace setVariable [format["ZAI_%1_ArtyRequest", side _group], []];
	_lastTime = time + _artyTime;
};

// Check for any AI Issues!
if (!_isStatic && !_holdMove && !dynamicSimulationEnabled _group && !dynamicSimulationEnabled _groupVehicle) then {
	if ((_lastPos distance2D getPos _groupLeader) == 0 && !_wasHit) then {
		_lastCount = _lastCount + 1;
		
		// Vehicles
		if (!_isMan) then {
			if (_lastCount == 10) exitWith { 
				while {count wayPoints _group > 0} do { deleteWaypoint ((wayPoints _group)#0); sleep 0.5; };
				_wp = _group addWaypoint [getPos _groupLeader, 0];
				["WARNING", format["[%1] Vehicle held for %2 cycles - Clearing WPs", _groupIDx, _lastCount]] call _ZAI_fnc_LogMsg;
			};
			if (_lastCount == 20) exitWith {
				vehicle _groupLeader setDamage 0;
				_group leaveVehicle vehicle _groupLeader;
				["WARNING", format["[%1] Vehicle held for %2 cycles - Repairing", _groupIDx, _lastCount]] call _ZAI_fnc_LogMsg;
			};
			if (_lastCount == 30) exitWith {
				vehicle _groupLeader setFuel 0.05;
				_group leaveVehicle vehicle _groupLeader;
				["WARNING", format["[%1] Vehicle held for %2 cycles - Abandoning", _groupIDx, _lastCount]] call _ZAI_fnc_LogMsg;
			};
		};
		
		// Infantry
		if (_isMan) then {
			if (_lastCount == 10) exitWith {
				while {count wayPoints _group > 1} do { deleteWaypoint ((wayPoints _group)#0); sleep 0.5; };
				["WARNING", format["[%1] Leader held for %2 cycles - Clearing WPs", _groupIDx, _lastCount]] call _ZAI_fnc_LogMsg;
			};
			if (_lastCount == 15) exitWith {
				{
					_x setPos ([getPos _x, 1, 25, 2, 0, 0, 0, [], [getPos _x, getPos _x]] call BIS_fnc_findSafePos);
				} forEach units _group;
				["WARNING", format["[%1] Leader held for %2 cycles - Moving to SafePos", _groupIDx, _lastCount]] call _ZAI_fnc_LogMsg;
			};
			if (_lastCount MOD 5 == 0) then {
				(_groupLeader) selectWeapon primaryWeapon (_groupLeader);
				["WARNING", format["[%1] Leader held for %2 cycles - Resetting Weapon", _groupIDx, _lastCount]] call _ZAI_fnc_LogMsg;
			};
		};
	} else {
		_lastCount = 0;
	};
};

_lastPos = getPos _groupLeader;

[_group, "EnemyUnit", _foundEnemy] call _ZAI_fnc_setGroupVariable;
[_group, "EnemyPos", getPos _foundEnemy] call _ZAI_fnc_setGroupVariable;
[_group, "Behaviour", behaviour leader _group] call _ZAI_fnc_setGroupVariable;
[_group, "Speed", speedMode _group] call _ZAI_fnc_setGroupVariable;
[_group, "WaitTime", _lastTime] call _ZAI_fnc_setGroupVariable;

// slowly increase the cycle duration after an incident
if (_currCycle < _cycle) then { _currCycle = _currCycle + 0.5};
sleep _currCycle;