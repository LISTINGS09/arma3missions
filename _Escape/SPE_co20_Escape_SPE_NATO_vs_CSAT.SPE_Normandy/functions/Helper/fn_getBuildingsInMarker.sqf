private _mrk = [_this, 0, "NoName", [""]] call BIS_fnc_param;
private _pos = getmarkerpos _mrk;
private _shape = markerShape _mrk;
private _rotation = markerDir _mrk;
private _size = getmarkersize _mrk;
private _radius = 0;

if(_shape == "ELLIPSE") then {
	_radius = (_size select 0) max (_size select 1);
} else {
	_radius = ((_size select 0)*sqrt(2)) max ((_size select 1)*sqrt(2));
};

//Maybe adding a check if the building is in the trigger (bis_fnc_inTrigger)
private _buildings = nearestObjects [_pos, ["House", "Building"], _radius, true];
private _list = [];
{
	private _positions = (_x buildingPos -1);
	if(count(_positions)> 0) then {
		_list append _positions;
	};
} forEach _buildings;

_list;