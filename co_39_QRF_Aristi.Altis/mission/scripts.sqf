// MISSION VARAIBLES
player addRating 100000;
[player, "NoVoice"] remoteExec ["setSpeaker", -2, format["NoVoice_%1", netId player]]; // No player voice
showSubtitles false; // No radio calls
"Group" setDynamicSimulationDistance 1200;
"Vehicle" setDynamicSimulationDistance 2500;
onMapSingleClick "_shift";	// Disable Map Clicking
f_var_AuthorUID = '76561197970695190'; // Allows GUID to access Admin/Zeus features in MP.

[nil, 2] execVM "f\casualtiesCap\f_CasualtiesCapCheck.sqf";

f_param_viewDistance = false;
f_var_fogOverride = [[0,0,0],[0.21, 0.13, 80],[0.21, 0.13, 80],[0.21, 0.13, 80]];
setViewDistance 500;
setObjectViewDistance 580;
setTerrainGrid 45;

0 = [getMarkerpos "ao", 340, 420, "ColorEast"] execVM "scripts\AreaMarker.sqf";
0 = [getMarkerpos "path", 150, 150, "ColorEast"] execVM "scripts\AreaMarker.sqf";

if (hasInterface) then { execVM "scripts\Loadout_player.sqf"; 
	player addEventHandler ["respawn",{execVM "scripts\Loadout_player.sqf"}];
};