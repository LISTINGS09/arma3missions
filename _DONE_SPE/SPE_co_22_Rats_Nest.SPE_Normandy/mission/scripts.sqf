// MISSION VARAIBLES
player addRating 100000;
[player, "NoVoice"] remoteExec ["setSpeaker", -2, format["NoVoice_%1", netId player]]; // No player voice
showSubtitles false; // No radio calls
"Group" setDynamicSimulationDistance 1200;
"Vehicle" setDynamicSimulationDistance 2500;
onMapSingleClick "_shift";	// Disable Map Clicking
f_var_AuthorUID = '76561197970695190'; // Allows GUID to access Admin/Zeus features in MP.
[nil, 2] execVM "f\casualtiesCap\f_CasualtiesCapCheck.sqf";
[] execVM "f\mapClickTeleport\f_mapClickTeleportAction.sqf";						// Use Defaults (Teleport Group, Leaders Only, Land Teleport)
[] execVM "scripts\z_ambientUnits.sqf";	// Ambient Infantry
// Hardcore Settings:
FAR_var_DeathMessages = false; // Disable TK Messages
f_var_ShowFTMarkers = false; // Disable FT Markers
f_param_fastTravel = 1; // Enable Fast Travel
[] spawn { sleep 1; f_param_groupMarkers = 0; setGroupIconsVisible [false, false]; tao_foldmap_isOpen = true; ZEU_tkLog_mpKilledEH = {}; if (player != leader player) then { player unlinkItem "itemMap"; }; };