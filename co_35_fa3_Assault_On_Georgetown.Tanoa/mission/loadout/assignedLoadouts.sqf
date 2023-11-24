// Either use (_faction in ["blu_f"]) or (side == "west") etc...
// Note - Always lower case!
if(_side == "guer" || _side == "inf_c_f") then {
	#include "f_loadout_a3_guer_syndikat.sqf"
};
if(_side == "nato") then {
	#include "f_loadout_a3_west_gendarmerie.sqf"
};
