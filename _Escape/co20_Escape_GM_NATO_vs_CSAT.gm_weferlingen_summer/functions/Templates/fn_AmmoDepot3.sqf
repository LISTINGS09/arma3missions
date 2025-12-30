// fn_Ammo Depot5.sqf - Script by NeoArmageddon.
// A huge shout out to NeoArmageddon for his advice & wisdom. 
// Thanks to Zec Building Compositions for helping make this :) 
// Relative positions exported thanks too Maca's M3Eden Editor Addon.
// modified by aussie :)
if(!isServer) exitWith {};
params ["_center",["_staticWeaponClasses",[]],["_parkedVehicleClasses",[]]];

private _rotation = random 360;

[_center,25] call a3e_fnc_cleanupTerrain;

if (isNil "drn_BuildAmmoDepot_MarkerInstanceNo") then { drn_BuildAmmoDepot_MarkerInstanceNo = 0 } else { drn_BuildAmmoDepot_MarkerInstanceNo = drn_BuildAmmoDepot_MarkerInstanceNo + 1 };
private _instanceNo = drn_BuildAmmoDepot_MarkerInstanceNo;

private _fnc_createObject = {
    params["_className","_centerPos","_relativePos","_rotateDir","_relativeDir"];
    private _realPos = ([_centerPos, [(_centerPos select 0) + (_relativePos select 0), (_centerPos select 1) + (_relativePos select 1),(_relativePos select 2)], _rotateDir] call A3E_fnc_rotatePosition);
    private _object = createVehicle [_className, _realPos, [], 0, "CAN_COLLIDE"];
    _object setDir (_relativeDir + _rotateDir);
    _object setPosATL _realPos;
    _object
};

