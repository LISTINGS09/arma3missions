/****************************************************************
File: UPSMON_checkleaveVehicle.sqf
Author: MONSADA

Description:
	if every on is outside, make sure driver can move
Parameter(s):
	<--- leader
	<--- vehicle
	<--- driver 
Returns:
	Nothing
****************************************************************/
private["_assignedvehicle","_vehiclesneedsupply","_fuel","_damage","_magazinescount","_weapon","_basepos","_air","_mags"];	
_assignedvehicle = _this select 0;

_vehiclesneedsupply = [];
_supplyneeded = [];

{
	if (alive _x) then
	{
		if (canMove _x) then
		{
			if (!(vehicle _x in _vehiclesneedsupply)) then
			{
				_fuel = fuel (vehicle _x);
				_damage = damage (vehicle _x);
				_magazinescount = 100;
					
				if (!IsNull (Gunner (vehicle _x))) then
				{
					_magazinescount = 0;
					_mags = magazinesAmmo (vehicle _x);
					{
						_magazinescount = _magazinescount + (_x select 1);
					} forEach _mags;
					_supplyneeded pushBack "munition";
				};
				_enoughfuel = true;
				_fuelneeded = 0.3;
					
				if ((vehicle _x) isKindOf "AIR") then
				{
					_dist = (getposATL _x) vectordistance ((_grp getVariable ["UPSMON_Origin",[]]) select 0);
					_fuelneeded = ((0.000537*_dist) / 100) + 0.0005;
					_supplyneeded pushBack "fuel";						
				};
					
				if (_damage > 0.5) then {_supplyneeded pushBack "repair";};
				if (_fuel <= _fuelneeded) then {_supplyneeded pushBack "fuel";};
					
				if (_damage > 0.5 || (_fuel <= _fuelneeded && !(vehicle _x isKindOf "STATICWEAPON")) || _magazinescount <= 2) then
				{
					_vehiclesneedsupply pushBack _x;
				};
			};
		};
	};
} forEach _assignedvehicle;

_grp setVariable ["UPSMON_Supplyneeded",_supplyneeded];

_vehiclesneedsupply;
