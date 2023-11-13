// MISSION VARAIBLES
player addRating 100000;
[player, "NoVoice"] remoteExec ["setSpeaker", -2, format["NoVoice_%1", netId player]]; // No player voice
showSubtitles false; // No radio calls
"Group" setDynamicSimulationDistance 1200;
"Vehicle" setDynamicSimulationDistance 2500;
f_var_AuthorUID = '76561197970695190'; // Allows GUID to access Admin/Zeus features in MP.
[nil, 2] execVM "f\casualtiesCap\f_CasualtiesCapCheck.sqf";
[1,900,true,["UnitNATO_IFV1_VC","UnitNATO_IFV2_VC","UnitNATO_REC_SN","UnitNATO_MTR_SL"]] execVM "f\mapClickTeleport\f_mapClickTeleportAction.sqf"; 					// Use Defaults (Land Teleport, Leaders Only)
