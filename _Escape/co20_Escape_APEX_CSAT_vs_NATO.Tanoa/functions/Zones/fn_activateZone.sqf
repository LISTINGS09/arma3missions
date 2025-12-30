params ["_zoneIndex"];

private _zone = A3E_Zones select _zoneIndex;

[format["Activating Zone %1 (%2)", _zoneIndex, _zone get "type"],["Zones","Spawning"]] call a3e_fnc_log;

private _active = _zone get "active";
private _initialized = _zone get "initialized";
if(!(_active)) then {
	private _marker = _zone get "marker";
	
	_marker setMarkerColor "ColorYellow";
	_marker setMarkerAlpha (if A3E_Debug then { 0.5 } else { 0 });
	
	if(!_initialized) then {
		private _onInit = _zone get "oninit";
		[_zoneIndex] call (missionNameSpace getVariable _onInit);
		_zone set ["active",true];
		_zone set ["initialized",true];

	} else {
		[_zoneIndex] call A3E_fnc_DeserializeZoneGroups;
		_zone set ["active",true];
	};
};