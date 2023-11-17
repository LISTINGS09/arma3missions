// MISSION VARAIBLES
player addRating 100000;
[player, "NoVoice"] remoteExec ["setSpeaker", -2, format["NoVoice_%1", netId player]]; // No player voice
showSubtitles false; // No radio calls
"Group" setDynamicSimulationDistance 1200;
"Vehicle" setDynamicSimulationDistance 2500;
//enableEngineArtillery false; 	// Disable Artillery Computer
//onMapSingleClick "_shift";	// Disable Map Clicking
f_var_AuthorUID = '76561197970695190'; // Allows GUID to access Admin/Zeus features in MP.
//f_var_fogOverride = [[0,0,0],[0.1,0.005,100],[0.1,0.04,100],[0.1,random 0.02,100]]; // Override default fog settings [[none],[Light],[heavy],[rand]].
//[] spawn {sleep 1; tao_foldmap_isOpen = true;}; // Disable TAO Folding Map
//[] spawn {sleep 5; ZEU_tkLog_mpKilledEH = {};}; // Disable Zeus TK Spam
// ====================================================================================
// F3 - Casualty Cap - Sides: west | east | resistance - Format: [SIDE,ENDING,<PERCENT>]
[nil, 2] execVM "f\casualtiesCap\f_CasualtiesCapCheck.sqf";

if hasInterface then {
	DROP_PLANE addAction [
		"Jump Out (Parachute)",  
		{
			params ["_target", "_caller", "_actionId", "_arguments"];

			if (position _caller#2 < 100) exitWith { systemChat format["Not high enough (%1m)", round (position _caller#2)] };

			_bp = backpack _caller;
			_bpi = backPackItems _caller;
			removeBackpackGlobal _caller;
			waitUntil { backpack _caller == "" };
			moveOut _caller;
			ace_map_mapShake = true;
			"dynamicBlur" ppEffectEnable true;
			"dynamicBlur" ppEffectAdjust [6];
			"dynamicBlur" ppEffectCommit 0; 
			"dynamicBlur" ppEffectAdjust [0.0];
			"dynamicBlur" ppEffectCommit 5;
			_caller addBackpackGlobal "B_parachute";
			waitUntil {sleep 0.1; (position _caller select 2) < 125 };
			if (vehicle _caller isEqualto _caller && alive _caller) then { _caller action ["openParachute", _caller] };
			waitUntil {sleep 0.1; isTouchingGround _caller || (position _caller#2) < 1 };
			_caller action ["eject", vehicle _caller];
			ace_map_mapShake = false;
			removeBackpackGlobal _caller;
			if (_bp == "") exitWith {};
			waitUntil { backpack _caller == "" };
			_caller addBackpackGlobal _bp;
			waitUntil { backpack _caller != "" };
			{ (unitBackpack _caller) addItemCargoGlobal [_x, 1] } forEach _bpi;
		},
		[],
		1.5, 
		false, 
		true, 
		"",
		"_this in crew _target && _this != driver _target"
	];
};