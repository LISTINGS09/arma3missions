params ["_position"];

if(isNil("A3E_MortarMarkerNumber")) then { A3E_MortarMarkerNumber = 0 } else { A3E_MortarMarkerNumber = A3E_MortarMarkerNumber +1 };
private _number = A3E_MortarMarkerNumber;

private _mtr = createVehicle [selectRandom a3e_arr_MortarSite, _position, [], 0, "NONE"];
_mtr setDir random 360;
private _gunner = [_mtr, A3E_VAR_Side_Opfor] spawn A3E_fnc_AddStaticGunner; 
a3e_var_artillery_units pushBack _mtr;

{
	_x params ["_type","_offset","_dir"];

	private _obj =  createVehicle [_type, [0,0,0], [], 0, "NONE"];
	_obj setDir _dir;
	_obj setPos (_position vectorAdd _offset);
} forEach [
	["Land_BagFence_Long_F", [-1.9082,0.124023,0], -285],
	["Land_BagFence_Round_F", [-0.67041,-2.01953,0], -330],
	["Land_BagFence_Round_F", [0.173828,3.0603,0], -150],
	["Land_BagFence_Round_F", [1.60791,-1.72424,0], -45],
	["Land_BagFence_Round_F", [-1.91895,2.57983,0], -240],
	["Land_Pallets_F", [3.08838,4.56372,0], -152],
	["Land_CratesWooden_F", [1.11279,5.07703,0], -164],
	["Land_Sacks_heap_F", [1.98877,6.07166,0], -163]
];

["A3E_MortarSiteMapMarker" + str _number,_position,"o_mortar"] call A3E_fnc_createLocationMarker;

_marker = createMarkerLocal ["A3E_MortarSitePatrolMarker" + str _number, _position];
_marker setMarkerShapeLocal "ELLIPSE";
_marker setMarkerAlphaLocal 0;
_marker setMarkerSizeLocal [50, 50];