// Cars
{
	if (count _parkedVehicleClasses == 0) exitWith {};
	private _obj = [selectRandom _parkedVehicleClasses, _center, _x#0, _rotation, _x#1] call _fnc_createObject;
	[_obj, A3E_VAR_Side_Opfor] spawn A3E_fnc_AddStaticGunner; 
} forEach [
	[[-5.27795,-15.8394,1], 90]
];

// Statics
{
	if (count _staticWeaponClasses == 0) exitWith {};
	private _obj = [selectRandom _staticWeaponClasses, _center, _x#0, _rotation, _x#1] call _fnc_createObject;
	[_obj, A3E_VAR_Side_Opfor] spawn A3E_fnc_AddStaticGunner; 
} forEach [
	[[6.0531,12.4585,0.2], 270],
	[[3.42651,-6.48389,0.2], 270]
];

//SPAWN IN THE BASE OBJECTS	
{
	_x params ["_type","_offset","_dir"];
	[_type, _center, _offset, _rotation, _dir] call _fnc_createObject;
} forEach [
	["Land_Cargo_House_V1_F",[7.94409,2.11621,0],90],
	["Land_Cargo_House_V1_F",[-7.29944,-1.27393,0],180],
	["Land_HBarrier_5_F",[6.37476,16.2656,0],180],
	["Land_HBarrier_5_F",[-13.0569,13.5439,0],90],
	["Land_HBarrier_5_F",[-9.1521,16.9565,0],180],
	["Land_HBarrier_5_F",[-2.13916,6.80273,0],180],
	["Land_Garbage_square5_F",[-0.702393,10.1104,0],0],
	["Land_Garbage_square5_F",[-9.68762,12.4941,0],0],
	["Land_GarbagePallet_F",[-0.943848,10.1108,0],0],
	["Land_Cargo10_yellow_F",[9.7356,10.1777,0],135],
	["Land_PaperBox_closed_F",[-4.49426,9.07959,0],0],
	["Land_PaperBox_closed_F",[4.01624,8.97852,0],225],
	["Land_WaterBarrel_F",[1.8606,6.67773,0],359.996],
	["Land_HBarrier_5_F",[-10.7644,-5.69727,0],270],
	["Land_HBarrier_5_F",[9.36047,-4.07227,0],285],
	["Land_HBarrier_5_F",[8.7356,-9.19727,0],270],
	["Land_HBarrier_3_F",[6.36047,-11.3223,0],0],
	["Land_HBarrier_3_F",[-9.76453,-9.19727,0],0],
	["Land_PowerGenerator_F",[-8.7644,-7.82227,0],270],
	["Land_MetalBarrel_F",[7.2356,-9.07227,0],359.966],
	["Land_MetalBarrel_F",[5.65552,-8.7207,0],224.974],
	["Land_MetalBarrel_F",[6.4856,-9.82227,0],179.966],
	["Land_MetalBarrel_F",[5.7356,-9.82227,0],224.974],
	["Land_MetalBarrel_F",[7.2356,-9.82227,0],179.966],
	["Land_MetalBarrel_F",[6.4856,-9.07227,0],359.966],
	["Land_TTowerSmall_2_F",[-9.26416,-7.57227,0],0],
	["Land_Cargo20_sand_F",[-0.809814,-11.5806,0],232]
];

// ++++++++FLAG++++++++++//
//Add your own server flag - uncomment line 103  (see https://forums.bohemia.net/forums/topic/180080-co10-escape/?do=findComment&comment=3346952 )
//+ Create a folder "flag" in the root directory of your misson file. Drop in your paa logo & call it logo.paa (jpg might work, PAA is the best).
private _obj = ["Flag_CSAT_F", _center,[7.68066,-4.16943,0], _rotation, 0] call _fnc_createObject;
//_obj forceFlagTexture "mapConfig\logo.paa"; 

// Boxes
private _aBox = [
	["weapons", a3e_arr_AmmoDepotBasicWeapons, "Box_East_Wps_F", [0.276978,-2.48975,0]] // Basic Weapons
	,["weapons", a3e_arr_AmmoDepotSpecialWeapons, "Box_East_WpsLaunch_F", [-0.655273,0.352539,0]] // Special Weapons
	,["weapons", a3e_arr_AmmoDepotOrdnance, "Box_East_WpsLaunch_F", [0.492188,2.66211,0]] // Ordinance
	,["weapons", a3e_arr_AmmoDepotLaunchers, "Box_East_WpsLaunch_F", [-0.764404,-4.57227,0]] // Launchers
	,["items", a3e_arr_AmmoDepotItems, "Box_East_Wps_F", [-2.5105,2.38525,0]] // Items
];

private _vBox = ["Box_NATO_AmmoVeh_F",[-2.34912,-1.99658,0],0];

// Vehicle Box
private _list = [];
private _listMag = [];
private _items = [];

{
	_x params ["_className", "_prob", "_minCount", "_maxCount", ["_mag",[]], ["_magPer",0]];
	if (random 100 <= _prob) then { 
		private _count = floor (_minCount + random (_maxCount - _minCount));
		_list pushBack [_className, _count];
		{ _listMag pushBack [_x, _count * _magPer] } forEach _mag;
	};
} forEach a3e_arr_AmmoDepotVehicle;

{
	_x params ["_className", "_prob", "_minCount", "_maxCount", ["_mag",[]], ["_magPer",0]];
	if (random 100 <= _prob) then { 
		private _count = floor (_minCount + random (_maxCount - _minCount));
		_items pushBack [_className, _count];
	};	
} forEach a3e_arr_AmmoDepotVehicleItems;

// Weapons Boxes
{
	_x params ["_itemType", ["_itemList",[]], ["_boxClass","Box_East_Wps_F"], ["_boxOffset",[0,0,0]], ["_boxRot",0]];
	private _list = [];
	private _listMag = [];

	{
		_x params ["_className", "_prob", "_minCount", "_maxCount", ["_mag",[]], ["_magPer",0]];
		if (random 100 <= _prob) then { 
			private _count = floor (_minCount + random (_maxCount - _minCount));
			_list pushBack [_className, _count];
			{ _listMag pushBack [_x, _count * _magPer] } forEach _mag;
		};
	} forEach _itemList;
	
	_list = _list - [[objNull,1]];
	  
	if (count _list > 0 || count _listMag > 0) then {
		private _box = [_boxClass, _center, _boxOffset, _rotation, _boxRot] call _fnc_createObject;
		clearWeaponCargoGlobal _box;
		clearMagazineCargoGlobal _box;
		clearItemCargoGlobal _box;
		clearBackpackCargoGlobal _box;
		
		if (_itemType == 'weapons') then {
			{ _box addWeaponCargoGlobal _x } forEach _list;
			{ _box addMagazineCargoGlobal _x } forEach _listMag;
		} else {
			{ _box addItemCargoGlobal _x } forEach _list;
			{ _box addMagazineCargoGlobal _x } forEach _listMag;
		};
	};
} forEach _aBox;

if (A3E_Param_Waffelbox == 1) then {
	private _box = createVehicle [a3e_additional_weapon_box_1, [(_center select 0) + 0, (_center select 1) + 3, 0], [], 0, "CAN_COLLIDE"];
	_box call A3E_fnc_initArsenal;		  
	_box = createVehicle [a3e_additional_weapon_box_2, [(_center select 0) + 3, (_center select 1) + 3, 0], [], 0, "CAN_COLLIDE"];
	_box call A3E_fnc_initArsenal;				  
};

// Set markers  
["drn_AmmoDepotMapMarker" + str _instanceNo,_center,"o_installation"] call A3E_fnc_createLocationMarker;
private _marker = createMarkerLocal ["drn_AmmoDepotPatrolMarker" + str _instanceNo, _center];
_marker setMarkerShapeLocal "ELLIPSE";
_marker setMarkerAlphaLocal 0;
_marker setMarkerSizeLocal [50, 50];