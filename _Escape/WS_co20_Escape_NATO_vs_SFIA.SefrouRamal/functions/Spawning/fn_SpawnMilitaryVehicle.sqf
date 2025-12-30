params["_pos", "_side"];

private _possibleVehicles = if (_side == A3E_VAR_Side_Opfor) then { a3e_arr_Escape_MilitaryTraffic_EnemyVehicleClasses } else { a3e_arr_Escape_MilitaryTraffic_EnemyVehicleClasses_Ind };

private _vehicleType = selectRandom _possibleVehicles;
private _road = roadAt _pos;
private _direction = 0;

if(!isNull _road) then { _direction = getdir _road };

["Spawning vehicle.",["Spawning","MilitaryTraffic"],[_pos, _direction, _vehicleType, _side]] call a3e_fnc_log;
private _result = [_pos, _direction, _vehicleType, _side] call BIS_fnc_spawnVehicle;
_result params ["_vehicle", "_crew", "_group"];

[_vehicle] call a3e_fnc_onVehicleSpawn;
[_group] call A3E_fnc_onEnemyGroupSpawn;
{ [_x] call A3E_fnc_onEnemySoldierSpawn } forEach _crew;

["Created Military Vehicle.",["Spawning","MilitaryTraffic"],[_vehicleType]] call a3e_fnc_log;

_group