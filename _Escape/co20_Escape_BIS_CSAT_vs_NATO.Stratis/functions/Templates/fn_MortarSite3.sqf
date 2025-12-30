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
	["Land_BagFence_Long_F", [2.3623,2.34888,0], -135],
	["Land_BagFence_Round_F", [-1.38477,4.646,0], 139],
	["Land_BagFence_Round_F", [4.12891,-1.59399,0], -41],
	["Land_BagFence_Round_F", [4.3042,0.562988,0], -131],
	["Land_BagFence_Round_F", [0.771729,4.47046,0], -131],
	["Land_Basket_F", [2.42944,-2.18774,0], -108],
	["Land_Sack_F", [3.17944,-2.56226,0], 108],
	["Land_CanisterPlastic_F", [2.4292,-2.93774,0], -65],
	["Land_GasTank_01_yellow_F", [-2.49902,3.32153,0], 225],
	["Land_GasTank_01_yellow_F", [-2.05664,3.23315,0], 75]
];

["A3E_MortarSiteMapMarker" + str _number,_position,"o_mortar"] call A3E_fnc_createLocationMarker;

_marker = createMarkerLocal ["A3E_MortarSitePatrolMarker" + str _number, _position];
_marker setMarkerShapeLocal "ELLIPSE";
_marker setMarkerAlphaLocal 0;
_marker setMarkerSizeLocal [50, 50];