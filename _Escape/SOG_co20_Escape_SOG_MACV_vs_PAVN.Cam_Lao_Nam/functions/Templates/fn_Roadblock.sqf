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
	[_staticWeapon,[8.07422,-1.36108]],
	[_parkedVehicle,[-8.36572,-3.68115,1.5]]
];

// Spawn Objects
{
	// [_type, _center, _offset, _rotation, _dir, _align]
	private _obj = [_x#0, _center, _x#1, _rotation, _x#2, _x#3] call a3e_fnc_createObject;
} forEach [
	["RoadBarrier_F", [7.76709,5.13794,0], 180],
	["RoadBarrier_F", [-8.10791,4.76294,0], 180],
	["Land_CncBarrier_F", [-11.4829,1.77393,0], 135],
	["Land_CncBarrier_F", [9.01709,2.77393,0], 0],
	["Land_CncBarrier_F", [-8.98291,2.77393,0], 0],
	["Land_CncBarrier_F", [-12.6079,-1.10107,0], 90],
	["Land_CncBarrier_stripes_F", [-6.10791,2.77393,0], 0],
	["Land_CncBarrier_stripes_F", [6.14209,2.77393,0], 0],
	["Land_BagFence_Long_F", [10.7153,-2.33521,0], 90],
	["Land_BagFence_Long_F", [7.76318,0.898926,0], 0],
	["Land_BagFence_End_F", [10.7153,-3.96021,0], 75],
	["Land_BagFence_End_F", [5.71533,-1.96021,0], 75],
	["Land_BagFence_Round_F", [10.0903,0.166016,0], 225],
	["Land_BagFence_Short_F", [5.64209,-0.852051,0], 90],
	["Land_BagFence_Corner_F", [5.96533,0.414795,0], 270],
	["RoadBarrier_small_F", [11.5171,4.77393,0], 15],
	["RoadBarrier_small_F", [-11.3579,4.52393,0], 345]
];