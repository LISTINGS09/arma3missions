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
	[_staticWeapon,[7.41406,3.23389]],
	[_parkedVehicle,[-10.5562,1.49097,1.5]]
];

// Spawn Objects
{
	// [_type, _center, _offset, _rotation, _dir, _align]
	private _obj = [_x#0, _center, _x#1, _rotation, _x#2, _x#3] call a3e_fnc_createObject;
} forEach [
	["RoadCone_F", [-4.24902,-7.25,0], 135],
	["Land_Razorwire_F", [-6.62402,-4.125,0], 270],
	["Land_Razorwire_F", [-6.62402,4.5,0], 270],
	["Land_BagFence_Long_F", [5.87598,-4.375,0], 90],
	["Land_BagFence_Long_F", [5.87598,3.375,0], 270],
	["Land_BagFence_Long_F", [7.25098,4.75,0], 0],
	["Land_BagFence_Short_F", [5.00098,-3,0], 0],
	["Land_BagFence_Short_F", [4.25098,-2.125,0], 270],
	["Land_BagFence_Short_F", [5.12598,1.875,0], 180],
	["RoadCone_F", [-4.24902,-2.125,0], 135],
	["RoadCone_F", [-4.24902,7.625,0], 135],
	["RoadCone_F", [-4.37402,5,0], 135],
	["RoadCone_F", [-4.37402,2.625,0], 135],
	["RoadCone_F", [-4.24902,-4.75,0], 135]
];