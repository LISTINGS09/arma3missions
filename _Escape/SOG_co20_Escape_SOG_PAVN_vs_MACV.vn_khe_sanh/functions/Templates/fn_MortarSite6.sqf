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
	["Land_BagFence_Long_F", [-2.20728,-1.61987,0], -95],
	["Land_PaperBox_open_empty_F", [3.29956,0.50415,0], -230],
	["Land_BagFence_Round_F", [-0.663086,3.52271,0], -190],
	["Land_BagFence_Round_F", [0.245117,-4.53687,0], 9],
	["Land_PaperBox_closed_F", [3.43848,-1.61768,0], -205],
	["Land_BagFence_End_F", [1.72559,-4.23755,0], -36],
	["Land_BagFence_End_F", [-1.96387,2.75464,0], 125],
	["Land_HBarrier_1_F", [1.33545,2.98682,0], -55],
	["Land_HBarrier_1_F", [-1.69604,-3.50757,0], -216]
];

["A3E_MortarSiteMapMarker" + str _number,_position,"o_mortar"] call A3E_fnc_createLocationMarker;

_marker = createMarkerLocal ["A3E_MortarSitePatrolMarker" + str _number, _position];
_marker setMarkerShapeLocal "ELLIPSE";
_marker setMarkerAlphaLocal 0;
_marker setMarkerSizeLocal [50, 50];