///////LV_fnc_nearestBuilding.sqf 0.4 - SPUn / LostVar
//Returns array of real buildings, excluding other "house" objects
//_type "radius" returns [all buildings in radius]
//_type "nearest" returns [nearest building]
private["_houseObjects","_center0","_buildings","_bld"];
params ["_type","_center","_radius"];

if(_center in allMapMarkers)then{
	_center0 = getMarkerPos _center;
}else{
	if (_center isEqualType []) then{
		_center0 = _center;
	}else{
		_center0 = getPos _center;
	};
};

_buildings = [];

switch (_type) do {
	case "radius":{
		_houseObjects = nearestObjects [_center0, ["building"], _radius];
	};
	case "nearest":{
		_houseObjects = nearestObjects [_center0, ["building"], 500];
	};
};

if(isNil("_houseObjects"))exitWith{_buildings};
if((count _houseObjects)==0)exitWith{_buildings};

{
	if( str (_x buildingPos 0) != "[0,0,0]") then {_buildings pushBack _x};
} forEach _houseObjects;

if((count _buildings)==0)exitWith{_buildings};

switch (_type) do {
	case "radius":{
		_buildings;
	};
	case "nearest":{
		_bld = _buildings select 0;
		{
			if ((_x distance _center) < (_bld distance _center)) then { _bld = _x};
		} forEach _buildings;
		_buildings = [_bld];
		_buildings;
	};
};