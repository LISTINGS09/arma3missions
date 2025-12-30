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
	[_staticWeapon,[-10,4]],
	[_parkedVehicle,[10,-6,1.5]]
];

// Spawn Objects
{
	// [_type, _center, _offset, _rotation, _dir, _align]
	private _obj = [_x#0, _center, _x#1, _rotation, _x#2, _x#3] call a3e_fnc_createObject;
} forEach [
	["Land_PaperBox_open_full_F", [-11,0,0], 15],
	["RoadCone_F", [-4,-4,0], 0],
	["Land_BagFence_End_F", [14.25,-0.875,0], 75],
	["Land_BagFence_End_F", [6.125,-2.875,0], 120],
	["Land_BagFence_Round_F", [7,0,0], 135],
	["Land_BagFence_Short_F", [6.25,-1.875,0], 90],
	["RoadCone_F", [4,-4,0], 0],
	["Land_CncBarrier_F", [-13.6699,10.3679,0], 0],
	["Land_CncBarrier_F", [-8.66992,9.36792,0], 15],
	["Land_PaperBox_closed_F", [-12,2,0], 165],
	["Land_BagFence_Round_F", [-8,6,0], 210],
	["Land_BagFence_Round_F", [-10.125,6.875,0], 30],
	["Land_BagFence_Short_F", [-6.875,4.25,0], 75],
	["Land_BagFence_Short_F", [-11.75,7.75,0], 0],
	["RoadCone_F", [-4,4,0], 0],
	["Land_CncBarrier_F", [13,7,0], 0],
	["Land_CncBarrier_F", [8,7,0], 0],
	["Land_BagFence_Round_F", [13.5,2.125,0], 225],
	["Land_BagFence_Round_F", [9.375,1,0], 330],
	["Land_BagFence_Round_F", [11.25,2.5,0], 150],
	["Land_BagFence_Short_F", [14.125,0.25,0], 90],
	["RoadCone_F", [4,4,0], 0]
];