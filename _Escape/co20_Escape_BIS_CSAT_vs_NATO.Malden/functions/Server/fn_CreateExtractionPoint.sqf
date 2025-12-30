params["_markerNo","_extractionType"];
diag_log format["fn_CreateExtractionPoint: Type is %1",_extractionType];

private _markertype = "air";
switch (_extractionType) do {
	case "air": {
		_markertype = "A3E_HeliExtractionPos";
	};
	case "sea": {
		_markertype = "A3E_BoatExtractionPos";
	};
	case "land": {
		_markertype = "A3E_CarExtractionPos";
	};
	case "old": {
		_markertype = "A3E_ExtractionPos";
	};
};
	
private _markerPos1 = getMarkerPos (_markertype + str _markerNo);
private _markerPos2 = getMarkerPos (_markertype + str _markerNo + "_1");

if (_markerPos2 isEqualTo [0,0,0]) then { _markerPos2 = _markerPos1 getPos [50, random 360] };

private _location = "Land_HelipadEmpty_F" createvehicle _markerPos1;
private _location2 = "Land_HelipadEmpty_F" createvehicle _markerPos2;
private _location3 = "Land_TacticalBacon_F" createvehicle _markerPos1;

private _code = compile format["[%1,""%2"",_this] call A3E_fnc_firedNearExtraction;",_markerNo,_extractionType];

_location3 addEventHandler["firedNear", _code];
diag_log format["fn_CreateExtractionPoint: eventHandler added at %1",(getpos _location)];
diag_log format["%1",(str _code)];