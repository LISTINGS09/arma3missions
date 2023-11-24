if (!isServer) exitWith {};

_source = _this select 0;
_radius = _this select 1; 
 
_explosives = ["R_60mm_HE", "HelicopterExploSmall", "Bo_Mk82", "M_RPG32_AA_F", "M_Mo_120mm_AT", "ModuleExplosive_SatchelCharge_F"];

_randomPos = {[(getPosATL (_this select 0) select 0) - _radius + random (2 * _radius),
			   (getPosATL (_this select 0) select 1) - _radius + random (2 * _radius),
				getPosATL (_this select 0) select 2]};
for "_i" from 1 to 2 + floor (random 3) do {
	"test_EmptyObjectForFireBig" createVehicle ([_source] call _randomPos);
};

sleep 1;
for "_i" from 2 to 4 + floor(random 3) do {
	sleep (.25 + random 2);
	if (f_param_debugMode == 1) then {
		player sideChat "secondaryExplosions: boom!"
	};
	_boom = _explosives call BIS_fnc_selectRandom createVehicle ([_source] call _randomPos);
	_boom setVelocity [0,0,-50];
	_boom setDamage 1;
};
