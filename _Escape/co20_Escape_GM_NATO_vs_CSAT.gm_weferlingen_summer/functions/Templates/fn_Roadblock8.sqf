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
	[_staticWeapon,[-9.12402,0.750977]],
	[_parkedVehicle,[10.5698,-1.84424,1.5]]
];

// Spawn Objects
{
	// [_type, _center, _offset, _rotation, _dir, _align]
	private _obj = [_x#0, _center, _x#1, _rotation, _x#2, _x#3] call a3e_fnc_createObject;
} forEach [
	["RoadBarrier_F", [9.75,9.11279,0], 180],
	["RoadBarrier_F", [-8.25,8.98779,0], 180],
	["Land_CncBarrier_F", [-9.49902,6.125,0], 180],
	["Land_CncBarrier_F", [15.501,2.125,0], 270],
	["Land_CncBarrier_F", [-15.499,0.125,0], 90],
	["Land_CncBarrier_F", [-12.499,5.12598,0], 150],
	["Land_CncBarrier_F", [11.626,6.125,0], 0],
	["Land_CncBarrier_F", [-14.499,3.125,0], 120],
	["Land_CncBarrier_F", [14.501,5.12598,0], 210],
	["Land_BagBunker_Small_F", [-9.12402,0.750977,0], 180],
	["Land_CncBarrier_stripes_F", [8.50098,6.125,0], 0],
	["Land_CncBarrier_stripes_F", [-15.499,-2.875,0], 90],
	["Land_CncBarrier_stripes_F", [15.501,-1.375,0], 90],
	["Land_CncBarrier_stripes_F", [-6.49902,6.125,0], 0],
	["Land_BagFence_Long_F", [-7.24902,-1.62012,0], 90],
	["Land_BagFence_Round_F", [-12.125,-2,0], 135],
	["Land_BagFence_Short_F", [-10.999,-0.373047,0], 270],
	["RoadCone_F", [5.75098,-9,0], 270],
	["RoadCone_F", [5.75098,-1.25,0], 270],
	["RoadCone_F", [5.75098,11.125,0], 270],
	["RoadCone_F", [-4.24902,-1.5,0], 270],
	["RoadCone_F", [5.75098,2.75,0], 270],
	["RoadCone_F", [-4.24902,-5.25,0], 270],
	["RoadCone_F", [-4.24902,6.75,0], 270],
	["RoadCone_F", [5.75098,7,0], 270],
	["RoadCone_F", [-4.24902,-9.25,0], 270],
	["RoadCone_F", [5.75098,-5,0], 270],
	["RoadCone_F", [-4.24902,2.5,0], 270],
	["RoadCone_F", [-4.24902,10.875,0], 270],
	["RoadBarrier_small_F", [13.501,8.75,0], 15],
	["RoadBarrier_small_F", [-11.499,8.75,0], 345]
];