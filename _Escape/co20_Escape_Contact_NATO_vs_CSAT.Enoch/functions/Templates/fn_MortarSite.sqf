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
	["Land_BagFence_Round_F", [-1.91934,2.4248,0], 145],
	["Land_BagFence_Round_F", [-2.45572,0.17334,0], 59],
	["Land_BagFence_Round_F", [1.88663,1.83105,0], 233],
	["Land_BagFence_Short_F", [2.3082,-0.335938,0], 94],
	["Land_BagFence_Short_F", [-0.00991821,2.76123,0], 185],
	["Land_BagFence_End_F", [-1.33304,-0.887207,0], 30],
	["Land_Pallets_F", [2.75821,3.7749,0], 150],
	["Land_Sacks_heap_F", [-1.77365,-2.30322,0], 197]
];

["A3E_MortarSiteMapMarker" + str _number,_position,"o_mortar"] call A3E_fnc_createLocationMarker;

_marker = createMarkerLocal ["A3E_MortarSitePatrolMarker" + str _number, _position];
_marker setMarkerShapeLocal "ELLIPSE";
_marker setMarkerAlphaLocal 0;
_marker setMarkerSizeLocal [50, 50];