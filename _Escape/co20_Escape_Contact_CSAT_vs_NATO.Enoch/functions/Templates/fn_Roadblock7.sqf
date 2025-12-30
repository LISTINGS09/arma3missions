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
	[_staticWeapon,[7.875,1.375,4.4]],
	[_parkedVehicle,[-9.62207,-1.37207,1.5]]
];

// Spawn Objects
{
	// [_type, _center, _offset, _rotation, _dir, _align]
	private _obj = [_x#0, _center, _x#1, _rotation, _x#2, _x#3] call a3e_fnc_createObject;
} forEach [
	["Land_CncWall4_F", [14.7212,-0.4729,0], 270],
	["Land_CncWall1_F", [14.4712,-3.4729,0], 300],
	["Land_CncWall1_F", [-15.0288,-6.0979,0], 90],
	["Land_PaperBox_closed_F", [7.09619,-0.4729,0], 195],
	["Land_CncBarrierMedium4_F", [-15.2788,-1.7229,0], 270],
	["Land_CncBarrier_F", [-16.4038,6.2771,0], 315],
	["Land_Garbage_square3_F", [8.09619,4.7771,0], 285],
	["Land_Garbage_square3_F", [8.97119,4.2771,0], 359],
	["Land_CncBarrier_F", [10.8462,9.1521,0], 15],
	["Land_CncBarrier_F", [-12.1538,9.1521,0], 345],
	["Land_Pallets_F", [-6.15381,4.4021,0], 195],
	["Land_Cargo_Patrol_V2_F", [8.97119,0.7771,0], 180, false],
	["Land_GarbageContainer_open_F", [8.59619,4.7771,0], 179],
	["Land_CncBarrier_stripes_F", [-6.90381,9.7771,0], 0],
	["Land_CncBarrier_stripes_F", [4.97119,9.1521,0], 345],
	["Land_CncBarrierMedium_F", [-7.27881,6.6521,0], 180],
	["Land_CncBarrierMedium_F", [-14.5288,4.0271,0], 300],
	["Land_CncBarrierMedium_F", [-13.4038,5.5271,0], 315],
	["Land_CncBarrierMedium_F", [-11.0288,6.6521,0], 180],
	["Land_CncBarrierMedium_F", [-9.15381,6.6521,0], 180],
	["Land_CncWall4_F", [8.22119,6.1521,0], 180],
	["Land_CncWall1_F", [13.4712,4.7771,0], 225],
	["Land_CncWall1_F", [-15.0288,2.5271,0], 105],
	["Land_CncWall1_F", [11.3462,6.0271,0], 195],
	["Land_CncWall1_F", [-5.90381,6.1521,0], 195],
	["Land_CncWall1_F", [-12.188,6.15088,0], 165],
	["Land_CncWall1_F", [14.2212,3.77588,0], 240],
	["Land_CncWall1_F", [14.5952,2.68604,0], 255],
	["Land_CncWall1_F", [5.09619,6.0271,0], 165],
	["Land_CncWall1_F", [12.4712,5.5271,0], 210],
	["Land_CncBarrier_stripes_F", [15.9712,6.4021,0], 45]
];