private _MinSpawnCircleDistance = missionNameSpace getVariable ["A3E_MinSpawnCircleDistance",800];
private _MaxSpawnCircleDistance = missionNameSpace getVariable ["A3E_MaxSpawnCircleDistance",1500];
private _removalDistance = missionNameSpace getVariable ["A3E_UnitRemovalDistance",2000];
private _groups = missionNameSpace getVariable ["A3E_CivilianCommuterGroups",[]];

if(count(missionNameSpace getVariable ["a3e_arr_Escape_MilitaryTraffic_CivilianVehicleClasses",[]]) == 0) exitWith {
	["No civilian vehicle defined.",["Spawning","CivilianCommuters"]] call a3e_fnc_log;
};

private _plist = [] call A3E_fnc_GetPlayers;

// Civilian traffic
private _maxGroups = switch (A3E_Param_EnemyFrequency) do {
	case 1: // 1-3 players
	{ 8 };
	case 2: // 4-6 players
	{ 7 };
	default // 7-8 players
	{ 6 };
};

//Reduce spawn distance in first 10 seconds of mission
if(time<10) then {
	_MinSpawnCircleDistance = _MinSpawnCircleDistance/2;
	_MaxSpawnCircleDistance = _MaxSpawnCircleDistance/2;
};

//Cleanup first
{
private _group = _x;
	if(count(units _x)==0) then {
		[format["Empty Group %1 deleted",_group],["AmbientAI","Spawning"]] call A3E_fnc_Log;
		deletegroup _x;
		_groups set [_forEachIndex,grpNull];
	} else {
		_leader = ((units _x) select 0);
		private _nearest = [getpos _leader,_plist] call A3E_fnc_NearestObjectDis;
		if(_nearest>_removalDistance) then {
			private _vehicles = [];
			{
				if(vehicle _x != _x) then {
					private _veh = (vehicle _x);
					_veh deleteVehicleCrew _x;
					_vehicles pushBackUnique _veh;
				} else {
					deleteVehicle _x;
				};
			} forEach units _x;
			{deletevehicle _x;} forEach _vehicles;
			
			[format["Group (Civilian Commuter) %1 deleted (too far)",_group],["CivilianCommuters","Spawning"],[["NearestPlayer",_nearest]]] call A3E_fnc_Log;
			deletegroup _x;
			_groups set [_forEachIndex,grpNull];
		};
	};
} forEach _groups;

//Remove deletes entries from array
_groups = _groups select {!(isNull _x)};


if(count(_groups)<_maxGroups) then {
	//Get a spawnpos around the players
	private _spawnpos = [_MinSpawnCircleDistance,_MaxSpawnCircleDistance,"ROAD"] call A3E_fnc_GetCircularSpawnPos;

	if(count(_spawnpos)==3) then {//If spawnpos failed it has <3 elements
		private _group = [_spawnpos] call A3E_fnc_SpawnCivilianVehicle;
		if (_group isEqualType grpNull) then {
			["Civilian Traffic created",["CivilianCommuters","Spawning"],[_group,_spawnpos,count(units _group)]] call A3E_fnc_Log;
			_groups pushBack _group;
			[_group] spawn A3E_fnc_CivilianCommuter;
			[_group] spawn A3E_fnc_TrackGroup_Add;
		};
		sleep 1;
	};

};
missionNameSpace setVariable ["A3E_CivilianCommuterGroups",_groups];
