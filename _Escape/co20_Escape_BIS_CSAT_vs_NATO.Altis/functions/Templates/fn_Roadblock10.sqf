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
	[_staticWeapon,[6.72803,-0.734863,2.8],180],
	[_parkedVehicle,[-7.46191,2.521,1.5],360,180]
];

// Spawn Objects
{
	// [_type, _center, _offset, _rotation, _dir, _align]
	private _obj = [_x#0, _center, _x#1, _rotation, _x#2, _x#3] call a3e_fnc_createObject;
} forEach [
	["RoadBarrier_F", [5.74805,-7.125,0], 180],
	["RoadBarrier_F", [-5.65576,-6.81006,0], 0],
	["Land_CncBarrier_F", [5.51807,-5.26709,0], 0],
	["Land_CncBarrier_F", [10.4409,-4.4458,0], 140],
	["Land_CncBarrier_F", [-5.37305,-4.76123,0], 0],
	["Land_CncBarrier_F", [8.1582,-5.3042,0], 0],
	["Land_CncBarrier_F", [11.4551,-2.17822,0], 90],
	["Land_CncBarrier_F", [-8.01416,-4.72021,0], 0],
	["Land_CncBarrier_F", [-10.2959,-3.72021,0], 225],
	["Land_CncBarrier_F", [-11.1602,-1.43701,0], 270],
	["Land_BagBunker_Tower_F", [7.31982,0.950195,0], 0]
];