if (!isServer) exitWith {};
params ["_locationMarkerName","_side",["_infantryClasses",[]],["_maxGroupsCount",6],["_spawnRadius",750],["_debug",false]];

if (isNil "a3e_var_commonLibInitialized") then {
    [] spawn {
        while {true} do { player sideChat "Script AmbientInfantry.sqf needs CommonLib version 1.02"; sleep 5; };
    };
};

private _possibleInfantryTypes = [];
private _isFaction = false;
if (str _infantryClasses == """USMC""") then {
    _possibleInfantryTypes = a3e_arr_InitGuardedLocations_Inf_USMC;
    _isFaction = true;
};
if (str _infantryClasses == """CDF""") then {
    _possibleInfantryTypes = a3e_arr_InitGuardedLocations_Inf_CDF;
    _isFaction = true;
};
if (str _infantryClasses == """RU""") then {
    _possibleInfantryTypes = a3e_arr_InitGuardedLocations_Inf_RU;
    _isFaction = true;
};
if (str _infantryClasses == """INS""") then {
    _possibleInfantryTypes = a3e_arr_InitGuardedLocations_Inf_INS;
    _isFaction = true;
};
if (str _infantryClasses == """GUE""") then {
    _possibleInfantryTypes = a3e_arr_InitGuardedLocations_Inf_GUE;
    _isFaction = true;
};

if (!_isFaction) then {
    _possibleInfantryTypes =+ _infantryClasses;
};

// Initialize global variable
missionNamespace setVariable ["a3e_var_guardedLocationsInstanceNo", (missionNamespace getVariable ["a3e_var_guardedLocationsInstanceNo", 0]) + 1];
private _instanceNo = a3e_var_guardedLocationsInstanceNo;

missionNamespace setVariable [format["a3e_var_guardedLocations%1",_instanceNo],[]];

for "_i" from 0 to 99 do { 
	private _locationFullName = _locationMarkerName + str _i;
	private _locationPos = getMarkerPos _locationFullName;

	if (_locationPos isEqualTo [0,0,0]) exitWith {};
	
    private _soldierCount = ([] call a3e_fnc_getDynamicSquadSize) * _maxGroupsCount;
	
	diag_log format["[ESCAPE]: Init Guarded Locations: '%1' creating #%2 garrison %3", _locationMarkerName, _i, _soldierCount];
	
	private _soldiers = [];
	for [{_j = 0}, {_j < _soldierCount}, {_j = _j + 1}] do {
		// soldier: [type, skill, spawned, damage, obj, scriptHandle, hasScript]
		_soldiers pushBack [selectRandom _possibleInfantryTypes, (a3e_var_Escape_enemyMinSkill + random (a3e_var_Escape_enemyMaxSkill - a3e_var_Escape_enemyMinSkill)), false, 0, objNull, objNull, false];
	};

    [_locationFullName, "", _soldiers, _locationPos] call compile format ["a3e_var_guardedLocations%1 set [count a3e_var_guardedLocations%2, _this];", _instanceNo, _instanceNo];
    
    private _trigger = createTrigger["EmptyDetector", getMarkerPos _locationFullName, false];
	_trigger setTriggerInterval 5;
    _trigger setTriggerArea[_spawnRadius, _spawnRadius, 0, false];
    _trigger setTriggerActivation["ANYPLAYER", "PRESENT", true];
    _trigger setTriggerTimeout [1, 1, 1, true];
    _trigger setTriggerStatements["this", 
		"_nil = [a3e_var_guardedLocations" + str _instanceNo + " select " + str _i + ", " + str _side + ", " + str _maxGroupsCount + ", " + str _debug + "] spawn drn_fnc_PopulateLocation;",
		"_nil = [a3e_var_guardedLocations" + str _instanceNo + " select " + str _i + ", " + str _debug + "] spawn drn_fnc_DepopulateLocation;"];
		
	_trigger = createTrigger ["EmptyDetector", getMarkerPos _locationFullName, false];
	_trigger setTriggerArea [100, 100, 0, false, 15];
	_trigger setTriggerActivation ["ANYPLAYER", "PRESENT", false];
	_trigger setTriggerInterval 5;
	_trigger setTriggerStatements [
		"this", 
		"{ if (local _x) then { if (!(_x checkAIFeature 'PATH') && random 1 < 0.2) then { doStop _x; _x enableAI 'PATH' }; }; } forEach (allUnits inAreaArray thisTrigger);",
		"{ if (local _x) then { if !(_x checkAIFeature 'PATH') then { _x doFollow leader _x; _x enableAI 'PATH' }; }; } forEach (allUnits inAreaArray thisTrigger);"
	];
};