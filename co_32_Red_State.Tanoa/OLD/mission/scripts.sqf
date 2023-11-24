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
f_var_fogOverride = [[0,0,0],[0.1,0.005,100],[0.1,0.04,100],[0.1,random 0.02,100]]; // Override default fog settings [[none],[Light],[heavy],[rand]].
[east,2] execVM "f\casualtiesCap\f_CasualtiesCapCheck.sqf";
[] execVM "scripts\civPopulation.sqf";									// Civ Spawner
f_param_radioMode = 1; // radios.sqf lists allowed unit types
// ====================================================================================
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