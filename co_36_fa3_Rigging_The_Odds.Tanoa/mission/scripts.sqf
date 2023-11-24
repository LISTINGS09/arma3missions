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

civilian setFriend [west,1];
civilian setFriend [independent,0];

if (isServer) then {
	ws_game_a3 = false;
	[] execVM "ws_fnc\ws_fnc_init.sqf";
	waitUntil {!isNil "ws_fnc_compiled"};
	ws_game_a3 = true;
	
	_nato = [];
	_pmc = [];

	{
		if (faction _x == "blu_t_f" && _x distance2d getMarkerPos "rig" < 1000) then {
			_nato pushBack _x;
			_x unlinkItem "NVGoggles_tna_F";
		};
		if (faction _x == "blu_f") then {
			_pmc pushBack _x;
		};
	} forEach allUnits;
	
	while {count _nato > 20} do {
		_unit = selectRandom _nato;
		_nato = _nato - [_unit];
		deleteVehicle _unit;
	};
	
	while {count _pmc > 20} do {
		_unit = selectRandom _pmc;
		_pmc = _pmc - [_unit];
		deleteVehicle _unit;
	};
};