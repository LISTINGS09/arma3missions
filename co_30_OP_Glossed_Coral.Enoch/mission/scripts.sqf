// MISSION VARAIBLES
player addRating 100000;
[player, "NoVoice"] remoteExec ["setSpeaker", 0, format["NoVoice_%1", netId player]]; // No player voice
showSubtitles false; // No radio calls
"Group" setDynamicSimulationDistance 1200;
"Vehicle" setDynamicSimulationDistance 2500;
onMapSingleClick "_shift";	// Disable Map Clicking
f_var_AuthorUID = '76561197970695190'; // Allows GUID to access Admin/Zeus features in MP.
[nil, 2] execVM "f\casualtiesCap\f_CasualtiesCapCheck.sqf";
[] execVM "scripts\z_ambientUnits.sqf";	// Ambient Infantry
DAC_Basic_Value = 0; execVM "scripts\DAC\DAC_Config_Creator.sqf";		
[TR_AREA] execVM "scripts\z_colorGrid.sqf";	