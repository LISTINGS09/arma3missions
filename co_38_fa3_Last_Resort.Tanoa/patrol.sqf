if (!isServer) exitWith {};

params ["_group",["_distance",100]];

_position = position leader _group;

for "_i" from 1 to 5 do {
	_wp = _group addWaypoint [[_position,_distance,random 360] call BIS_fnc_relPos,0]; // random placement doesn't work for reasons...
	_wp setWaypointBehaviour "SAFE";
	_wp setWaypointTimeout [0,15,30];
	_position = waypointPosition _wp;
};
_wp = _group addWaypoint [position leader _group,0];
_wp setWaypointType "CYCLE";
_wp setWaypointTimeout [0,15,30];