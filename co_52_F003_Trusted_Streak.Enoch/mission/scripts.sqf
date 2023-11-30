// MISSION VARAIBLES
player addRating 100000;
[player, "NoVoice"] remoteExec ["setSpeaker", -2, format["NoVoice_%1", netId player]]; // No player voice
showSubtitles false; // No radio calls
"Group" setDynamicSimulationDistance 800;
enableEngineArtillery false; 	// Disable Artillery Computer
//onMapSingleClick "_shift";	// Disable Map Clicking
f_param_groupMarkers = 3; 		// 0 = Disable, 1 = On Map, 2 = On Map + Screen, 3 = Map + Squad Stats, 4 = Commander Map Only, 5 = Commander Map + Squad Stats
f_param_thirdPerson = 0; 		// 0 = Disable, 1 = In Vehicles Only, 2 = Not Allowed (TvT)
f_param_jipTeleport = 3; 		// 0 = Disable, 1 = AddAction Only, 2 = FlagPole Only, 3 = Both
f_var_AuthorUID = '76561197970695190'; // Allows GUID to access Admin/Zeus features in MP.
[resistance,2] execVM "f\casualtiesCap\f_CasualtiesCapCheck.sqf";
f_param_radioMode = 1; // radios.sqf lists allowed unit types
f_radios_backpack = "B_RadioBag_01_eaf_F";
// Remove Enemy weapons on death
if isServer then {
	addMissionEventHandler ["EntityKilled", {
		params ["_unit"];
		if (_unit isKindOf "CAManBase" && !(isPlayer _unit)) then {
				_unit removeWeapon (primaryWeapon _unit); 
				_unit removeWeapon (secondaryWeapon _unit);
		};
	}];
};
// Vehicle View Distances
[] spawn {
	sleep 1;
	switch (player getVariable ["f_var_assignGear","r"]) do {
		case "pp"; case "pc"; case "pcc": { setViewDistance 5000; systemChat "View Distance Increased (Air) - Check Settings" };
		case "vc"; case "vd"; case "vg"; case "uav": { setViewDistance 3000; systemChat "View Distance Increased (Vehicle) - Check Settings" };
	};
};