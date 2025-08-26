
private ["_bld"];
_bld = _this select 0;
_nbrdoors = round (count ((configfile >> "cfgVehicles" >> (typeOf _bld) >> "UserActions") call bis_fnc_returnchildren))/2;
sleep 20;

// BUGGED - 10-SEP-15 ERROR FINDING \A3\Structures_F\scripts\Door_close.sqf

for "_i" from 0 to _nbrdoors do 
{
	_bld animate ["door_" + str _i + "_rot",0]; //_v
	//[_bld, "door_" + str _i + "_rot", "Door_Handle_" + str _i + "_rot_1", "Door_Handle_" + str _i + "_rot_2"] execVM "\A3\Structures_F\scripts\Door_close.sqf";
};
