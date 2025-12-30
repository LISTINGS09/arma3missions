params ["_unit", "_corpse"];


_unit setpos getpos _corpse; 
[false] call ATR_fnc_InitPlayer;
[_unit,_corpse] call ATR_FNC_copyGear;
[_unit,true] call ATR_FNC_Unconscious;

deleteVehicle _corpse;
