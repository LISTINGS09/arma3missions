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
	[[11.875,11.25,1], 255, 1]
	,[[-14.375,21.875,1], 105, 0.7]
	,[[2.125,17.5,1], 180, 0.5]
];

// Armour
{
	if (count _parkedArmourClasses == 0) exitWith {};
	private _obj = [selectRandom _parkedArmourClasses, _center, _x#0, _rotation, _x#1] call _fnc_createObject;	
	_obj setFuel random [0.05, 0.10, 0.15];
	_obj setDamage random [0.25, 0.5, 0.9];
	_obj setVehicleAmmo random [0, 0.5, 1];
} forEach [
	[[12.875,-13,1], 0]
];

// Statics
{
	if (count _staticWeaponClasses == 0) exitWith {};
	private _obj = [selectRandom _staticWeaponClasses, _center, _x#0, _rotation, _x#1] call _fnc_createObject;
	[_obj, A3E_VAR_Side_Opfor] spawn A3E_fnc_AddStaticGunner; 
} forEach [
	[[-19.5,-0.25,0.2], 270]
	,[[-8,-22.875,4.4], 270]
];

//SPAWN IN THE BASE OBJECTS	
{
	_x params ["_type","_offset","_dir"];
	[_type, _center, _offset, _rotation, _dir] call _fnc_createObject;
} forEach [
	["Land_BagFence_Long_F", [4.87549,-14.3745,0], 270],
	["Land_BagFence_Long_F", [4.87549,-17.2495,0], 90],
	["Land_Cargo40_light_green_F", [-9.64453,-10.7017,0], 90],
	["Land_Cargo20_yellow_F", [-6.89453,-10.3267,0], 90],
	["Land_Cargo_Patrol_V1_F", [-7.20215,-21.1987,0], 90],
	["Land_Mil_WallBig_Corner_F", [-11.0186,-25.8262,0], 0],
	["Land_Mil_WallBig_4m_F", [3.62549,-26.124,0], 0],
	["Land_Mil_WallBig_4m_F", [-0.374512,-26.124,0], 0],
	["Land_Mil_WallBig_4m_F", [-11.3267,-15.1987,0], 90],
	["Land_Mil_WallBig_4m_F", [-4.26953,-26.0767,0], 0],
	["Land_Mil_WallBig_4m_F", [-11.3267,-11.1987,0], 90],
	["Land_Mil_WallBig_4m_F", [7.62549,-26.124,0], 0],
	["Land_Mil_WallBig_4m_F", [-8.26953,-26.0767,0], 0],
	["Land_Mil_WallBig_4m_F", [-11.2686,-19.0762,0], 90],
	["Land_Mil_WallBig_4m_F", [-11.2686,-23.0762,0], 90],
	["Land_PaperBox_closed_F", [18.0659,-20.8213,0], 15],
	["Land_PaperBox_closed_F", [19.5,-21.875,0], 210],
	["Land_LampHalogen_F", [21.0005,-24.625,0], 0],
	["Land_Mil_WallBig_Corner_F", [22.3755,-25.874,0], 270],
	["Land_Mil_WallBig_4m_F", [22.6255,-19.1245,0], 270],
	["Land_Mil_WallBig_4m_F", [22.6255,-23.1245,0], 270],
	["Land_Mil_WallBig_4m_F", [15.6255,-26.124,0], 0],
	["Land_Mil_WallBig_4m_F", [11.6255,-26.124,0], 0],
	["Land_Mil_WallBig_4m_F", [22.625,-11.125,0], 270],
	["Land_Mil_WallBig_4m_F", [19.6255,-26.124,0], 0],
	["Land_Mil_WallBig_4m_F", [22.625,-15.1245,0], 270],
	["Land_CargoBox_V1_F", [17.75,-23.125,0], 345],
	["Land_Mil_WallBig_4m_F", [-23.499,12.5005,0], 90],
	["Land_Mil_WallBig_4m_F", [-23.499,16.5005,0], 90],
	["Land_Mil_WallBig_4m_F", [-23.499,20.5,0], 90],
	["Land_Cargo10_cyan_F", [8.25,19.375,0], 300],
	["Land_BagFence_Long_F", [-21.875,-2.25,0], 90],
	["Land_BagFence_Long_F", [-17.5,1.75,0], 0],
	["Land_BagFence_Long_F", [-20.375,1.75,0], 180],
	["Land_BagFence_Long_F", [-21.75,0.375,0], 270],
	["Land_Bricks_V1_F", [-13.627,-0.818359,0], 240],
	["Land_Bricks_V1_F", [-14.627,0.806641,0], 88],
	["Land_LampHalogen_F", [-10.4326,-1.24707,0], 45],
	["Land_ToiletBox_F", [-17.125,-3.625,0], 90],
	["Land_ToiletBox_F", [-17.125,-5.25,0], 90],
	["Land_GarbageBags_F", [-16.25,-1.125,0], 180],
	["Land_Cargo_Patrol_V1_F", [-19.125,13.25,0], 90],
	["Land_Mil_WallBig_Corner_F", [-11.1826,-0.37207,0], 90],
	["Land_Mil_WallBig_Corner_F", [-23.249,9.75,0], 0],
	["Land_Mil_WallBig_Corner_F", [-5.68311,-0.24707,0], 180],
	["Land_Mil_WallBig_Corner_F", [-9.74951,9.87549,0], 270],
	["Land_Mil_WallBig_4m_F", [-9.5,12.625,0], 270],
	["Land_Mil_WallBig_4m_F", [-16.4995,9.5,0], 0],
	["Land_Mil_WallBig_4m_F", [-20.4995,9.5,0], 0],
	["Land_Mil_WallBig_4m_F", [-11.4321,-3.12207,0], 90],
	["Land_Mil_WallBig_4m_F", [-5.43311,-2.99707,0], 270],
	["Land_Mil_WallBig_4m_F", [-11.3267,-7.19873,0], 90],
	["Land_Mil_WallBig_4m_F", [-8.43262,-0.12207,0], 180],
	["Land_Mil_WallBig_4m_F", [-12.5,9.5,0], 0],
	["Land_Cargo10_grey_F", [17.75,-1.625,0], 345],
	["Land_Cargo20_light_green_F", [15,2,0], 0],
	["Land_Cargo20_light_blue_F", [11.875,19.875,0], 270],
	["Land_Mil_WallBig_4m_F", [22.625,-7.125,0], 270],
	["Land_Mil_WallBig_4m_F", [22.625,0.875,0], 270],
	["Land_Mil_WallBig_4m_F", [22.625,-3.125,0], 270],
	["Land_Mil_WallBig_4m_F", [22.625,4.875,0], 270],
	["Land_Mil_WallBig_4m_F", [22.625,12.625,0], 270],
	["Land_Mil_WallBig_4m_F", [22.625,8.75,0], 270],
	["Land_Mil_WallBig_4m_F", [22.625,16.5,0], 270],
	["Land_Mil_WallBig_4m_F", [22.625,20.5,0], 270],
	["Land_Shed_Big_F", [12.8755,-8.03076,0], 180],
	["Land_Mil_WallBig_4m_F", [-23.499,24.5,0], 90],
	["Land_PaperBox_closed_F", [-2.25,24.125,0], 180],
	["Land_PaperBox_closed_F", [-3.90771,24.772,0], 15],
	["Land_LampHalogen_F", [-22.3745,26.5,0], 225],
	["Land_Mil_WallBig_Corner_F", [-23.2495,27.2495,0], 90],
	["Land_Mil_WallBig_4m_F", [3.50098,27.4995,0], 180],
	["Land_Mil_WallBig_4m_F", [-0.499023,27.4995,0], 180],
	["Land_Mil_WallBig_4m_F", [-12.499,27.4995,0], 180],
	["Land_Mil_WallBig_4m_F", [-4.49902,27.4995,0], 180],
	["Land_Mil_WallBig_4m_F", [-8.49902,27.4995,0], 180],
	["Land_Mil_WallBig_4m_F", [-16.499,27.4995,0], 180],
	["Land_Mil_WallBig_4m_F", [-20.499,27.4995,0], 180],
	["Land_Mil_WallBig_4m_F", [7.50098,27.4995,0], 180],
	["Land_LampHalogen_F", [21.501,26.25,0], 270],
	["Land_Mil_WallBig_Corner_F", [22.25,27.5,0], 180],
	["Land_Mil_WallBig_4m_F", [22.625,24.5,0], 270],
	["Land_Mil_WallBig_4m_F", [15.501,27.4995,0], 180],
	["Land_Mil_WallBig_4m_F", [19.501,27.4995,0], 180],
	["Land_Mil_WallBig_4m_F", [11.501,27.4995,0], 180],
	["Land_Shed_Small_F", [10,22.375,1.25], 90]
];

// Boxes


// Set markers  
["A3E_MotorPoolMapMarker" + str _instanceNo,_center,"o_service"] call A3E_fnc_createLocationMarker;
private _marker = createMarkerLocal ["A3E_MotorPoolPatrolMarker" + str _instanceNo, _center];
_marker setMarkerShapeLocal "ELLIPSE";
_marker setMarkerAlphaLocal 0;
_marker setMarkerSizeLocal [50, 50];