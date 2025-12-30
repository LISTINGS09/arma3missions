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
	[_staticWeapon,[8.10107,2.63306]],
	[_parkedVehicle,[-8.23291,0.221924,1.5]]
];

// Spawn Objects
{
	// [_type, _center, _offset, _rotation, _dir, _align]
	private _obj = [_x#0, _center, _x#1, _rotation, _x#2, _x#3] call a3e_fnc_createObject;
} forEach [
	["Land_GarbagePallet_F", [11.2939,0.701904,0], 195],
	["Land_Razorwire_F", [14.125,-1.375,0], 90],
	["Land_MetalBarrel_empty_F", [6.75,-4.5,0], 0],
	["Land_PaperBox_closed_F", [9.09326,-1.70996,0], 195],
	["CamoNet_BLUFOR_F", [9.875,-1.125,0], 90],
	["Land_BagFence_End_F", [5.875,2.125,0], 120],
	["Land_BagFence_Round_F", [8.99805,5.302,0], 210],
	["Land_BagFence_Round_F", [6.75,4.99902,0], 135],
	["Land_BagFence_Round_F", [7.125,-6.25,0], 30],
	["Land_BagFence_Round_F", [9.25,-7.125,0], 210],
	["Land_BagFence_Short_F", [6,-4.5,0], 255],
	["Land_BagFence_Short_F", [6,3.125,0], 90],
	["Land_BagFence_Short_F", [10.875,-8,0], 0],
	["RoadCone_F", [4.125,3.5,0], 135],
	["RoadCone_F", [-4.375,3.375,0], 90],
	["RoadCone_F", [-4.375,-4,0], 0],
	["RoadCone_F", [4.125,-3.875,0], 135]
];