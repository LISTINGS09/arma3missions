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
	[[26.1731,0,1], 90]
];

// Statics
{
	if (count _staticWeaponClasses == 0) exitWith {};
	private _obj = [selectRandom _staticWeaponClasses, _center, _x#0, _rotation, _x#1] call _fnc_createObject;
	[_obj, A3E_VAR_Side_Opfor] spawn A3E_fnc_AddStaticGunner; 
} forEach [
	[[-13.532,13.2534,0.2], 90],
	[[-7.66699,-5.83887,0.2], 270]
];

//SPAWN IN THE BASE OBJECTS	
{
	_x params ["_type","_offset","_dir"];
	[_type, _center, _offset, _rotation, _dir] call _fnc_createObject;
} forEach [
	["Land_PowerGenerator_F",[-13.2283,4.92969,0],180],
	["Land_TTowerSmall_2_F",[-15.7585,4.91602,0],0],
	["Land_Shed_Big_F",[6.64624,1.66602,0],0],
	["Land_Cargo_HQ_V1_F",[3.64636,1.44727,0],0],
	["Land_HBarrier_Big_F",[-18.8104,2.74414,0],270],
	["Land_HBarrier_Big_F",[-18.5604,-1.50586,0],270],
	["Land_HBarrier_Big_F",[-15.8107,7.74414,0],0],
	["Land_HBarrier_Big_F",[-15.3107,-6.50586,0],0],
	["Land_HBarrierWall4_F",[5.89661,11.4478,0],375],
	["Land_HBarrierWall4_F",[0.896484,11.9478,0],360],
	["Land_Razorwire_F",[4.14624,14.1973,0],180],
	["Land_Razorwire_F",[-7.35376,11.4473,0],180],
	["Land_Razorwire_F",[-16.5605,-8.25586,0],0],
	["Land_IronPipes_F",[-8.66394,-11.6445,0],15],
	["Land_ConcretePipe_F",[-8.88721,19.7896,0],150],
	["Land_HBarrier_5_F",[18.8116,-8.81396,0],120],
	["Land_HBarrier_3_F",[-2.35376,12.1973,0],90],
	["Land_HBarrier_3_F",[9.64624,11.9473,0],270],
	["Land_HBarrier_3_F",[17.401,9.82178,0],66.0661],
	["Land_WaterTank_F",[6.39624,-5.05273,0],0],
	["Land_CratesWooden_F",[-6.85376,6.94727,0],270],
	["Land_HBarrier_1_F",[-2.10376,7.94678,0],180],
	["Land_HBarrier_1_F",[9.64636,13.9473,0],75],
	["Land_HBarrier_1_F",[-1.60388,6.44727,0],150],
	["Land_PaperBox_open_full_F",[0.396118,-8.05273,0],0],
	["Land_PaperBox_open_empty_F",[9.64612,-5.05273,0],0],
	["Land_WoodenTable_large_F",[-4.10376,3.44727,0],120],
	["Land_PaperBox_closed_F",[0.396118,-6.30273,0],195],
	["Land_Sacks_heap_F",[13.3962,-5.05273,0],0],
	["Land_CncBarrier_F",[19.97,1.30176,0],90],
	["Land_CncBarrier_F",[19.2821,-3.31396,0],90],
	["Land_CncBarrier_F",[16.6464,13.9468,0],240],
	["Land_CncBarrier_F",[19.6637,8.20215,0],90],
	["Land_CncBarrier_F",[13.3961,16.9478,0],210],
	["Land_ShelvesWooden_khaki_F",[-4.60498,-3.30273,0],90],
	["FlexibleTank_01_sand_F",[1.64648,-6.80273,0],0],
	["Land_CampingChair_V2_F",[-4.10742,2.62549,0],45.0014],
	["Land_CampingChair_V2_F",[-4.22388,4.42432,0],180.001],
	["Land_MetalBarrel_F",[-3.10376,7.94727,0],314.984],
	["Land_BarrelTrash_grey_F",[-3.60376,-3.30273,0],0],
	["Land_BarrelSand_F",[10.8962,10.9473,0],359.989],
	["Land_PlasticCase_01_small_F",[-5.59644,-3.30371,0],330],
	["Land_Garbage_square5_F",[-3.85388,4.19727,0],0],
	["Land_HBarrier_Big_F",[-1.85364,-9.55273,0],270],
	["Land_HBarrier_Big_F",[3.39636,-12.8027,0],180],
	["Land_Razorwire_F",[-3.85376,-10.3027,0],90],
	["Land_Razorwire_F",[1.14624,-14.3027,0],0],
	["Land_LampShabby_F",[8.64636,-12.8032,0],270],
	["Land_Cargo10_grey_F",[1.14624,-10.3027,0],0],
	["Land_HBarrier_3_F",[7.14612,-11.0527,0],180],
	["Land_HBarrier_3_F",[8.14624,-12.5527,0],270],
	["Land_HBarrier_3_F",[7.14636,-14.3027,0],0],
	["Land_CncBarrier_F",[13.6461,-13.5527,0],315],
	["Land_MetalBarrel_F",[9.39624,-11.8027,0],314.984],
	["Land_MetalBarrel_F",[9.64624,-11.0527,0],179.991],
	["Land_Coil_F",[-12.8181,-15.1147,0],5],
	["Land_Razorwire_F",[-20.5605,-4.75586,0],90],
	["Land_Razorwire_F",[-20.8105,5.99414,0],90],
	["Land_ConcretePipe_F",[-9.77002,15.9189,0],120.031]
];

// ++++++++FLAG++++++++++//
//Add your own server flag - uncomment line 103  (see https://forums.bohemia.net/forums/topic/180080-co10-escape/?do=findComment&comment=3346952 )
//+ Create a folder "flag" in the root directory of your misson file. Drop in your paa logo & call it logo.paa (jpg might work, PAA is the best).
private _obj = ["Flag_CSAT_F", _center,[-16.4143,-1.93066,0], _rotation, 0] call _fnc_createObject;
//_obj forceFlagTexture "mapConfig\logo.paa"; 

// Boxes
private _aBox = [
	["weapons", a3e_arr_AmmoDepotBasicWeapons, "Box_East_Wps_F", [-9.77002,1,0]] // Basic Weapons
	,["weapons", a3e_arr_AmmoDepotSpecialWeapons, "Box_East_WpsLaunch_F", [-15.1067,1.13428,0]] // Special Weapons
	,["weapons", a3e_arr_AmmoDepotOrdnance, "Box_East_WpsLaunch_F", [4.58655,-8.20313,0]] // Ordinance
	,["weapons", a3e_arr_AmmoDepotLaunchers, "Box_East_WpsLaunch_F", [-14.5537,-1.21094,0]] // Launchers
	,["items", a3e_arr_AmmoDepotItems, "Box_East_Wps_F", [6.86023,-9.09326,0]] // Items
];

private _vBox = ["Box_NATO_AmmoVeh_F",[16.37134,-0.7197,0],0];

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