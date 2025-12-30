
if (isServer) then {
	call compile preprocessFileLineNumbers ("Island\PatrolBoatMarkers.sqf");
	
	if(isNil "a3e_patrolBoatMarkers") exitWith {
		["Patrolboatmarkers not found!"] call BIS_fnc_error;
	};

	private _showMarkers = A3E_Debug;
	private _villageIndex = 0;

	{
		private _markerName = "a3e_aquaticPatrolMarker" + str _villageIndex;
		
		_x params ["_pos","_dir","_shape","_size"];

		private _marker = createMarkerLocal [_markerName, _pos];
		
		if (!_showMarkers) then {
			_marker setMarkerAlphaLocal 0;
		};

		_marker setMarkerShapeLocal _shape;
		_marker setMarkerDirLocal _dir;
		_marker setMarkerSizeLocal _size;

		_villageIndex = _villageIndex + 1;
	} forEach a3e_patrolBoatMarkers;
	a3e_var_aquaticPatrolMarkersInitialized = true;
};


