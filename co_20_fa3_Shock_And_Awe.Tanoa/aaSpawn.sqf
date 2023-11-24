if (!isServer) exitWith {};

_aaspawns = [aaSpawn] call ws_fnc_collectObjectsNum;


while {true} do {
	sleep (120 + random 200);
	_man = createGroup east createUnit ["O_T_Soldier_AA_F",getPosATL (_aaspawns call BIS_fnc_selectRandom),[],0,"CAN_COLLIDE"];
	_man removeMagazines "Titan_AA"; // should leave him with one rocket
};