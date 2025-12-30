private _factionsArray = [A3E_VAR_Side_Ind, A3E_VAR_Side_Ind , A3E_VAR_Side_Opfor];
private _minSpawnDistance = (missionNamespace getvariable["A3E_MinRoadblockSpawnDistance",1500]);
private _maxSpawnDistance = (missionNamespace getvariable["A3E_MaxRoadblockSpawnDistance",2000]);
private _minDistanceBetweenRoadBlocks = (missionNamespace getvariable["A3E_MinRoadblockDistance", 1500]);
private _maxNumberOfRoadBlocks = missionnameSpace getvariable ["A3E_MaxNumberOfRoadblocks",15];

if isNil("A3E_RoadBlocks") then { missionNameSpace setVariable ["A3E_RoadBlocks",[]] };

if(count A3E_RoadBlocks >= _maxNumberOfRoadBlocks) exitwith {["Max number of roadblocks reached",["Roadblocks"]] call A3E_fnc_Log;};

private _pos = [_minSpawnDistance,_maxSpawnDistance,"ROAD"] call a3e_fnc_getCircularSpawnPos;

if(count(_pos)<3) exitwith {["Unable to find a suitable position for Roadblock. Skipping.",["Roadblocks"]] call A3E_fnc_Log;};

if({_pos distance _x < _minDistanceBetweenRoadBlocks} count A3E_RoadBlocks > 0) exitwith {["Roadblock too near to other roadblock. Skipping.",["Roadblocks"]] call A3E_fnc_Log;};

private _roads = _pos nearRoads 10;

if(count(_roads)==0) exitwith {["No road at position. Skipping.",["Roadblocks"]] call A3E_fnc_Log;};

private _roadSegment = _roads#0;
private _roadConnectedTo = roadsConnectedTo _roadSegment;

if(count(_roadConnectedTo) == 0) exitwith {["RoadSegment is has no connected roads. Skipping.",["Roadblocks"]] call A3E_fnc_Log;};

_connectedRoad = _roadConnectedTo select 0;

private _dir = [_roadConnectedTo select 0, _roadConnectedTo  select 1] call BIS_fnc_DirTo;

_pos = getPos _roadSegment;

if (random 100 < 50) then { _dir = _dir + 180 };

[format["A3E_Roadblock_%1",count A3E_RoadBlocks],_pos,"mil_warning","ColorEast",false,false] call a3e_fnc_createLocationMarker;

private _side = selectRandom _factionsArray;
private _zoneIndex = [_pos, 30, _side, "ROADBLOCK"] call A3E_fnc_initLocationZone;
private _zone = A3E_Zones # _zoneIndex;
private _groups = _zone getOrDefault ["groups",[]];

private  _possibleVehicles = if(_side == A3E_VAR_Side_Opfor) then { a3e_arr_Escape_RoadBlock_MannedVehicleTypes } else { a3e_arr_Escape_RoadBlock_MannedVehicleTypes_Ind };
private _vehicle = objNull;

if(count(_possibleVehicles) > 0) then {
	private _result = [_pos, 0, selectRandom _possibleVehicles, _side] call BIS_fnc_spawnVehicle;
	_vehicle = _result#0;
	[_vehicle] call a3e_fnc_onVehicleSpawn;
	_groups pushback (_result#2);
	[_result#2] call a3e_fnc_onEnemyGroupSpawn;
	{ [_x] call a3e_fnc_onEnemySoldierSpawn } foreach (_result#1);
};

private _static = objNull;

if(count(a3e_arr_ComCenStaticWeapons) > 0) then {
	_static = createVehicle [selectRandom a3e_arr_ComCenStaticWeapons, _pos, [], 0, "NONE"];
	private _unit = [_static,_side] call A3E_fnc_AddStaticGunner; 
	[_static] call a3e_fnc_onVehicleSpawn;
	[group _unit] call a3e_fnc_onEnemyGroupSpawn;
	[_unit] call a3e_fnc_onEnemySoldierSpawn;
	_groups pushback (group _unit);
};

private _RoadblockTemplates = missionNameSpace getVariable ["A3E_RoadblockTemplates",[A3E_fnc_Roadblock,A3E_fnc_Roadblock2,A3E_fnc_Roadblock3,A3E_fnc_Roadblock4,A3E_fnc_Roadblock5,A3E_fnc_Roadblock6,A3E_fnc_Roadblock7,A3E_fnc_Roadblock8,A3E_fnc_Roadblock9,A3E_fnc_Roadblock10]];
private _units = [_pos, _dir, _static, _vehicle] call selectRandom _RoadblockTemplates;

_zone set ["groups",_groups];

A3E_RoadBlocks pushBack _pos;

["Roadblock Created",["Roadblocks"],[_pos]] call A3E_fnc_Log;