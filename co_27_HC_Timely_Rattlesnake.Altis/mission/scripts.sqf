// MISSION VARAIBLES
player addRating 100000;
[player, "NoVoice"] remoteExec ["setSpeaker", -2, format["NoVoice_%1", netId player]]; // No player voice
showSubtitles false; // No radio calls
"Group" setDynamicSimulationDistance 1200;
"Vehicle" setDynamicSimulationDistance 2500;
f_var_AuthorUID = '76561197970695190'; // Allows GUID to access Admin/Zeus features in MP.
[nil, 2] execVM "f\casualtiesCap\f_CasualtiesCapCheck.sqf";

// Hardcore Settings:
FAR_var_InstantDeath = true; // Instant Death
FAR_var_DeathMessages = false; // Disable TK Messages
f_var_ShowFTMarkers = false; // Disable FT Markers
f_param_fastTravel = 1;
f_param_groupMarkers = 0;
[] spawn { sleep 1; ZEU_tkLog_mpKilledEH = {}; };
if (missionNamespace getVariable ["f_param_ZMMDiff", 0] >= 1) then {  _nul = [] execVM "scripts\z_ambientUnits.sqf" };