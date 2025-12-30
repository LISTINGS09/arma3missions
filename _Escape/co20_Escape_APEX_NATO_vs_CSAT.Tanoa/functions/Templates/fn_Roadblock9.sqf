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
	[_staticWeapon,[7.16797,0.466797]],
	[_parkedVehicle,[-10.3892,-4.46777,1.5]]
];

// Spawn Objects
{
	// [_type, _center, _offset, _rotation, _dir, _align]
	private _obj = [_x#0, _center, _x#1, _rotation, _x#2, _x#3] call a3e_fnc_createObject;
} forEach [
	["Land_CncBarrier_F", [13.168,4.5918,0], 195],
	["Land_CncBarrier_F", [-11.957,5.7168,0], 165],
	["Land_BagBunker_Small_F", [7.16797,0.466797,0], 180],
	["Land_CncBarrier_stripes_F", [6.66797,6.34082,0], 0],
	["Land_CncBarrier_stripes_F", [-7.08203,5.96582,0], 0],
	["Land_CncBarrierMedium_F", [10.043,-0.408203,0], 180],
	["Land_CncBarrierMedium_F", [-14.207,0.716797,0], 270],
	["Land_CncBarrierMedium_F", [11.793,-0.90918,0], 30],
	["Land_BagFence_Long_F", [-8.15918,3.20117,0], 0],
	["Land_BagFence_Long_F", [-10.957,3.2168,0], 0],
	["Land_BagFence_Long_F", [-14.082,-1.65918,0], 90],
	["Land_BagFence_End_F", [-13.832,-3.2832,0], 45],
	["Land_BagFence_Round_F", [-13.457,2.5918,0], 135],
	["Land_CncBarrierMedium4_F", [-6.58203,-0.40918,0], 270]
];