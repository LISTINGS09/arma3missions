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
	[[11, 7,1], 180, 1]
	,[[-20, -1,1], 100, 0.7]
	,[[-15, 12.5,1], 144, 0.5]
];

// Armour
{
	if (count _parkedArmourClasses == 0) exitWith {};
	private _obj = [selectRandom _parkedArmourClasses, _center, _x#0, _rotation, _x#1] call _fnc_createObject;	
	_obj setFuel random [0.05, 0.10, 0.15];
	_obj setDamage random [0.25, 0.5, 0.9];
	_obj setVehicleAmmo random [0, 0.5, 1];
} forEach [
	[[6, 7,1], 180]
];

// Statics
{
	if (count _staticWeaponClasses == 0) exitWith {};
	private _obj = [selectRandom _staticWeaponClasses, _center, _x#0, _rotation, _x#1] call _fnc_createObject;
	[_obj, A3E_VAR_Side_Opfor] spawn A3E_fnc_AddStaticGunner; 
} forEach [
	[[-0.35, -2.7,0.2], 170]
];

//SPAWN IN THE BASE OBJECTS	
{
	_x params ["_type","_offset","_dir"];
	[_type, _center, _offset, _rotation, _dir] call _fnc_createObject;
} forEach [
	["Land_Razorwire_F", [-17.528, 26.345], 0],
	["Land_Razorwire_F", [-25.715, 26.343], 0],
	["Land_Razorwire_F", [-1.18, 26.435], 0],
	["Land_Razorwire_F", [-9.368, 26.433], 0],
	["Land_Razorwire_F", [15.175, 26.435], 0],
	["Land_Razorwire_F", [6.988, 26.433], 0],
	["Land_Razorwire_F", [23.443, 26.347], 0],
	["Land_Razorwire_F", [-25.534, -26.362], 0],
	["Land_Razorwire_F", [-9.592, -26.436], 0],
	["Land_Razorwire_F", [-17.854, -26.401], 0],
	["Land_Razorwire_F", [23.463, -26.397], 0],
	["Land_Razorwire_F", [15.275, -26.399], 0],
	["Land_Razorwire_F", [-28.799, -21.217], 90],
	["Land_Razorwire_F", [-28.801, -15.008], 90],
	["Land_Razorwire_F", [-28.77, -8.764], 90],
	["Land_Razorwire_F", [-28.696, -2.412], 90],
	["Land_Razorwire_F", [-28.84, 17.968], 90],
	["Land_Razorwire_F", [-28.842, 24.849], 90],
	["Land_Razorwire_F", [-28.795, 11.505], 90],
	["Land_Razorwire_F", [-28.731, 4.582], 90],
	["Land_Razorwire_F", [28.789, -20.491], 90],
	["Land_Razorwire_F", [28.902, -7.952], 90],
	["Land_Razorwire_F", [28.847, -1.784], 90],
	["Land_Razorwire_F", [28.886, 4.57], 90],
	["Land_Razorwire_F", [28.81, 17.295], 90],
	["Land_Razorwire_F", [28.884, 10.955], 90],
	["Land_Razorwire_F", [28.718, 23.351], 90],
	["Land_Razorwire_F", [28.884, -14.264], 90],
	["Land_HBarrierBig_F", [26.957, -10.414], 90],
	["Land_HBarrierBig_F", [26.957, -1.918], 90],
	["Land_HBarrierBig_F", [26.968, 6.562], 90],
	["Land_HBarrierBig_F", [26.963, 15.039], 90],
	["Land_HBarrierBig_F", [26.957, -18.912], 90],
	["Land_HBarrierBig_F", [-27.174, -19.079], 90],
	["Land_HBarrierBig_F", [-27.174, -10.58], 90],
	["Land_HBarrierBig_F", [-27.174, -2.084], 90],
	["Land_HBarrierBig_F", [-27.162, 6.396], 90],
	["Land_HBarrierBig_F", [-27.168, 14.873], 90],
	["Land_HBarrierBig_F", [-17.022, 24.435], 180],
	["Land_HBarrierBig_F", [-8.58, 24.423], 180],
	["Land_HBarrierBig_F", [0, 24.425], 180],
	["Land_HBarrierBig_F", [8.437, 24.42], 180],
	["Land_HBarrierBig_F", [16.925, 24.423], 180],
	["Land_HBarrierBig_F", [-7.258, -24.495], 180],
	["Land_HBarrierBig_F", [-15.707, -24.495], 180],
	["Land_HBarrierBig_F", [-24.209, -24.487], 180],
	["Land_HBarrierBig_F", [15.47, -24.389], 180],
	["Land_HBarrierBig_F", [24.011, -24.387], 180],
	["Land_HBarrierBig_F", [-2.018, -21.584], 90],
	["Land_HBarrierBig_F", [10.238, -21.471], 90],
	["Land_Sign_WarningMilitaryVehicles_F", [-1.873, -26.09], 0],
	["Land_Sign_WarningMilitaryVehicles_F", [9.957, -26.012], 0],
	["Land_BagFence_Round_F", [0.90, -3.4], 320],
	["Land_BagFence_Round_F", [-1.50, -3.4], 40],
	["Land_HBarrierTower_F", [-24.561, 21.048], 180],
	["Land_HBarrierTower_F", [24.412, 20.998], 180],
	["Land_Cargo_Patrol_V1_F", [22.013, -19.625], 0],
	["Land_Cargo_House_V1_F", [15.39, -19.588], 180],
	["Land_Cargo40_military_green_F", [24.183, -8.204], 90],
	["Land_PaperBox_closed_F", [23.929, -22.702], 355],
	["Land_PaperBox_closed_F", [22.146, -22.661], 95],
	["Land_LampStreet_F", [10.281, -16.768], 0],
	["Land_PaperBox_closed_F", [24.201, -9.483, 0.2], 255],
	["Land_PaperBox_closed_F", [24.045, -7.815, 0.2], 175],
	["Land_PaperBox_closed_F", [21.681, -7.155, 0.2], 355],
	["Land_PaperBox_closed_F", [24.283, -13.09, 0.2], 355],
	["Land_PaperBox_closed_F", [24.201, -11.42, 0.2], 100],
	["Land_Cargo_HQ_V1_F", [-16.176, -13.577], 90],
	["Land_Cargo10_military_green_F", [-4.764, -21.475], 90],
	["Land_PowerGenerator_F", [-21.912, -7.346], 105],
	["Land_Cargo_House_V1_F", [-8.496, 17.75], 0],
	["Land_Cargo_House_V1_F", [-21.231, 6.447], 270],
	["Land_FieldToilet_F", [-18.844, 22.31], 0],
	["Land_FieldToilet_F", [-20.233, 22.31], 0],
	["Land_WaterTank_F", [-24.735, 12.254], 90],
	["Land_LampStreet_F", [-1.733, 8.341], 270],
	["Land_PowerGenerator_F", [-15.227, 22.203], 270],
	["Land_Sink_F", [-23.092, 12.867], 0],
	["Land_TentHangar_V1_F", [9.597, 8.789], 0],
	["Land_Workbench_01_F", [0.4, 5.476], 270],
	["Land_Portable_generator_F", [9.386, 17.716], 222],
	["Land_PowerGenerator_F", [18.082, 16.429], 0],
	["Land_Metal_rack_F", [0.4, 8.4], 270],
	["Land_ScrapHeap_1_F", [16.65, 10.806], 215],
	["Land_ScrapHeap_1_F",  [16.531, 6.271], 340],
	["Land_PaperBox_open_full_F", [0.5, 1.132], 350],
	["Oil_Spill_F", [6.025, 9.638], 180],
	["Oil_Spill_F", [10.916, 9.074], 0],
	["Land_EngineCrane_01_F", [10.775, 14.207], 80],
	["Land_Pallets_stack_F", [13.775, 14.207], 45],
	["Land_PortableLight_double_F", [9.132, 16.435], 60],
	["Land_PortableLight_double_F", [0, 15.244], 300],
	["Land_WeldingTrolley_01_F", [2.498, 17.0], 65],
	["Land_ToolTrolley_01_F", [0.5, 3.009], 65],
	["Land_Workbench_01_F", [0.35, 10.517], 270],
	["Land_MetalBarrel_F", [18.699, 2.134], 70],
	["Land_MetalBarrel_F", [18.121, 1.785], 0],
	["Land_MetalBarrel_F", [18.74, 1.474], 180],
	["Land_MetalBarrel_F", [0, 17.3], 270],
	["Land_Wrench_F", [1.021, 14.32], 60],
	["Land_ExtensionCord_F", [0, 7.254,0], 0],
	["Land_ExtensionCord_F", [1.463, 16.41,0], 0],
	["Land_ExtensionCord_F", [10.302, 16.72], 0],
	["Land_PalletTrolley_01_khaki_F", [16.189, 0,0], 240],
	["Land_Grinder_F", [0.375, 4.89, 1.1], 310],
	["Land_DrillAku_F", [0, 9.505, 1.1], 310],
	["Land_CampingTable_F", [-14.528, -11.741, 3.1], 110],
	["Land_Camping_Light_F", [-14.536, -11.582, 4], 0],
	["Land_Camping_Light_F", [0, 10.611, 1], 0],
	["Land_CampingChair_V2_F", [-15.51, -11.004, 3.1], 305],
	["Land_CampingChair_V2_F", [-15.432, -12.284, 3.1], 225],
	["Flag_CSAT_F", [-2.35, -17.1], 270]
];

// Boxes


// Set markers  
["A3E_MotorPoolMapMarker" + str _instanceNo,_center,"o_service"] call A3E_fnc_createLocationMarker;
private _marker = createMarkerLocal ["A3E_MotorPoolPatrolMarker" + str _instanceNo, _center];
_marker setMarkerShapeLocal "ELLIPSE";
_marker setMarkerAlphaLocal 0;
_marker setMarkerSizeLocal [50, 50];