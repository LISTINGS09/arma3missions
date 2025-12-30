if !hasInterface exitWith {};
if (!isDedicated && (isNull player)) then {waitUntil {sleep 0.1; !isNull player};};

diag_log format["[ESCAPE]: %1 initClient", name player];

call A3E_FNC_Briefing;

sleep 0.5;

[player] remoteExec ["a3e_fnc_initPlayer", 2];
diag_log format["[ESCAPE]: %1 initPlayer (function)", name player];

[] spawn {
	disableSerialization;
	waitUntil {!isNull(findDisplay 46)};
	(findDisplay 46) displayaddEventHandler ["keyDown", "_this call a3e_fnc_KeyDown"];
};

AT_Revive_StaticRespawns = [];
AT_Revive_enableRespawn = false;
AT_Revive_clearedDistance = 0;
AT_Revive_Camera = 1;

[] call A3E_fnc_addUserActions;

//BIS
player enableStamina false;
player enableFatigue false;
player setCustomAimCoef 0;
player setUnitTrait ["medic", true];
player setUnitTrait ["engineer", true];
[player, "NoVoice"] remoteExec ["setSpeaker", -2, player]; // No player voice
showSubtitles false; // No radio calls
onMapSingleClick "_shift";	// Disable Map Clicking
removeAllAssignedItems player;
removeAllWeapons player;
removeAllItems player;
removeBackpack player;
removeVest player;
removeHeadgear player;
removeGoggles player;

player addEventHandler["HandleRating","_this call A3E_FNC_handleRating;"];
player addEventHandler["InventoryClosed","_this call A3E_FNC_collectIntel;"];

drn_fnc_Escape_DisableLeaderSetWaypoints = {
	if (!visibleMap) exitWith {};
	{ player groupSelectUnit [_x, false] } forEach units group player;
};

waitUntil{sleep 0.1;!isNil("A3E_ParamsParsed")};
AT_Revive_Camera = A3E_Param_ReviveView;

//If no ACE use ATR revive
if (isClass(configFile >> "CfgPatches" >> "ACE_Medical")) then {
	player setVariable ["ACE_Revive_isUnconscious", false, true];
} else {
	call ATR_FNC_ReviveInit;
};

setTerrainGrid A3E_Param_Grass;

if (A3E_Param_Magrepack == 1) then { [] execVM "Scripts\outlw_magRepack\MagRepack_init_sv.sqf" };

[] spawn {
	disableSerialization;
	waitUntil {!isNull(findDisplay 46)};
	(findDisplay 46) displayaddEventHandler ["keyDown", "_this call a3e_fnc_KeyDown"];
};

diag_log format["[ESCAPE]: %1 Initialized (Local)", name player];
player setVariable["A3E_PlayerInitializedLocal", true, true];

waitUntil{sleep 0.1;(player getVariable["A3E_PlayerInitializedServer",false])};

diag_log format["[ESCAPE]: %1 Ready (Local)", name player];

[] spawn {
	waitUntil{sleep 0.5;!isNil("A3E_EscapeHasStarted")};

	//Player needs to be taken out of captivity if they rejoin
	if (isClass(configFile >> "CfgPatches" >> "ACE_Medical")) then { player setCaptive false };

	//Message delayed to make sure ACE_MedicalServer is broadcasted
	if ((isClass(configFile >> "CfgPatches" >> "ACE_Medical")) && !(ACE_MedicalServer)) then {systemChat "Player is running ACE on unsupported server! Please deactivate or gameplay could be servilely affected.";};
	if (!(isClass(configFile >> "CfgPatches" >> "ACE_Medical")) && (ACE_MedicalServer)) then {systemChat "Server is running ACE! Please install the compatible version and reconnect to prevent gamebreaking issues.";};
};

[] spawn {
	waitUntil{sleep 0.5;A3E_Task_Prison_Complete};
	[localize "STR_A3E_initLocalPlayer_somewhereOn", A3E_WorldName , str (date select 2) + "/" + str (date select 1) + "/" + str (date select 0) + " " + str (date select 3) + ":00"] spawn BIS_fnc_infoText;
};

if(!isNil("CBA_fnc_addKeybind")) then {
	[] spawn {
		disableSerialization;
		["A3E Earplugs", "toggle_earplugs_key", localize "STR_A3E_initLocalPlayer_toggleEarplugs", {_this call A3E_fnc_toggleEarplugs}, ""] call CBA_fnc_addKeybind;
	};
};