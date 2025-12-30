params["_className","_centerPos","_relativePos",["_rotateDir",0],["_relativeDir",0],["_relative",true]];

private _realPos = ([_centerPos, [(_centerPos select 0) + (_relativePos select 0), (_centerPos select 1) + (_relativePos select 1),(_relativePos select 2)], _rotateDir] call A3E_fnc_rotatePosition);
private _obj = createVehicle [_className, [0,0,0], [], 0, "NONE"];

_obj setDir (_relativeDir + _rotateDir);
_obj setPosATL _realPos;

if (_relative) then { _obj setVectorUp surfaceNormal position _obj };

_obj