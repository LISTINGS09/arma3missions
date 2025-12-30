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
	[[-7.52502,-19.5674,1], 90]
];

// Statics
{
	if (count _staticWeaponClasses == 0) exitWith {};
	private _obj = [selectRandom _staticWeaponClasses, _center, _x#0, _rotation, _x#1] call _fnc_createObject;
	[_obj, A3E_VAR_Side_Opfor] spawn A3E_fnc_AddStaticGunner; 
} forEach [
	[[-14.3452,-5.09326,0.2], 270],
	[[15.0289,10.7007,0.2], 270]
];

//SPAWN IN THE BASE OBJECTS	
{
	_x params ["_type","_offset","_dir"];
	[_type, _center, _offset, _rotation, _dir] call _fnc_createObject;
} forEach [
	["Land_HBarrier_5_F",[14.7574,-1.69922,0],270],
	["Land_Garbage_square5_F",[15.6165,-4.22607,0],0],
	["Land_GarbageWashingMachine_F",[14.8662,-3.47607,0],0],
	["Land_BagFence_Round_F",[16.73,11.8066,0],226.013],
	["Land_BagFence_Long_F",[14.2413,12.5239,0],0],
	["Land_BagFence_End_F",[17.2416,10.3989,0],300],
	["Land_GarbageBags_F",[15.3663,-1.72607,0],0],
	["Land_HBarrier_5_F",[14.4913,-11.1011,0],270],
	["Land_Cargo_House_V3_F",[7.11633,3.27393,0],225],
	["Land_Cargo20_brick_red_F",[-15.3837,7.27393,0],90],
	["Land_HBarrier_5_F",[-9.87659,10.7598,0],165],
	["Land_HBarrier_5_F",[-13.0673,7.9834,0],90],
	["Land_HBarrier_5_F",[-4.38342,11.7739,0],180],
	["Land_Garbage_square5_F",[-9.38354,7.52393,0],0],
	["Land_Garbage_square5_F",[-4.38354,8.02393,0],0],
	["Land_GarbagePallet_F",[-11.6337,9.27393,0],315],
	["Land_Cargo10_sand_F",[11.8663,0.0239258,0],180.001],
	["Land_CratesWooden_F",[4.86633,6.52393,0],315],
	["Land_BagFence_Round_F",[2.99121,12.0239,0],134.609],
	["Land_BagFence_Round_F",[-16.6647,-3.09863,0],102.894],
	["Land_PowerGenerator_F",[0.866577,-5.72607,0],180],
	["Land_BagFence_Long_F",[8.24133,12.6489,0],180],
	["Land_BagFence_Long_F",[-17.0186,-6.71777,0],270],
	["Land_BagFence_Long_F",[5.36633,12.6489,0],0],
	["Land_PaperBox_closed_F",[-5.38367,9.77393,0],0],
	["Land_PaperBox_closed_F",[12.6161,-2.22607,0],90],
	["Land_PaperBox_closed_F",[12.6163,-3.85107,0],0],
	["Land_Sacks_goods_F",[-3.63367,9.77393,0],0],
	["Land_CratesShabby_F",[-9.38367,9.27393,0],75],
	["Land_BagFence_End_F",[2.11633,10.7739,0],315],
	["Land_BagFence_End_F",[12.6052,12.6821,0],30],
	["Land_BagFence_End_F",[-15.2747,-1.66064,0],150],
	["Land_MetalBarrel_F",[-8.32312,8.92041,0],225.016],
	["Land_MetalBarrel_F",[-7.65125,9.44189,0],89.9714],
	["Land_MetalBarrel_F",[-8.41785,9.70947,0],44.9736],
	["Land_Sack_F",[-8.67651,8.56689,0],105],
	["Land_BarrelTrash_F",[-1.88367,10.5239,0],359.962],
	["Land_TTowerSmall_2_F",[1.11658,-7.72607,0],0],
	["Land_Cargo_House_V3_F",[-4.66394,-10.2104,0],0],
	["Land_HBarrier_5_F",[7.36658,-16.6011,0],180],
	["Land_PaperBox_closed_F",[5.86633,-14.7261,0],0],
	["Land_BagFence_End_F",[-17.1761,-8.354,0],300],
	["Land_MetalBarrel_empty_F",[8.86633,-15.2261,0],105],
	["Land_MetalBarrel_empty_F",[8.86633,-14.4761,0],105],
	["Land_MetalBarrel_empty_F",[-0.785522,-9.7583,0],105],
	["Land_MetalBarrel_F",[8.11633,-15.2261,0],179.966],
	["Land_MetalBarrel_F",[7.28625,-14.1245,0],224.974],
	["Land_MetalBarrel_F",[8.11633,-14.4761,0],359.966],
	["Land_MetalBarrel_F",[7.36633,-15.2261,0],224.974],
	["CamoNet_OPFOR_F",[-6.21301,8.35596,0],165],	
	["Land_Cargo_House_V3_F",[-11.2587,-10.1011,0],270]
];

// ++++++++FLAG++++++++++//
//Add your own server flag - uncomment line 103  (see https://forums.bohemia.net/forums/topic/180080-co10-escape/?do=findComment&comment=3346952 )
//+ Create a folder "flag" in the root directory of your misson file. Drop in your paa logo & call it logo.paa (jpg might work, PAA is the best).
private _obj = ["Flag_CSAT_F", _center,[-15.5826,-14.6431,0], _rotation, 0] call _fnc_createObject;
//_obj forceFlagTexture "mapConfig\logo.paa"; 

// Boxes
private _aBox = [
	["weapons", a3e_arr_AmmoDepotBasicWeapons, "Box_East_Wps_F", [-4.68042,-5.16992,0]] // Basic Weapons
	,["weapons", a3e_arr_AmmoDepotSpecialWeapons, "Box_East_WpsLaunch_F", [-4.46521,-0.0180664,0]] // Special Weapons
	,["weapons", a3e_arr_AmmoDepotOrdnance, "Box_East_WpsLaunch_F", [-5.61267,-2.32764,0]] // Ordinance
	,["weapons", a3e_arr_AmmoDepotLaunchers, "Box_East_WpsLaunch_F", [-5.82874,2.37256,0]] // Launchers
	,["items", a3e_arr_AmmoDepotItems, "Box_East_Wps_F", [-7.4679,-0.294922,0]] // Items
];

private _vBox = ["Box_NATO_AmmoVeh_F",[-7.30652,-4.67676,0],0];

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