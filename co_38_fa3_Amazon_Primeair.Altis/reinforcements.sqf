if (!isServer) exitWith {};

_spawnPoints = ["syrta", "galati", "airport"];
_destinations = ["northroad","highway", "southroad", "churcharea", "mainroad"];

_tifrit = ["T","O_MRAP_02_F", 4];
_hmgifrit = ["A","O_MRAP_02_hmg_F"];

_spawns = [[0,  [_tifrit]], // 0 min : 1 Ifrit w/ troops
		   [300,[_tifrit, _tifrit]], //5 min, 2 Ifrit w/ troops
		   [600,[_tifrit, _tifrit]], //10 min, 2 Ifrit w/ troops
		   [900,[_tifrit, _hmgifrit]],//15 min, 1 troop Ifrit, 1 HMG Ifrit
		   [1200,[_tifrit, _hmgifrit]],//20 min, 1 troop Ifrit, 1 HMG Ifrit
		   [1500,[ ["A", "O_APC_Wheeled_02_rcws_F"] ]], //25 min, 1 Marid
		   [1800,[ ["A", "O_MBT_02_cannon_F"] ]]]; //30 min, 1 T-100
_repeatSpawn = [180, ["O_MBT_02_cannon_F"]];
		   

_newGroup = createGroup east; // create new group or units will never stop holding
{[_x] joinSilent _newGroup} forEach barracksUnits;
(_newGroup addWaypoint [getMarkerPos "churcharea", 0]) setWaypointType "SAD";

_timezero = time;

{
	waitUntil {time - _timezero >= (_x select 0)};
	{
		_spawn = _spawnPoints call BIS_fnc_selectRandom;
		_veh = [getMarkerPos _spawn, 0, _x select 1, EAST] call BIS_fnc_spawnVehicle;
		if (f_param_debugMode == 1) then {
			player sideChat format ["reinforcements: spawning %1 at %2", _x select 1, _spawn];
		};
		switch (_x select 0) do {
			case "T": { //transport
				_grp = [];
				for "_i" from 1 to (_x select 2) do {
					_grp = _grp + ["O_Soldier_F"];
				};
				_grp = [getMarkerPos _spawn, EAST, _grp] call BIS_fnc_spawnGroup;
				if (f_param_debugMode == 1) then {
					player sidechat format ["%1", units _grp];
				};
				{_x moveInCargo (_veh select 0); _x assignAsCargo (_veh select 0)} forEach units _grp;
				_wp = _veh select 2 addWaypoint [getMarkerPos (_destinations call BIS_fnc_selectRandom),0];
				_wp setWaypointType "TR UNLOAD";
				_wp = _veh select 2 addWaypoint [getMarkerPos _spawn,0];
			};
			case "A": { //attack
				_wp = _veh select 2 addWaypoint [getMarkerPos (_destinations call BIS_fnc_selectRandom),0];
				_wp setWaypointType "SAD";
			};
			default {
				_veh select 2 addWaypoint [getMarkerPos (_destinations call BIS_fnc_selectRandom),0];
			};
		};
		sleep 5;
	} forEach (_x select 1);
} forEach _spawns;

while {true} do {
	_timezero = time;
	waitUntil {time - _timezero >= (_repeatSpawn select 0)};
	_wp = _veh select 2 addWaypoint [getMarkerPos (_destinations call BIS_fnc_selectRandom),0];
	_wp setWaypointType "SAD";
};
