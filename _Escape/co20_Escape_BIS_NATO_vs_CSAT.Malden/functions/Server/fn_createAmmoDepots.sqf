if(!isServer) exitWith {};

private _positions = [];
private _i = 0;

private _countNW = 0;
private _countNE = 0;
private _countSE = 0;
private _countSW = 0;

if(isNil("A3E_AmmoDepotCount")) then { A3E_AmmoDepotCount = 8 };

private _regionCount = ceil(A3E_AmmoDepotCount/4);
while {count _positions < A3E_AmmoDepotCount} do {
    private _isOk = false;
    private _j = 0;
	private _pos = [];

    while {!_isOk} do {
        _pos = call A3E_fnc_findFlatArea;
        _isOk = true;

        if (_pos select 0 <= ((getpos center) select 0) && _pos select 1 > ((getpos center)select 1)) then {
            if (_countNW <= _regionCount) then { _countNW = _countNW + 1 } else { _isOk = false };
        };
        if (_pos select 0 > ((getpos center)select 0) && _pos select 1 > ((getpos center) select 1)) then {
            if (_countNE <= _regionCount) then { _countNE = _countNE + 1 } else { _isOk = false };
        };
        if (_pos select 0 > ((getpos center)select 0) && _pos select 1 <= ((getpos center) select 1)) then {
            if (_countSE <= _regionCount) then { _countSE = _countSE + 1 } else { _isOk = false };
        };
        if (_pos select 0 <= ((getpos center)select 0) && _pos select 1 <= ((getpos center) select 1)) then {
            if (_countSW <= _regionCount) then { _countSW = _countSW + 1 } else { _isOk = false };
        };

        _j = _j + 1;
        if (_j > 100) then { _isOk = true };
    };

    private _tooCloseAnotherPos = false;

	//Check if too close to another depot, comcenter or start
	{
        if (_pos distance _x < A3E_ClearedPositionDistance) then { _tooCloseAnotherPos = true };
    } forEach A3E_Var_ClearedPositions;


    if (!_tooCloseAnotherPos) then {
        _positions pushBack  _pos;
		A3E_Var_ClearedPositions pushBack _pos;
    };

    _i = _i + 1;
    if (_i > 100) exitWith { _positions };
};

private _AmmoDepotTemplates = missionNamespace getVariable ["A3E_AmmoDepotTemplates",
	[
		A3E_fnc_AmmoDepot
		,A3E_fnc_AmmoDepot2
		,A3E_fnc_AmmoDepot3
		,A3E_fnc_AmmoDepot4
		,A3E_fnc_AmmoDepot5
		,A3E_fnc_AmmoDepot6
		,A3E_fnc_AmmoDepot7
		,A3E_fnc_AmmoDepot8
		,A3E_fnc_AmmoDepot9
		,A3E_fnc_AmmoDepot10
		,A3E_fnc_AmmoDepot11
		,A3E_fnc_AmmoDepot12
	]
];

{ [_x, a3e_arr_Escape_AmmoDepot_StaticWeaponClasses, a3e_arr_Escape_AmmoDepot_ParkedVehicleClasses] call selectRandom _AmmoDepotTemplates } foreach _positions;
{ [_x, 60, selectRandom[A3E_VAR_Side_Opfor], "AMMODEPOT"] call A3E_fnc_initLocationZone } foreach _positions;

missionNamespace setVariable ["a3e_var_Escape_AmmoDepotPositions", _positions, true];

