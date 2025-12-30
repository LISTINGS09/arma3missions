// fn_Ammo Depot5.sqf - Script by NeoArmageddon.
// A huge shout out to NeoArmageddon for his advice & wisdom. 
// Thanks to Zec Building Compositions for helping make this :) 
// Relative positions exported thanks too Maca's M3Eden Editor Addon.
// modified by aussie :)
if(!isServer) exitWith {};
params ["_center",["_staticWeaponClasses",[]],["_parkedVehicleClasses",[]],["_parkedArmourClasses",[]]];

private _rotation = random 360;

[_center,50] call a3e_fnc_cleanupTerrain;

if (isNil "A3E_MotorPoolMarkerNumber") then { A3E_MotorPoolMarkerNumber = 0 } else { A3E_MotorPoolMarkerNumber = A3E_MotorPoolMarkerNumber + 1 };
private _instanceNo = A3E_MotorPoolMarkerNumber;

private _fnc_createObject = {
    params["_className","_centerPos","_relativePos","_rotateDir","_relativeDir",["_relative",false]];
    private _realPos = ([_centerPos, [(_centerPos select 0) + (_relativePos select 0), (_centerPos select 1) + (_relativePos select 1),(_relativePos select 2)], _rotateDir] call A3E_fnc_rotatePosition);
    private _obj = createVehicle [_className, [0,0,0], [], 0, "NONE"];
    _obj setDir (_relativeDir + _rotateDir);
    _obj setPosATL _realPos;
	if (_relative) then { _obj setVectorUp surfaceNormal position _obj };
    _obj
};

// Cars
{
	if (count _parkedVehicleClasses == 0 && random 1 >= _x#2) exitWith {};
	private _obj = [selectRandom _parkedVehicleClasses, _center, _x#0, _rotation, _x#1] call _fnc_createObject;
	_obj setFuel random 1;
	_obj setDamage random [0, 0.2, 0.5];
	_obj setVehicleAmmo random [0, 0.5, 1];
} forEach [
	[[-8.375,-1.125,1], 0, 1]
	,[[2.625,-0.625,1], 100, 0.7]
];

// Armour
{
	if (count _parkedArmourClasses == 0) exitWith {};
	private _obj = [selectRandom _parkedArmourClasses, _center, _x#0, _rotation, _x#1] call _fnc_createObject;	
	_obj setFuel random [0.05, 0.10, 0.15];
	_obj setDamage random [0.25, 0.5, 0.9];
	_obj setVehicleAmmo random [0, 0.5, 1];
} forEach [
	[[-3.875,8.375,1], 270]
];

// Statics
{
	if (count _staticWeaponClasses == 0) exitWith {};
	private _obj = [selectRandom _staticWeaponClasses, _center, _x#0, _rotation, _x#1] call _fnc_createObject;
	[_obj, A3E_VAR_Side_Opfor] spawn A3E_fnc_AddStaticGunner; 
} forEach [
	[[13.5,-8.375,4.5], 180]
];

//SPAWN IN THE BASE OBJECTS	
{
	_x params ["_type","_offset","_dir"];
	[_type, _center, _offset, _rotation, _dir] call _fnc_createObject;
} forEach [
	["Land_PaperBox_closed_F", [-15.339,-9.54688,0], 0],
	["Land_CncBarrierMedium_F", [-2.96399,-7.54688,0], 105],
	["Land_CncBarrierMedium_F", [8.53601,0.0786133,0], 270],
	["Land_CncBarrierMedium_F", [8.28601,-1.79688,0], 105],
	["Land_CncBarrierMedium_F", [-2.83899,1.70313,0], 255],
	["Land_Sign_WarningMilAreaSmall_F", [-18.339,3.45361,0], 90],
	["Land_WaterBarrel_F", [-13.839,-9.79639,0], 360],
	["Land_CncBarrierMedium4_F", [-13.464,-11.5464,0], 0],
	["Land_CncBarrierMedium4_F", [-2.71399,-2.9209,0], 90],
	["Land_CncBarrierMedium4_F", [-17.339,-0.421875,0], 270],
	["Land_CncBarrierMedium4_F", [1.53601,-11.5464,0], 0],
	["Land_CncBarrierMedium4_F", [8.16101,-6.7959,0], 90],
	["Land_CncBarrierMedium4_F", [-5.96399,-11.5464,0], 0],
	["Land_Pallet_MilBoxes_F", [-15.464,-7.92139,0], 0],
	["Land_BagFence_Long_F", [-16.464,-1.67139,0], 270],
	["Land_BagFence_Long_F", [-16.464,-7.17139,0], 270],
	["Land_BagFence_Long_F", [-15.089,-0.171387,0], 0],
	["Land_BagFence_Long_F", [-16.464,-4.42139,0], 270],
	["Land_BagFence_Long_F", [-14.964,-10.6714,0], 0],
	["Land_PaperBox_open_full_F", [-15.339,-4.42139,0], 0],
	["Land_PortableLight_double_F", [-15.4642,3.45361,0], 285],
	["Land_Mil_WiredFence_F", [1.16101,-11.0542,0], 0],
	["Land_Mil_WiredFence_F", [-17.205,-0.421387,0], 90],
	["Land_Mil_WiredFence_F", [-14.339,-11.0542,0], 0],
	["Land_Mil_WiredFence_F", [-6.58899,-11.0542,0], 0],
	["Land_CncBarrierMedium_F", [16.2861,-3.42139,0], 210],
	["Land_PaperBox_open_empty_F", [14.625,-9.125,0], 0],
	["Land_CncBarrierMedium4_F", [9.03613,-11.5464,0], 0],
	["Land_CncBarrierMedium4_F", [11.7861,-2.92139,0], 0],
	["Land_Pallet_MilBoxes_F", [12.125,-9.125,0], 0],
	["Land_BagFence_Long_F", [11.6611,-1.17139,0], 270],
	["Land_BarrelSand_F", [13.7861,-1.92139,0], 0],
	["Land_Mil_WiredFence_F", [8.91113,-11.0542,0], 0],
	["Land_Cargo_Patrol_V1_F", [12.125,-7.625,0], 0],
	["Land_CncBarrierMedium4_F", [-12.464,12.7036,0], 0],
	["Land_CncBarrierMedium4_F", [2.53601,12.7036,0], 0],
	["Land_CncBarrierMedium4_F", [-4.96399,12.7036,0], 0],
	["Land_Mil_WiredFence_F", [-6.58899,12.4443,0], 180],
	["Land_Mil_WiredFence_F", [1.16101,12.4443,0], 180],
	["Land_Sacks_heap_F", [7.66101,12.0786,0], 240],
	["Land_PortableLight_double_F", [8.78564,12.2036,0], 45],
	["Land_MetalBarrel_F", [13.9111,11.0786,0], 75],
	["Land_MetalBarrel_F", [14.8271,10.8579,0], 300],
	["Land_Mil_WiredFence_F", [8.91113,13.0786,0], 180]
];

// Boxes


// Set markers  
["A3E_MotorPoolMapMarker" + str _instanceNo,_center,"o_service"] call A3E_fnc_createLocationMarker;
private _marker = createMarkerLocal ["A3E_MotorPoolPatrolMarker" + str _instanceNo, _center];
_marker setMarkerShapeLocal "ELLIPSE";
_marker setMarkerAlphaLocal 0;
_marker setMarkerSizeLocal [50, 50];