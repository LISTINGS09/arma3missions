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
	[_staticWeapon,[-11.875,1.87598]],
	[_parkedVehicle,[8.64014,-3.41895,1.5]]
];

// Spawn Objects
{
	// [_type, _center, _offset, _rotation, _dir, _align]
	private _obj = [_x#0, _center, _x#1, _rotation, _x#2, _x#3] call a3e_fnc_createObject;
} forEach [
	["Land_HBarrier_1_F", [-14.375,0.625,0], 225],
	["Land_HBarrier_1_F", [-9.5,0.625977,0], 330],
	["Land_Razorwire_F", [10,7.875,0], 0],
	["Land_Razorwire_F", [-11.9082,8.04004,0], 0],
	["Land_Razorwire_F", [13.25,3.125,0], 90],
	["Land_BagBunker_Small_F", [-11.875,1.87598,0], 180],
	["Land_CncBarrier_stripes_F", [-13.75,5.75,0], 0],
	["Land_CncBarrier_stripes_F", [-10.125,5.75,0], 0],
	["Land_CncBarrier_stripes_F", [10.25,5.75,0], 0],
	["Land_CncBarrier_stripes_F", [6.625,5.75,0], 0]
];