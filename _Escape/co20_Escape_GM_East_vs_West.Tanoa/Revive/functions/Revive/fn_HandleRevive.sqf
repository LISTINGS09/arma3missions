private _params = param[3];
private _target = cursortarget;
private _fakUsed = _params param [1,false];
if(!isnull _target) then {
	if (alive _target) then
	{
		_target setVariable ["AT_Revive_isDragged", player, true];
		
		switch (true) do
		{
		case ((currentweapon player == "") and (stance player != "PRONE")): {player playmove "AinvPknlMstpSlayWnonDnon_medicOther";};  
		case ((currentweapon player == "") and (stance player == "PRONE")): {player playmove "AinvPpneMstpSlayWnonDnon_medicOther";}; // these first two lines have to be before the others otherwise reviving with no weapons in hand or on player results in pulling out invisible rifle and standing up after revive
		case ((currentweapon player == (primaryweapon player)) and (stance player != "PRONE")): {player playmove "AinvPknlMstpSlayWrflDnon_medicOther";};
		case ((currentweapon player == (secondaryweapon player)) and (stance player != "PRONE")): {player playmove "AinvPknlMstpSlayWlnrDnon_medicOther";};
		case ((currentweapon player == (handgunweapon player)) and (stance player != "PRONE")): {player playmove "AinvPknlMstpSlayWpstDnon_medicOther";};
		case ((currentweapon player == (primaryweapon player)) and (stance player == "PRONE")): {player playmove "AinvPpneMstpSlayWrflDnon_medicOther";};
		case ((currentweapon player == (handgunweapon player)) and (stance player == "PRONE")): {player playmove "AinvPpneMstpSlayWpstDnon_medicOther";};
		case ((currentweapon player == binocular player) and (stance player != "PRONE")): {player playmove "AinvPknlMstpSlayWnonDnon_medicOther";};
		case ((currentweapon player == binocular player) and (stance player == "PRONE")): {player playmove "AinvPpneMstpSlayWnonDnon_medicOther";};
	 	};	
	};
		disableUserInput true;
		sleep 0.1;
		disableUserInput false;
		disableUserInput true;
        disableUserInput false;
		sleep 5.9;
		_target setVariable ["AT_Revive_isDragged", objNull, true];
		
		if(!(player getVariable ["AT_Revive_isUnconscious",false])) then {
			_target setVariable ["AT_Revive_isUnconscious", false, true];
			[_target,"AmovPpneMstpSnonWnonDnon"] remoteExec ["switchmove", 0, false]; //Changing this to "AmovPpneMstpSnonWnonDnon" fixes issue where you switch to primary then your previous weapon when you had a different weapon out initially when not pulling out of a car, but causes roll on back animation to break when pulling out of a a vehicle, so the player looks like they are just prone with no weapon equipped. Changing it from "playmove" to "switch move" fixes that issue. It does make the revive animation look a bit more janky since it snap switches instead of transitions but is worth the tradeoff in order for the player to appear dead outside of a vehicle which I believe is more important than the rolling animation.  This could be fixed if Bohemia fixes the bug with the "AinjPpneMstpSnonWnonDnon" animation and I would be able to keep the rolling on stomach animation.
			
			//if(AT_Revive_Camera==1) then {
			//	[] remoteExec ["ATHSC_fnc_exit", _target, false];
			//};
		};
		
		
		//Fix revive underwater
		if(surfaceIsWater (getpos _target)) then {
			[_target,""] remoteExec ["switchmove", 0, false];
			[player,""] remoteExec ["switchmove", 0, false];
		};
		
		private _attendant = [(configfile >> "CfgVehicles" >> typeof player),"attendant",0] call BIS_fnc_returnConfigEntry; 
		private _medkits = missionNamespace getvariable ["a3e_arr_medkits",["Medikit"]];
		private _faks = missionNamespace getvariable ["a3e_arr_faks",["FirstAidKit"]];
		if(_attendant == 1 && (items player findIf {_x in _medkits} > -1)) then {
			_target setDamage 0;
		} else {
			if(_fakUsed) then {
				private _items = items player;
				private _itemIndex = _items findIf {_x in _faks};
				if(_itemIndex > -1) then {
					player removeitem (_items select _itemIndex);
					_target setdamage 0;
				} else {
					//No FAK in player inventory Check the other guy
					_items = items _target;
					_itemIndex = _items findIf {_x in _faks};
					if(_itemIndex > -1) then {
						_target removeitem (_items select _itemIndex);
						_target setdamage 0;
					} else {
						//Nobody has a FAK? What is going on?!?
						_target setDamage (random 0.3)+0.1;
					};
				};
			} else {
				_target setDamage (random 0.3)+0.1;
			};
		};
} else {
	systemchat "Target is null";
};