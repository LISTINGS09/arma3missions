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
	[[-4,4.5,1], 90]
];

// Statics
{
	if (count _staticWeaponClasses == 0) exitWith {};
	private _obj = [selectRandom _staticWeaponClasses, _center, _x#0, _rotation, _x#1] call _fnc_createObject;
	[_obj, A3E_VAR_Side_Opfor] spawn A3E_fnc_AddStaticGunner; 
} forEach [
	[[-11.7528,-6.52271,0.2], 270]
];

//SPAWN IN THE BASE OBJECTS	
{
	_x params ["_type","_offset","_dir"];
	[_type, _center, _offset, _rotation, _dir] call _fnc_createObject;
} forEach [
	["Land_New_WiredFence_5m_F",[-10.2106,4.54272,0],90],
	["Land_LampShabby_F",[-9.78967,6.03186,0],130],
	["Land_New_WiredFence_10m_F",[-5.52759,6.67126,0],180],
	["Land_New_WiredFence_10m_F",[4.57214,6.7522,0],180],
	["Land_New_WiredFence_5m_F",[-10.314,-6.51233,0],90],
	["Land_Net_Fence_Gate_F",[-10.6722,-1.05103,0],90],
	["Land_BagFence_End_F",[-11.0073,-8.27209,0],0],
	["Land_BagFence_Round_F",[-12.5851,-5.17175,0],125],
	["Land_BagFence_End_F",[-11.0167,-4.33191,0],0],
	["Land_BagFence_Round_F",[-12.5383,-7.54541,0],45],
	["Land_New_WiredFence_10m_F",[-5.54004,-9.3822,0],270],
	["Land_LampShabby_F",[7.77478,-2.05566,0],0],
	["Land_Net_Fence_Gate_F",[9.48694,4.03503,0],90],
	["Land_New_WiredFence_10m_F",[9.79907,-3.88293,0],90],
	["Land_Cargo_House_V2_F",[4.15967,-5.37695,0],90],  
	["Land_New_WiredFence_10m_F",[4.53369,-9.31958,0],180]
];

// ++++++++FLAG++++++++++//
//Add your own server flag - uncomment line 103  (see https://forums.bohemia.net/forums/topic/180080-co10-escape/?do=findComment&comment=3346952 )
//+ Create a folder "flag" in the root directory of your misson file. Drop in your paa logo & call it logo.paa (jpg might work, PAA is the best).
private _obj = ["Flag_CSAT_F", _center,[3.01978,-8.02002,0], _rotation, 0] call _fnc_createObject;
//_obj forceFlagTexture "mapConfig\logo.paa"; 


// Boxes
private _aBox = [
	["weapons", a3e_arr_AmmoDepotBasicWeapons, "Box_East_Wps_F", [-4.62939,-4.94458,0]] // Basic Weapons
	,["weapons", a3e_arr_AmmoDepotSpecialWeapons, "Box_East_WpsLaunch_F", [-1.5481,-4.83618,0]] // Special Weapons
	,["weapons", a3e_arr_AmmoDepotOrdnance, "Box_East_WpsLaunch_F", [-8.66211,-7.44202,0]] // Ordinance
	,["weapons", a3e_arr_AmmoDepotLaunchers, "Box_East_WpsLaunch_F", [-2.97229,-7.60938,0]] // Launchers
	,["items", a3e_arr_AmmoDepotItems, "Box_East_Wps_F", [-5.63904,-7.51245,0]] // Items
];

private _vBox = ["Box_NATO_AmmoVeh_F",[-7.50476,-5.06494,0],0];
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

/*
if (count _list > 0 || count _listMag > 0 || count _items > 0) then {
	_vBox params ["_vType","_vOff", "_vRot"];
	private _box  = [_vType, _center, _vOff, _rotation, _vRot] call _fnc_createObject;
	clearWeaponCargoGlobal _box;
	clearMagazineCargoGlobal _box;
	clearItemCargoGlobal _box;
	clearBackpackCargoGlobal _box;
	{ _box addWeaponCargoGlobal _x } forEach _list;
	{ _box addMagazineCargoGlobal _x } forEach _listMag;
	{ _box addBackpackCargoGlobal [_x, 4] } forEach a3e_arr_AmmoDepotVehicleBackpacks;
	{ _box addItemCargoGlobal _x } forEach _items;
};
*/

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