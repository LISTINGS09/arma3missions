player addRating 100000;
showSubtitles false; // No radio calls
enableSentences false; // Disable radio transmissions to be heard and seen on screen
"Group" setDynamicSimulationDistance 1200;
"Vehicle" setDynamicSimulationDistance 2500;
onMapSingleClick "_shift";	// Disable Map Clicking
f_var_AuthorUID = '76561197970695190'; // Allows GUID to access Admin/Zeus features in MP.
[nil, 2] execVM "f\casualtiesCap\f_CasualtiesCapCheck.sqf";
[] execVM "scripts\z_ambientUnits.sqf";	// Ambient Infantry
f_param_fastTravel = 1;
if hasInterface then {
	player setCustomAimCoef 0;
	player enableStamina false;
	player enableFatigue false;
};