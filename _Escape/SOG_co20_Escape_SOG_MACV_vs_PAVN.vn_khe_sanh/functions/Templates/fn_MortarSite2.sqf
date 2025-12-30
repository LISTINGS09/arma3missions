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
	["Land_BagFence_Long_F", [3.56006,-1.01123,0], -15],
	["Land_BagFence_Long_F", [2.07446,2.84302,0], 30],
	["Land_BagFence_Long_F", [0.867432,-1.69336,0], -15],
	["Land_Pallets_stack_F", [4.90796,-3.04956,0], -51],
	["Land_Pallet_MilBoxes_F", [2.72021,-3.46216,0], 84],
	["Land_BagFence_Long_F", [-2.19434,1.69922,0], 120],
	["Land_BagFence_Long_F", [-1.85889,-2.47925,0], 165],
	["Land_BagFence_Round_F", [-0.403564,3.55176,0], 165]
];

["A3E_MortarSiteMapMarker" + str _number,_position,"o_mortar"] call A3E_fnc_createLocationMarker;

_marker = createMarkerLocal ["A3E_MortarSitePatrolMarker" + str _number, _position];
_marker setMarkerShapeLocal "ELLIPSE";
_marker setMarkerAlphaLocal 0;
_marker setMarkerSizeLocal [50, 50];