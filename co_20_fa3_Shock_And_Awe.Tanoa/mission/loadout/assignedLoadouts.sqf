// Either use (_faction in ["blu_f"]) or (side == "west") etc...
// Note - Always lower case!
if (_side == "west") then {
	#include "f_loadout_a3_west_ctrg_jungle.sqf"
};
if (_side == "guer" || _side == "ind_f") then {
	#include "f_loadout_a3_guer_syndikat.sqf"
};
