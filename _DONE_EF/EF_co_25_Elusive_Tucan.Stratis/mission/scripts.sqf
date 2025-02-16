// MISSION VARAIBLES
player addRating 100000;
[player, "NoVoice"] remoteExec ["setSpeaker", -2, format["NoVoice_%1", netId player]]; // No player voice
showSubtitles false; // No radio calls
"Group" setDynamicSimulationDistance 1200;
"Vehicle" setDynamicSimulationDistance 2500;
f_var_AuthorUID = '76561197970695190'; // Allows GUID to access Admin/Zeus features in MP.
[nil, 2] execVM "f\casualtiesCap\f_CasualtiesCapCheck.sqf";
if (missionNamespace getVariable ["f_param_ZMMDiff", 0] >= 1) then {  _nul = [] execVM "scripts\z_ambientUnits.sqf" };

// Building Destroyed Counter
/*if (isServer) then { 
	addMissionEventHandler ["BuildingChanged", { 
		params ["_from", "_to", "_isRuin"];
		
		if (count (_from buildingPos -1) > 3 && _isRuin) then {
			missionNamespace setVariable ["var_BldsDest",(missionNamespace getVariable ["var_BldsDest", 0])+1, true];
			[format["Buildings Destroyed: %1", missionNamespace getVariable ["var_BldsDest", 0]]] remoteExec ["systemChat", 0];
		};
	}];
};*/