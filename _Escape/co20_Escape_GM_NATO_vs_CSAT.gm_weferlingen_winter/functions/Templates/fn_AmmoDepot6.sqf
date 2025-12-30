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
	[[-4.09509,9.50903,1], 90]
];

// Statics
{
	if (count _staticWeaponClasses == 0) exitWith {};
	private _obj = [selectRandom _staticWeaponClasses, _center, _x#0, _rotation, _x#1] call _fnc_createObject;
	[_obj, A3E_VAR_Side_Opfor] spawn A3E_fnc_AddStaticGunner; 
} forEach [
	[[-9.84509,-6.61597,0.2], 270],
	[[8.15491,-7.61597,0.2], 90]
];

//SPAWN IN THE BASE OBJECTS	
{
	_x params ["_type","_offset","_dir"];
	[_type, _center, _offset, _rotation, _dir] call _fnc_createObject;
} forEach [
	["Land_BagFence_Corner_F", [-11.7974,-8.23901,0], 180],
	["Land_BagFence_Corner_F", [9.90283,-9.06812,0], 90],
	["Land_BagFence_Corner_F", [9.73218,-6.36792,0], 0],
	["Land_BagFence_Corner_F", [-11.968,-5.53882,0], 270],
	["Land_BagFence_Short_F", [10.1549,-7.61597,0], 270],
	["Land_BagFence_Short_F", [-12.2201,-6.99097,0], 90],
	["Land_BagFence_Short_F", [-10.7205,-5.18921,0], 0],
	["Land_BagFence_Short_F", [8.40497,-6.11597,0], 180],
	["Land_BagFence_Short_F", [8.65527,-9.41772,0], 180],
	["Land_BagFence_Short_F", [-10.4702,-8.49097,0], 0],
	["Land_TinWall_01_m_4m_v1_F", [-1.44049,-9.48169,0], 30],
	["Land_TinWall_01_m_4m_v1_F", [-5.19019,-8.48169,0], 0],
	["Land_TinWall_01_m_4m_v1_F", [4.49963,-4.25,0], 270],
	["Land_TinWall_01_m_gate_v2_F", [4.49976,-8.25,0], 270],
	["Land_TinWall_01_m_pole_F", [4.52991,-10.366,0], 0],
	["Land_Pallets_stack_F", [-4.09509,-7.24097,0], 15],
	["Land_TinWall_01_m_4m_v2_F", [2.4046,-10.4907,0], 0],
	["Land_TinWall_01_m_4m_v2_F", [-7.59521,-4.24097,0], 90],
	["Land_Pallets_F", [-1.47009,-8.24097,0], 135],
	["Land_TinWall_01_m_4m_v1_F", [-1.50031,5.75,0], 180],
	["Land_TinWall_01_m_4m_v2_F", [4.49969,3.75,0], 270],
	["Land_TinWall_01_m_4m_v2_F", [-7.59521,-0.240967,0], 90],
	["Land_TinWall_01_m_4m_v2_F", [-5.59509,5.75903,0], 180],
	["Land_TinWall_01_m_4m_v2_F", [4.49969,-0.25,0], 270],
	["Land_TinWall_01_m_4m_v2_F", [-7.59521,3.75903,0], 90],
	["Land_TinWall_01_m_4m_v2_F", [2.49994,5.75,0], 180],
	["Land_FieldToilet_F", [-6.47028,4.63403,0], 0],
	["Land_MetalBarrel_F", [-6.96063,-0.546143,0], 25],
	["Land_MetalBarrel_F", [-7.11639,0.467529,0], 205],
	["Land_MetalBarrel_F", [-6.31512,-0.106934,0], 340],
	["Land_Tyres_F", [2.62494,3.625,0], 45]
];

// ++++++++FLAG++++++++++//
//Add your own server flag - uncomment line 103  (see https://forums.bohemia.net/forums/topic/180080-co10-escape/?do=findComment&comment=3346952 )
//+ Create a folder "flag" in the root directory of your misson file. Drop in your paa logo & call it logo.paa (jpg might work, PAA is the best).
private _obj = ["Flag_CSAT_F", _center,[-16.4143,-1.93066,0], _rotation, 0] call _fnc_createObject;
//_obj forceFlagTexture "mapConfig\logo.paa"; 

// Boxes
private _aBox = [
	["weapons", a3e_arr_AmmoDepotBasicWeapons, "Box_East_Wps_F", [-0.845093,2.38403,0]] // Basic Weapons
	,["weapons", a3e_arr_AmmoDepotSpecialWeapons, "Box_East_WpsLaunch_F", [2.15491,-0.615967,0]] // Special Weapons
	,["weapons", a3e_arr_AmmoDepotOrdnance, "Box_East_WpsLaunch_F", [2.15491,-2.61597,0]] // Ordinance
	,["weapons", a3e_arr_AmmoDepotLaunchers, "Box_East_WpsLaunch_F", [-0.720093,-2.61597,0]] // Launchers
	,["items", a3e_arr_AmmoDepotItems, "Box_East_Wps_F", [-0.845093,-0.615967,0]] // Items
];

private _vBox = ["Box_NATO_AmmoVeh_F",[-4.72009,4.13403,0],0];

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