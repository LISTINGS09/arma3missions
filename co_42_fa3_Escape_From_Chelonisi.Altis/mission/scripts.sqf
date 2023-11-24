// MISSION VARAIBLES
player addRating 100000;
[player, "NoVoice"] remoteExec ["setSpeaker", -2, format["NoVoice_%1", netId player]]; // No player voice
showSubtitles false; // No radio calls
"Group" setDynamicSimulationDistance 1200;
"Vehicle" setDynamicSimulationDistance 2500;
//enableEngineArtillery false; 	// Disable Artillery Computer
//onMapSingleClick "_shift";	// Disable Map Clicking
//setApertureNew [1.5, 8, 14, 1]; // Less Dark Night
f_var_AuthorUID = '76561197970695190'; // Allows GUID to access Admin/Zeus features in MP.
//f_var_fogOverride = [[0,0,0],[0.1,0.005,100],[0.9,0.0155,0],[0.1,random 0.02,100]]; // Override default fog settings [[none],[Light],[heavy],[rand]].
// ====================================================================================
// F3 - Casualty Cap - Sides: west | east | resistance - Format: [SIDE,ENDING,<PERCENT>]
[nil, 2] execVM "f\casualtiesCap\f_CasualtiesCapCheck.sqf";
// ====================================================================================
ws_game_a3 = false;
[] execVM "ws_fnc\ws_fnc_init.sqf";
waitUntil {!isNil "ws_fnc_compiled"};
ws_game_a3 = true;

if (hasInterface) then {
    [] spawn {
        sleep 5;
        playMusic "LeadTrack02a_F_EPB";
    };
};

if (isServer) then {
	[] spawn {
		sleep .1;
		if (isNil "prisoners") then {prisoners = [];};
		_possibleGunmen = prisoners;
		for "_i" from 1 to 10 do {
			if (count _possibleGunmen > 0) then {
				_gunman = _possibleGunmen call BIS_fnc_selectRandom;
				[_gunman,["Pull out pistol",{
					_this select 0 addMagazines ["11Rnd_45ACP_Mag",1];
					_this select 0 addWeapon "hgun_Pistol_heavy_01_F";
					_this select 0 addMagazines ["11Rnd_45ACP_Mag",3];
					_this select 0 removeAction (_this select 2);
					_this select 0 setCaptive false;
				},nil,6,true,true,"","_this == _target"]] remoteExec ["addAction"];
				_possibleGunmen = _possibleGunmen - [_gunman];
			};
		};

		lockdown = false;
		loudspeaker1 spawn {
			waitUntil {lockdown};
			sleep 30;
			for "_i" from 1 to 150 do {
				if (alive _this) then {
					playSound3d ["A3\Sounds_F\sfx\siren.wss",_this,false,_this modelToWorld [0,0,10],3];
					sleep 2;
				};
			};
		};

		[] spawn {
			_missionComplete = false;
			while {!_missionComplete} do {
				if ({alive _x} count prisoners < .25 * count prisoners || {alive _x} count prisoners == 0) then {
					_missionComplete = true;
					["HQ","The Prisoners were not rescued - Mission Failed!"] remoteExec ["BIS_fnc_showSubtitle"];
				};
				if (!_missionComplete && {_x distance getMarkerPos "prisoncenter" < 1500} count playableUnits == 0) then {
					_missionComplete = true;
					["HQ","The Prisoners were rescued - Well Done!"] remoteExec ["BIS_fnc_showSubtitle"];
				};
				sleep 5;
			};
		};
	};
};

[] execVM "ws_garrisonControl.sqf";
