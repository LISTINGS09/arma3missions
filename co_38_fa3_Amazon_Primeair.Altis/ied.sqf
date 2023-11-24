 _this addEventHandler ["RopeBreak",{
	if (["bomb", format ["%1", _this select 2], false] call bis_fnc_inString) then {
		_this select 2 spawn {
			playSound3D ["A3\sounds_f\sfx\beep_target.wss", _this];
			for "_i" from 1 to 10 do {
				sleep 1;
				playSound3D ["A3\missions_f\data\sounds\click.wss", _this];
			};
			"HelicopterExploBig" createVehicle position (_this);
			if (getPos _this select 2 < 10) then {
				"Bo_Mk82" createVehicle position (_this);
			};
			deleteVehicle (_this);
		};
	};
}];

/*	 player addAction ["Set Timer (30 seconds)", 
	 {
		playSound3D ["A3\sounds_f\sfx\beep_target.wss", _this select 3];
		for "_i" from 1 to 30 do {
			sleep 1;
			playSound3D ["A3\missions_f\data\sounds\click.wss", _this select 3];
		};
		"Bo_GBU12_LGB_MI10" createVehicle position (_this select 3);
		deleteVehicle (_this select 3); 
	}, this select 2];*/