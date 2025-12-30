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
	["Land_BagFence_Round_F", [-0.267578,3.63965,0], 199],
	["Land_BagFence_Round_F", [-2.2644,2.75732,0], 112],
	["Land_BagFence_Round_F", [0.474854,-2.21436,0], 11],
	["Land_BagFence_Round_F", [2.33105,-1.06543,0], -76],
	["Land_MetalBarrel_F", [-3.28589,1.82861,0], 147],
	["Land_MetalBarrel_F", [3.21484,-0.00488281,0], -41],
	["Land_Sacks_heap_F", [2.38232,1.05371,0], 178],
	["Land_Sacks_heap_F", [3.83105,-0.937744,0], 120]
];

["A3E_MortarSiteMapMarker" + str _number,_position,"o_mortar"] call A3E_fnc_createLocationMarker;

_marker = createMarkerLocal ["A3E_MortarSitePatrolMarker" + str _number, _position];
_marker setMarkerShapeLocal "ELLIPSE";
_marker setMarkerAlphaLocal 0;
_marker setMarkerSizeLocal [50, 50];