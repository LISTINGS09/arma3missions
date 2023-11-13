// Full Credits: Please see the F3 online manual (http://www.ferstaberinde.com/f3/en/)
// *** Do NOT edit this file! If you need to add something, add it in "mission\scripts.sqf" - It'll still run here! ***
waitUntil { isServer || !isNull player };
f_var_version = "3.44";
// ====================================================================================
// MISSION SPECIFIC SCRIPTS AND VARIABLES
#include "mission\scripts.sqf";
// ====================================================================================
// SHARED SCRIPTS - Both client and server
f_sqf_safe = execVM "f\safeStart\f_safeStart.sqf"; 	// F3 - Safe Start
// ====================================================================================
// SERVER ONLY SCRIPTS!
if isServer then {
	execVM "f\setGroupID\f_setGroupIDs.sqf";			// F3 - Group IDs
	execVM "f\misc\f_stayInVehicle.sqf"; 				// Zeus - Stubborn Crew
	
	// Clear DCd player bodies at start
	[] spawn {
		sleep 0.1;
		["init.sqf",format["Mission Beginning - P: %1 A: %2", count allPlayers, allPlayers select {alive _x}],"INFO"] call f_fnc_logIssue;
		{if (_x isKindOf "Man" && (_x getVariable["f_var_assignGear",""] != "")) then {deleteVehicle _x}} forEach allDead;
	};
	
	// Performance Counter / Debug
	[] spawn {
		sleep 1;
		execVM "f\misc\f_debug.sqf";
		waitUntil {
			sleep 30;
			diag_log text format ["[F3] PERFORMANCE --- %5 --- Time: %1 --- Server FPS: %2 Min: %3 --- Players: %4",[(round time)] call BIS_fnc_secondsToString, round (diag_fps), round (diag_fpsmin), count allPlayers, missionName];
			!isNil "f_var_stopLogging";
		};
	};
	missionNamespace setVariable ["f_var_missionLoaded", true, true];
	["init.sqf","Mission Loaded","INFO"] call f_fnc_logIssue;
};
// ====================================================================================
// CLIENT ONLY SCRIPTS - Typically controlled via MISSION PARAMETERS.
if hasInterface then { 
	f_sqf_draw = execVM "f\briefing\f_drawAO.sqf";					// Draws border around AO.
	f_sqf_intro = execVM "f\common\f_clientIntro.sqf";				// Zeus - Client Intro
	f_sqf_ftmk = execVM "f\setTeamColours\f_setTeamColours.sqf";	// F3 - Team Colors
	f_sqf_grpm = execVM "f\groupMarkers\f_setLocGroupMkr.sqf";		// F3 - Group Markers
	f_sqf_third = execVM "f\thirdPerson\f_thirdPerson.sqf";			// Zeus - Third Person
	f_sqf_vas = execVM "f\misc\f_vas.sqf";							// Zeus - VAS Crate
	f_sqf_jip = execVM "f\JIP\f_teleportOption.sqf";				// Zeus - JIP Teleport Flag/Action
	f_sqf_brief = execVM "f\briefing\briefing.sqf";					// F3 - Briefing
	f_sqf_orbat = execVM "f\briefing\f_showOrbat.sqf";				// F3 - ORBAT (f_sqf_brief required)
	f_sqf_gearSel = execVM "f\briefing\f_showLoadoutSelect.sqf";	// Zeus - Gear Selection (f_sqf_orbat required)
	f_sqf_earp = execVM "f\earplug\f_earplugs.sqf";					// Zeus - Earplugs
	f_sqf_names = execVM "f\nametag\f_nametags.sqf";				// F3 - Nametags
	f_sqf_ftmrk = execVM "f\FTMemberMarkers\f_initFTMarkers.sqf";	// F3 - FT Markers
	f_sqf_skill = execVM "f\setSkill\z_setSkill.sqf";				// Zeus - Unit Skill
};