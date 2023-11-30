// MISSION VARAIBLES
player addRating 100000;
[player, "NoVoice"] remoteExec ["setSpeaker", -2, format["NoVoice_%1", netId player]]; // No player voice
showSubtitles false; // No radio calls
"Group" setDynamicSimulationDistance 1200;
"Vehicle" setDynamicSimulationDistance 2500;
//enableEngineArtillery false; 	// Disable Artillery Computer
onMapSingleClick "_shift";	// Disable Map Clicking
f_var_AuthorUID = '76561197970695190'; // Allows GUID to access Admin/Zeus features in MP.
f_var_fogOverride = [[0,0,0],[0.1,0.005,100],[0.9,0.0155,0],[0.1,random 0.02,100]]; // Override default fog settings [[none],[Light],[heavy],[rand]].
[nil, 2] execVM "f\casualtiesCap\f_CasualtiesCapCheck.sqf";
[] execVM "scripts\z_ambientUnits.sqf";	// Ambient Infantry
// ====================================================================================
// Hardcore Settings:
FAR_var_DeathMessages = false; // Disable TK Messages
f_var_ShowFTMarkers = false; // Disable FT Markers
f_param_fastTravel = 1; // Enable Fast Travel
[] spawn { sleep 1; tao_foldmap_isOpen = true; ZEU_tkLog_mpKilledEH = {}; };
