params[["_init",true]];

player removeAllEventHandlers "HandleDamage";
player removeAllEventHandlers "Killed";

if(isNil("AT_Revive_WeaponsOnRespawn")) then {
	AT_Revive_WeaponsOnRespawn = true;
};

player addEventHandler ["HandleDamage", ATR_FNC_HandleDamage];


player setVariable ["AT_Revive_isUnconscious", false, true];
player setVariable ["AT_Revive_isDragged", objNull, true];
player setVariable ["AT_Revive_isDragging", objNull, true];
player setVariable ["AT_Revive_isCarrying", objNull, true];
player setCaptive false;

[] spawn ATR_FNC_Actions;


if(!_init) then {

	
	if(count(AT_Revive_StaticRespawns)>0) then {
		player setpos getpos (AT_Revive_StaticRespawns select 0);
	};
	if(AT_Revive_Camera==1) then {
		[] spawn ATHSC_fnc_createCam;
	};		
};