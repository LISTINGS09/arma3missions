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
f_var_fogOverride = [[0,0,0],[0.1,0.005,100],[0.1,0.04,100],[0.1,random 0.02,100]]; // Override default fog settings [[none],[Light],[heavy],[rand]].
// ====================================================================================
// F3 - Casualty Cap - Sides: west | east | resistance - Format: [SIDE,ENDING,<PERCENT>]
[nil, 2] execVM "f\casualtiesCap\f_CasualtiesCapCheck.sqf";
[] execVM "scripts\civPopulation.sqf";									// Civ Spawner
f_param_radioMode = 1; // radios.sqf lists allowed unit types