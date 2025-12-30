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
	[[-5,-1,0.2], 270]
];

//SPAWN IN THE BASE OBJECTS	
{
	_x params ["_type","_offset","_dir"];
	[_type, _center, _offset, _rotation, _dir] call _fnc_createObject;
} forEach [
	["Land_WoodenCrate_01_stack_x3_F", [-5.75,2.75,0], 0],
	["Land_BagFence_Long_F", [6.74396,2.5061,0], 270],
	["Land_BagFence_Long_F", [-3.81122,-3.08936,0], 0],
	["Land_BagFence_Long_F", [6.7735,-0.438721,0], 90],
	["Land_BagFence_Long_F", [-6.96576,2.85522,0], 270],
	["Land_BagFence_Long_F", [-6.93622,-0.0895996,0], 90],
	["Land_BagFence_Long_F", [3.61902,5.50586,0], 180],
	["Land_WoodenCrate_01_stack_x5_F", [2,-1,0], 90],
	["Land_WoodenCrate_01_F", [0.563782,-2.4646,0], 105],
	["Land_BagFence_End_F", [1.99396,5.3811,0], 150],
	["Land_BagFence_End_F", [6.89856,-2.06348,0], 60],
	["Land_BagFence_End_F", [-7.09076,4.47998,0], 240],
	["Land_BagFence_End_F", [-2.18616,-2.9646,0], 330],
	["Land_BagFence_Round_F", [-6.31128,-2.46484,0], 45],
	["Land_BagFence_Round_F", [6.11902,4.88135,0], 225],
	["CamoNet_OPFOR_open_F", [-0.186218,0.5354,0], 0],
	["Land_MetalBarrel_F", [3.5,6.25,0], 360],
	["Land_HBarrier_5_F", [-0.0612183,1.4104,0], 90],
	["Land_Garbage_square5_F", [-6,4,0], 270],
	["Land_Garbage_square5_F", [2,-1,0], 270],
	["Land_Camping_Light_F", [1.75,0.375,0], 0]
];

// Boxes
private _aBox = [
	["weapons", a3e_arr_AmmoDepotBasicWeapons, "Box_East_Wps_F", [-2,3,0], 270] // Basic Weapons
	,["weapons", a3e_arr_AmmoDepotSpecialWeapons, "Box_East_WpsLaunch_F", [-2,0,0], 270] // Special Weapons
	,["weapons", a3e_arr_AmmoDepotOrdnance, "Box_East_WpsLaunch_F", [4,4,0]] // Ordinance
	,["weapons", a3e_arr_AmmoDepotLaunchers, "Box_East_WpsLaunch_F", [4,1,0], 90] // Launchers
	,["items", a3e_arr_AmmoDepotItems, "Box_East_Wps_F", [4,-2,0], 90] // Items
];

private _vBox = ["Box_NATO_AmmoVeh_F",[0,6,0],0];

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