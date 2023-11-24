// MISSION VARAIBLES
player addRating 100000;
[player, "NoVoice"] remoteExec ["setSpeaker", -2, format["NoVoice_%1", netId player]]; // No player voice
showSubtitles false; // No radio calls
"Group" setDynamicSimulationDistance 1200;
"Vehicle" setDynamicSimulationDistance 2500;
//enableEngineArtillery false; 	// Disable Artillery Computer
//onMapSingleClick "_shift";	// Disable Map Clicking
//setApertureNew [1.5, 8, 14, 1]; // Less Dark Night
f_var_AuthorUID = '76561197970695190'; // Allows GUID to access Admin/Zeus features in MP.
//f_var_fogOverride = [[0,0,0],[0.1,0.005,100],[0.9,0.0155,0],[0.1,random 0.02,100]]; // Override default fog settings [[none],[Light],[heavy],[rand]].
// ====================================================================================
// F3 - Casualty Cap - Sides: west | east | resistance - Format: [SIDE,ENDING,<PERCENT>]
[nil, 2] execVM "f\casualtiesCap\f_CasualtiesCapCheck.sqf";
// ====================================================================================
ws_game_a3 = false;
[] execVM "ws_fnc\ws_fnc_init.sqf";
waitUntil {!isNil "ws_fnc_compiled"};
ws_game_a3 = true;

{
	if (!isNil {_x getVariable "z"}) then {
		_x setPosASL [getPosASL _x select 0, getPosASL _x select 1, _x getVariable "z"];
		_x setVectorUp [0,0,1];
		_x enableSimulation false;
	};
} forEach allMissionObjects "ALL";

[] execVM "ws_garrisonControl.sqf";

secondaryExplosions = compileFinal preprocessFile "secondaryExplosions.sqf";
engineers = ["UnitFIA_ENG1"] call ws_fnc_collectObjects;

if (isServer) then {
	dumps = [ceil (random 5)];
	_dump = ceil (random 5);
	while {_dump in dumps} do {_dump = ceil (random 5);};
	dumps = dumps + [_dump];
	publicVariable "dumps";
};
dumpsDestroyed = 0;

if (f_param_debugMode == 1) then {
	player sideChat format ["dumps: %1", dumps];
};
_bombs = [dump1_bomb, dump2_bomb, dump3_bomb, dump4_bomb, dump5_bomb];

for "_i" from 1 to 5 do {
	if (!(_i in dumps) ) then {
		{deleteVehicle _x} forEach ([format ["dump%1",_i]] call ws_fnc_collectObjects);
	};
};

{[_x] execVM "rigBomb.sqf"} forEach [_bombs select ((dumps select 0) - 1), _bombs select ((dumps select 1) - 1)];