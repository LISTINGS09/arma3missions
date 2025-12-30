// [5] remoteExec ["A3E_fnc_RevealPOI", 2]
params[["_numIntel",0]];

if (_numIntel <= 0) exitWith {};

private _poisHidden = (missionNameSpace getVariable ["A3E_POIs",[]] select {_x # 4});
private _poisUnknown = (missionNameSpace getVariable ["A3E_POIs",[]] select {_x # 5});
private _pois = if (count _poisHidden == 0) then { _poisUnknown } else { _poisHidden };

_numIntel = _numIntel min count(_pois);

private _markertype = "Unknown";

//A3E_POIs pushBack [_marker,_markerType,_color,_markerPosition,_hidden,_unknown,_accuracy];

if(_numIntel > 1) then {
	format["Intel about %1 locations has been added to the map.",str _numIntel] remoteExec ["systemChat",0];
} else {
	format["Intel revealed one point of interest on the map."] remoteExec ["systemChat",0];
};

for [{ _i = 0 }, { _i < _numIntel }, { _i = _i + 1 }] do { 
	
	private _poi =  selectRandom _pois;
	_pois = _pois - [_poi];
	
	if (count _pois == 0) exitWith {};
	
	private _markerType = [_poi#0] call A3E_fnc_updateLocationMarker;

	if (_poi#4) then {
		switch(_markerType) do {
			case "o_hq": { 
				format["Revealed: Communication Centre"] remoteExec ["systemChat",0];
			};
			case "o_service": { 
				format["Revealed: Vehicle Depot"] remoteExec ["systemChat",0];
			};
			case "hd_warning": { 
				format["Revealed: Allied Vehicle"] remoteExec ["systemChat",0];
			};
			case "o_installation": { 
				format["Revealed: Ammo Depot"] remoteExec ["systemChat",0];
			};
			case "o_mortar": { 
				format["Revealed: Mortar Site"] remoteExec ["systemChat",0];
			};
		}
	};
};