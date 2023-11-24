if (!isServer) exitWith {};

_weightedSelectRandom = compileFinal preprocessFileLineNumbers "weightedSelectRandom.sqf";

_configs = [
    [1,  [["I_Soldier_TL_F","I_Soldier_AR_F","I_Soldier_F","I_Soldier_F"],
         ["I_MRAP_03_F"], false]],
    [.5, [["I_Soldier_TL_F","I_Soldier_AR_F","I_Soldier_AR_F","I_Soldier_AR_F","I_Soldier_F","I_Soldier_F"],
         []]],
    [.5, [["I_Soldier_TL_F","I_Soldier_AR_F","I_Soldier_AR_F","I_Soldier_F","I_Soldier_F","I_Soldier_F","I_Soldier_F","I_Soldier_F","I_Soldier_F","I_Soldier_F","I_Soldier_F","I_Soldier_F"],
         ["I_Truck_02_covered_F"],true]],
    [.04,[[],
         ["I_APC_Wheeled_03_cannon_F"],true]]
];
_spawns = (["spawn_"] call ws_fnc_collectMarkers) - ["respawn_east"];
_targets = [box] call ws_fnc_collectObjectsNum;

_period = 10;
_wave = 1;

_dismountRadius = 350;

switch (f_param_ZMMDiff) do {
    case 0 : {
        _period = 300;
        _wave = 3;
    };
    case 1 : {
        _period = 300;
        _wave = 5;
    };
    case 2 : {
        _period = 150;
        _wave = 5;
    };
};

_notWeapons = ["SmokeLauncher","CMFlareLauncher","Laserdesignator_mounted","SEARCHLIGHT","CarHorn","TruckHorn","TruckHorn2","TruckHorn3","SportCarHorn","MiniCarHorn","FakeHorn"];

while {true} do {
    _badTargets = [];
    {
        if (count (position _x isFlatEmpty [0,10,1,0.1,0,false]) == 0) then {
            _badTargets = _badTargets + [_x]; 
            if (f_param_debugMode == 1) then { player sideChat format ["%1 is a bad target",_x]; };
        };
    } forEach _targets;
    _targets = _targets - _badTargets;
    if (f_param_debugMode == 1 && count _targets == 0) exitWith {player sideChat "whoops, ran out of targets"};
    if ({side _x == resistance} count allUnits < 100) then {
        if (f_param_debugMode == 1) then { player sideChat "spawning some dudes" };
        for "_k" from 1 to _wave do {
            _config = _configs call _weightedSelectRandom;
            _spawn = _spawns call BIS_fnc_selectRandom;
            if (typeName _spawn == "STRING") then {
                _spawn = getMarkerPos _spawn;
            } else {
                _spawn = position _spawn;
            };
            _target = _targets call BIS_fnc_selectRandom;
            if (typeName _target == "STRING") then {
                _target = getMarkerPos _target;
            } else {
                _target = position _target;
            };

            _getOutAngle = (((_spawn select 1) - (_target select 1)) atan2 ((_spawn select 0) - (_target select 0)));
            _wiggle = ((_dismountRadius / 4) + random (_dismountRadius / 2));
            _getOutPos = [(_target select 0) + (_dismountRadius * cos _getOutAngle) + (_wiggle * sin _getOutAngle),
                          (_target select 1) + (_dismountRadius * sin _getOutAngle) + (_wiggle * cos _getOutAngle),
                          0];

            _grp = createGroup independent;
            { _x createUnit [ _spawn, _grp] } forEach (_config select 0);
            _units = units _grp;
            if (count (_config select 1) > 0) then {
                for "_i" from 0 to (count (_config select 1)) - 1 do {
                    _veh = _config select 1 select _i createVehicle _spawn;
                    _isArmed = ({!(_x in _notWeapons)} count (_veh weaponsTurret [-1]) > 0) || ({!(_x in _notWeapons)} count (_veh weaponsTurret [0]) > 0);
                    if (count _config > 2 && (_config select 2)) then {
                        createVehicleCrew _veh;
                        {
                            _x assignAsCargo _veh;
                            _x moveInCargo _veh;
                            _units = _units - [_x];
                        } forEach _units;
                        _wp = group driver _veh addWaypoint [_getOutPos,0];
                        _wp setWaypointCompletionRadius 100;
                        _wp setWaypointType "TR UNLOAD";
                        _wp setWaypointStatements ["true","{if (assignedVehicleRole _x select 0 == 'Cargo') then {unassignVehicle _x};} forEach crew vehicle this;"];
                        _veh setUnloadInCombat [true, false];
                        if (_isArmed) then {
                            _wp = group driver _veh addWaypoint [_target,0];
                            _wp setWaypointType "SAD";
                        } else {
                            _wp = group driver _veh addWaypoint [_spawn,0];
                            _wp setWaypointStatements ["true","{deleteVehicle _x} forEach thislist + [vehicle (thislist select 0)] + crew (vehicle (thislist select 0));"];
                        };
                    } else {
                        {
                            switch (_x select 0) do {
                                case "Driver" : {
                                    _units select 0 assignAsDriver _veh;
                                    _units select 0 moveInDriver _veh;
                                    _units = _units - [_units select 0];
                                };
                                case "Turret" : {
                                    _units select 0 assignAsTurret [_veh, _x select 1];
                                    _units select 0 moveInTurret [_veh, _x select 1];
                                    _units = _units - [_units select 0];
                                };
                                case "Cargo" : {
                                    _units select 0 assignAsCargoIndex [_veh, _x select 1 select 0];
                                    _units select 0 moveInCargo [_veh, _x select 1 select 0];
                                    _units = _units - [_units select 0];
                                };
                            };
                        } forEach (_veh call BIS_fnc_vehicleRoles);
                        _wp = _grp addWaypoint [_getOutPos,0];
                        _wp setWaypointCompletionRadius 100;
                        _wp setWaypointType "GETOUT";
                        _wp setWaypointStatements ["true","{unassignVehicle _x} forEach thisList; thisList allowGetIn false;"];
                        _veh setUnloadInCombat [true, true];
                    };
                    /* [_veh,_target,_grp,_dismountRadius] spawn {
                        waitUntil{ sleep .5; _this select 0 distance (_this select 1) < (_this select 3)};
                        { unassignVehicle _x } forEach units (_this select 2);
                        (_this select 2) leaveVehicle (_this select 0);
                    }; */
                };
            };
            _wp = _grp addWaypoint [_target,0];
            _wp setWayPointType "SAD";
            sleep 3;
        };
    };
    sleep _period;
};