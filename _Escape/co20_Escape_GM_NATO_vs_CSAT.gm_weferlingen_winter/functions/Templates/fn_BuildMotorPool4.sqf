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
	[[-9.875,-9.75,1], 75]
	,[[-6.875,9.25,1], 150, 0.7]
	,[[16.0918,15.1245,1], 180, 0.5]
];
	
// Armour
{
	if (count _parkedArmourClasses == 0) exitWith {};
	private _obj = [selectRandom _parkedArmourClasses, _center, _x#0, _rotation, _x#1] call _fnc_createObject;	
	_obj setFuel random [0.05, 0.10, 0.15];
	_obj setDamage random [0.25, 0.5, 0.9];
	_obj setVehicleAmmo random [0, 0.5, 1];
} forEach [
	[[10.125,0.25,1], 180]
];

// Statics
{
	if (count _staticWeaponClasses == 0) exitWith {};
	private _obj = [selectRandom _staticWeaponClasses, _center, _x#0, _rotation, _x#1] call _fnc_createObject;
	[_obj, A3E_VAR_Side_Opfor] spawn A3E_fnc_AddStaticGunner; 
} forEach [
	[[17.125,-23.75,0.2], 180]
	,[[2.125,-23.75,0.2], 180]
];

//SPAWN IN THE BASE OBJECTS	
{
	_x params ["_type","_offset","_dir"];
	[_type, _center, _offset, _rotation, _dir] call _fnc_createObject;
} forEach [
	["Land_Wall_IndCnc_4_F", [-16.8589,-19.1855,0], 180],
	["Land_LampHalogen_F", [-19.0332,-18.5054,0], 135],
	["Land_BagFence_Long_F", [4.05322,-22.5884,0], 90],
	["Land_BagFence_Long_F", [0.553223,-22.3384,0], 270],
	["Land_BarGate_F", [9.8418,-21.0054,0], 0],
	["Land_BagFence_Short_F", [15.8418,-23.2554,0], 255],
	["Land_BagFence_Round_F", [16.6782,-25.2139,0], 45],
	["Land_BagFence_Round_F", [1.17822,-24.8389,0], 45],
	["Land_BagFence_Round_F", [3.34229,-24.8804,0], 315],
	["Land_Wall_IndCnc_4_F", [-4.90771,-19.1304,0], 180],
	["Land_Wall_IndCnc_4_F", [1.09229,-19.1304,0], 180],
	["Land_Wall_IndCnc_4_F", [-10.9077,-19.1304,0], 180],
	["Land_Tank_rust_F", [-12.9409,-17.5205,0], 180],
	["Land_BagFence_Long_F", [19.5532,-22.9634,0], 90],
	["Land_BagFence_Round_F", [18.8423,-25.2554,0], 315],
	["Land_Wall_IndCnc_4_F", [18.8418,-19.1309,0], 0],
	["Land_LampHalogen_F", [20.9668,-18.2559,0], 45],
	["Land_Cargo40_light_green_F", [-18.4077,8.36963,0], 90],
	["Land_Wall_IndCnc_Pole_F", [-20.0332,-13.2554,0], 270],
	["Land_Wall_IndCnc_4_D_F", [-19.6094,-10.186,0], 90],
	["Land_Wall_IndCnc_4_F", [-20.0332,13.7446,0], 90],
	["Land_Wall_IndCnc_4_F", [-20.0332,1.74463,0], 90],
	["Land_Wall_IndCnc_4_F", [-20.0332,7.74463,0], 90],
	["Land_Wall_IndCnc_4_F", [-19.9839,-16.311,0], 270],
	["Land_Wall_IndCnc_4_F", [-20.0332,-4.25537,0], 90],
	["Land_Pallets_F", [-14.8159,-11.8955,0], 60],
	["Land_Sack_F", [-16.2729,-11.8716,0], 120],
	["Land_Cargo_House_V1_F", [-14.7832,-3.12988,0], 270],
	["Land_Pallets_stack_F", [-15.1382,13.3135,0], 76],
	["Land_Pallets_stack_F", [-15.5239,-13.8921,0], 30],
	["Land_GarbageBags_F", [-13.6909,-15.3955,0], 270],
	["Land_Cargo_Patrol_V1_F", [-3.875,-15.75,0], 0],
	["Land_CratesPlastic_F", [-13.1079,15.0737,0], 90],
	["Land_Pallets_stack_F", [-11.0659,-15.2705,0], 330],
	["Land_Pallets_stack_F", [7.46729,13.8696,0], 345],
	["Land_Cargo20_red_F", [18.5923,-10.7554,0], 0],
	["Land_Wall_IndCnc_4_D_F", [21.5435,13.6753,0], 270],
	["Land_Wall_IndCnc_4_F", [21.9673,7.74414,0], 270],
	["Land_Wall_IndCnc_4_F", [21.9673,-16.2559,0], 270],
	["Land_Wall_IndCnc_4_F", [21.9673,-10.2559,0], 270],
	["Land_Wall_IndCnc_4_F", [21.9673,1.74414,0], 270],
	["Land_Wall_IndCnc_4_F", [21.9673,-4.25586,0], 270],
	["Land_CratesShabby_F", [20.9473,-2.88037,0], 0],
	["Land_Cargo20_military_green_F", [20.4673,3.36963,0], 270],
	["Land_Cargo20_grey_F", [18.5923,-13.5054,0], 0],
	["Land_CratesPlastic_F", [21.168,-1.99756,0], 180],
	["Land_Pallets_stack_F", [20.5923,-4.13037,0], 90],
	["Land_Pallets_stack_F", [19.8477,-2.53467,0], 90],
	["Land_GarbageContainer_open_F", [-16.4775,19.7192,0], 26],
	["Land_GarbageContainer_closed_F", [-14.1616,17.3052,0], 264],
	["Land_Wall_IndCnc_4_F", [-16.9077,22.6196,0], 180],
	["Land_Wall_IndCnc_4_F", [-20.0332,19.7446,0], 90],
	["Land_LampHalogen_F", [-19.1577,21.6196,0], 225],
	["Land_Tyres_F", [-15.1255,19.375,0], 75],
	["Land_Garbage_square5_F", [-14.3755,19.2505,0], 180],
	["Land_Tyre_F", [-14.25,17.374,0], 180],
	["Land_GarbageWashingMachine_F", [-14.875,15.25,0], 345],
	["Land_Cargo10_cyan_F", [-11.875,20.25,0], 180],
	["Land_Wall_IndCnc_4_F", [6.8418,22.6191,0], 0],
	["Land_Wall_IndCnc_4_F", [-10.9077,22.6196,0], 180],
	["Land_Wall_IndCnc_4_F", [-4.90771,22.6196,0], 180],
	["Land_Wall_IndCnc_4_F", [12.8418,22.6191,0], 0],
	["Land_Wall_IndCnc_4_F", [0.841797,22.6191,0], 0],
	["Land_CinderBlocks_F", [6.73828,15.7456,0], 270],
	["Land_CinderBlocks_F", [8.23828,15.8706,0], 285],
	["Land_TBox_F", [-6.94092,20.604,0], 0],
	["Land_CratesWooden_F", [7.84229,20.7446,0], 270],
	["Land_CratesWooden_F", [5.82275,21.2759,0], 180],
	["Land_Shed_Small_F", [8.125,18.25,1], 90],
	["Land_IronPipes_F", [10.293,16.064,0], 105],
	["Land_Sacks_goods_F", [6.2168,19.7446,0], 180],
	["Land_Wall_IndCnc_Pole_F", [21.9673,16.7446,0], 90],
	["Land_Wall_IndCnc_4_F", [18.793,22.6748,0], 0],
	["Land_Wall_IndCnc_4_F", [21.918,19.8003,0], 90]
];

// Set markers  
["A3E_MotorPoolMapMarker" + str _instanceNo,_center,"o_service"] call A3E_fnc_createLocationMarker;
private _marker = createMarkerLocal ["A3E_MotorPoolPatrolMarker" + str _instanceNo, _center];
_marker setMarkerShapeLocal "ELLIPSE";
_marker setMarkerAlphaLocal 0;
_marker setMarkerSizeLocal [50, 50];