// MISSION VARAIBLES
player addRating 100000;
[player, "NoVoice"] remoteExec ["setSpeaker", -2, format["NoVoice_%1", netId player]]; // No player voice
showSubtitles false; // No radio calls
"Group" setDynamicSimulationDistance 1200;
"Vehicle" setDynamicSimulationDistance 2500;
f_var_AuthorUID = '76561197970695190'; // Allows GUID to access Admin/Zeus features in MP.
[nil, 2] execVM "f\casualtiesCap\f_CasualtiesCapCheck.sqf";
[1,900,true,["UnitAAF_IFV1_VC","UnitAAF_IFV2_VC"]] execVM "f\mapClickTeleport\f_mapClickTeleportAction.sqf";
[] execVM "scripts\civPopulation.sqf";									// Civ Spawner