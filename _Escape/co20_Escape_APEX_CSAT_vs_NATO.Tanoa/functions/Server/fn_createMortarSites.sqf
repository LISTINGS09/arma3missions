if(!isServer) exitWith {};

private _positions = [];
private _i = 0;

private _countNW = 0;
private _countNE = 0;
private _countSE = 0;
private _countSW = 0;

if(isNil("A3E_MortarSiteCountMax")) then { A3E_MortarSiteCountMax = 6 };
if(isNil("A3E_MortarSiteCountMin")) then { A3E_MortarSiteCountMin = 4 };
  
A3E_MortarSiteCountMin = A3E_MortarSiteCountMin * A3E_Param_Artillery;
A3E_MortarSiteCountMax = A3E_MortarSiteCountMax * A3E_Param_Artillery;
private _mortarSiteCount = A3E_MortarSiteCountMin + random (A3E_MortarSiteCountMax-A3E_MortarSiteCountMin);

private _regionCount = ceil(_mortarSiteCount/4);
while {count _positions < _mortarSiteCount} do {
    private _isOk = false;
    private _j = 0;
	private _pos = [];

    while {!_isOk} do {
        _pos = call A3E_fnc_findFlatArea;
        _isOk = true;

        if (_pos select 0 <= ((getpos center) select 0) && _pos select 1 > ((getpos center)select 1)) then {
            if (_countNW <= _regionCount) then {
                _countNW = _countNW + 1;
            } else { _isOk = false };
        };
        if (_pos select 0 > ((getpos center)select 0) && _pos select 1 > ((getpos center) select 1)) then {
            if (_countNE <= _regionCount) then {
                _countNE = _countNE + 1;
            } else { _isOk = false };
        };
        if (_pos select 0 > ((getpos center)select 0) && _pos select 1 <= ((getpos center) select 1)) then {
            if (_countSE <= _regionCount) then {
                _countSE = _countSE + 1;
            } else { _isOk = false };
        };
        if (_pos select 0 <= ((getpos center)select 0) && _pos select 1 <= ((getpos center) select 1)) then {
            if (_countSW <= _regionCount) then {
                _countSW = _countSW + 1;
            } else { _isOk = false };
        };

        _j = _j + 1;
        if (_j > 100) then {
            _isOk = true;
        };
    };

    private _tooCloseAnotherPos = false;

	//Check if too close to another depot, comcenter or start
	{
        if (_pos distance _x < A3E_ClearedPositionDistance) then { _tooCloseAnotherPos = true };
    } forEach A3E_Var_ClearedPositions;


    if (!_tooCloseAnotherPos) then {
        _positions pushBack _pos;
		A3E_Var_ClearedPositions pushBack _pos;
    };

    _i = _i + 1;
    if (_i > 100) exitWith { _positions };
};

private _mortarSiteTemplates = missionNameSpace getVariable ["A3E_MortarSiteTemplates",
	[A3E_fnc_MortarSite,
	A3E_fnc_MortarSite2,
	A3E_fnc_MortarSite3,
	A3E_fnc_MortarSite4,
	A3E_fnc_MortarSite5,
	A3E_fnc_MortarSite6]
];

{
	[_x] call (selectRandom _mortarSiteTemplates);
	[_x, 40, selectRandom[A3E_VAR_Side_Opfor,A3E_VAR_Side_Ind], "MORTAR"] call A3E_fnc_initLocationZone;
} forEach _positions;