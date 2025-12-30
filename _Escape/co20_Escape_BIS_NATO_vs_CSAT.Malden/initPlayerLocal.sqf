[] spawn {
	titleText [localize "STR_A3E_initLocalPlayer_Loading", "BLACK",0.1];
	[] spawn a3e_fnc_initLocalPlayer;
	sleep 2;
	titleFadeOut 2.0;
	f_sqf_earp = execVM "f\earplug\f_earplugs.sqf";
};