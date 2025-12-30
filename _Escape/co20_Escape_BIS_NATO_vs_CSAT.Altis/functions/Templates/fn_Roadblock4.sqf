// Object composition created and exported with Map Builder
// See www.map-builder.info - Map Builder by NeoArmageddon
// Call this script by [Position,Rotation] execVM "filename.sqf"
if(!isServer) exitWith {};
params ["_center", ["_rotation",0], ["_staticWeapon",objNull], ["_parkedVehicle",objNull]];
[_center,25] call a3e_fnc_cleanupTerrain;

// Spawn Vehicles
{
	_x params ["_veh","_relativePos",["_relativeDir",0]];	
	if (!isNull _veh && count _relativePos > 0) then {
		private _finalPos = [_center, [(_center select 0) + (_relativePos select 0), (_center select 1) + (_relativePos select 1),(_relativePos select 2)], _rotation] call A3E_fnc_rotatePosition;
		[_finalPos,5] call a3e_fnc_cleanupTerrain;
		_veh setDir (_relativeDir + _rotation);
		_veh setPosATL _finalPos;
	};
} forEach [
	[_staticWeapon,[7,2]],
	[_parkedVehicle,[-9,-3,1.5]]
];

// Spawn Objects
{
	// [_type, _center, _offset, _rotation, _dir, _align]
	private _obj = [_x#0, _center, _x#1, _rotation, _x#2, _x#3] call a3e_fnc_createObject;
} forEach [
	["RoadBarrier_F", [-8,9,0], 0],
	["Land_BagFence_Long_F", [-11.625,1,0], 90],
	["Land_BagFence_Round_F", [-7.125,3.25,0], 225],
	["Land_BagFence_Round_F", [-10.875,3.375,0], 135],
	["Land_BagFence_Short_F", [-9,4,0], 180],
	["RoadCone_F", [-4,6,0], 0],
	["RoadCone_F", [-4,-4,0], 0],
	["RoadBarrier_F", [7,7,0], 0],
	["Land_WoodenBox_F", [9.51221,0.751953,0], 285],
	["Land_BagFence_Round_F", [8.125,0.875,0], 315],
	["Land_BagFence_Round_F", [6,3,0], 135],
	["Land_BagFence_Round_F", [6,0.875,0], 45],
	["Land_BagFence_Round_F", [8.125,3,0], 225],
	["RoadCone_F", [4,6,0], 0],
	["RoadCone_F", [4,-4,0], 0]
];



