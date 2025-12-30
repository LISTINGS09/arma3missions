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
	[[0,-8,1], 90]
];

// Statics
{
	if (count _staticWeaponClasses == 0) exitWith {};
	private _obj = [selectRandom _staticWeaponClasses, _center, _x#0, _rotation, _x#1] call _fnc_createObject;
	[_obj, A3E_VAR_Side_Opfor] spawn A3E_fnc_AddStaticGunner; 
} forEach [
	[[-7,-1,0.2], 270]
];

//SPAWN IN THE BASE OBJECTS	
{
	_x params ["_type","_offset","_dir"];
	[_type, _center, _offset, _rotation, _dir] call _fnc_createObject;
} forEach [
	["Land_BagFence_Short_F", [-6.5,2.125,0], 180],
	["Land_WoodenCrate_01_stack_x3_F", [6.28864,5.09546,0], 270],
	["Land_BagFence_Long_F", [-9,-1,0], 90],
	["Land_BarrelSand_grey_F", [4.53857,1.97046,0], 270],
	["Land_CanisterFuel_F", [4.03821,1.4707,0], 135],
	["Land_CanisterFuel_F", [3.80035,1.95532,0], 90],
	["Land_WoodenCrate_01_stack_x5_F", [3.78864,3.59546,0], 270],
	["Land_WoodenCrate_01_F", [5.41364,3.22046,0], 345],
	["Land_BagFence_End_F", [-7.00024,-3.875,0], 345],
	["Land_BagFence_Round_F", [-8.375,1.5,0], 135],
	["Land_BagFence_Round_F", [-8.37476,-3.375,0], 45],
	["Land_FieldToilet_F", [2.16364,3.47021,0], 0],
	["Land_FieldToilet_F", [0.413574,3.22046,0], 30],
	["Land_LampShabby_F", [-4.25,4.25,0], 135],
	["Land_HBarrier_5_F", [-2.5,-3.875,0], 0],
	["Land_HBarrier_5_F", [-3.21136,5.47046,0], 0],
	["Land_HBarrier_5_F", [3.125,-3.875,0], 0],
	["Land_HBarrier_5_F", [2.41364,5.47046,0], 0],
	["Land_HBarrier_3_F", [-5.33636,3.2207,0], 270]
];

// Boxes
private _aBox = [
	["weapons", a3e_arr_AmmoDepotBasicWeapons, "Box_East_Wps_F",[3,-2,0]] // Basic Weapons
	,["weapons", a3e_arr_AmmoDepotSpecialWeapons, "Box_East_WpsLaunch_F", [-3,0,0]] // Special Weapons
	,["weapons", a3e_arr_AmmoDepotOrdnance, "Box_East_WpsLaunch_F", [-3,-2,0]] // Ordinance
	,["weapons", a3e_arr_AmmoDepotLaunchers, "Box_East_WpsLaunch_F", [3,0,0]] // Launchers
	,["items", a3e_arr_AmmoDepotItems, "Box_East_Wps_F", [0,-2,0]] // Items
];

private _vBox = ["Box_NATO_AmmoVeh_F",[-3,3,0],0];

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