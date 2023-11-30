// MISSION VARAIBLES
player addRating 100000;
[player, "NoVoice"] remoteExec ["setSpeaker", -2, format["NoVoice_%1", netId player]]; // No player voice
showSubtitles false; // No radio calls
"Group" setDynamicSimulationDistance 1200;
"Vehicle" setDynamicSimulationDistance 2500;
enableEngineArtillery false; 	// Disable Artillery Computer
f_var_AuthorUID = '76561197970695190'; // Allows GUID to access Admin/Zeus features in MP.
ZCS_var_LOWTasks = false;
[nil, 2] execVM "f\casualtiesCap\f_CasualtiesCapCheck.sqf";
[] execVM "scripts\civPopulation.sqf";									// Civ Spawner
// Post-process effects
if (hasInterface) then {
	_hdl = ppEffectCreate ["colorCorrections", 1501];
	_hdl ppEffectEnable true;			
	_hdl ppEffectAdjust [0.9, 1, 0, [0.1, 0.1, 0.1, -0.1], [1, 1, 0.8, 0.328],  [1, 0.2, 0, 0]]; // Takistan
	_hdl ppEffectCommit 0;
};