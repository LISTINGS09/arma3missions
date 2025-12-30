if(count(missionNameSpace getVariable ["A3E_Trap_Classes",[]])>0) then {
	missionNameSpace setVariable ["A3E_Traps",[]];
	["A3E_fnc_updateTraps","call",5,false] call A3E_fnc_Chronos_Register;
};