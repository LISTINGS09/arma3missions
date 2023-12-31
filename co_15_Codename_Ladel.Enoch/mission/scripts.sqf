// MISSION VARAIBLES
player addRating 100000;
[player, "NoVoice"] remoteExec ["setSpeaker", 0, format["NoVoice_%1", netId player]]; // No player voice
showSubtitles false; // No radio calls
"Group" setDynamicSimulationDistance 1200;
"Vehicle" setDynamicSimulationDistance 2500;
onMapSingleClick "_shift";	// Disable Map Clicking
f_var_AuthorUID = '76561197970695190'; // Allows GUID to access Admin/Zeus features in MP.
[nil, 2] execVM "f\casualtiesCap\f_CasualtiesCapCheck.sqf";
[] execVM "f\mapClickTeleport\f_mapClickTeleportAction.sqf";						// Use Defaults (Teleport Group, Leaders Only, Land Teleport)
[] execVM "scripts\z_ambientUnits.sqf";	// Ambient Infantry
if hasInterface then {
	player setCustomAimCoef 0;
	player enableStamina false;
	player enableFatigue false;
};