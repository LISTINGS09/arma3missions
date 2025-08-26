/****************************************************************
File: UPSMON_GetTransport.sqf
Author: Azroul13

Description:
	Search for a valid patrol position.

Parameter(s):
	<--- group
Returns:
	Transport group
****************************************************************/
private ["_grp","_leader","_side","_supplyneeded","_supplyarray","_supplyselected","_supplygrp","_assignedvehicles","_cargonumber"];
	
_grp = _this select 0;
_supplyneeded = _grp getVariable ["UPSMON_Supplyneeded",[]];
_leader = leader _grp;
_side = side _grp;

_supplyarray = (call (compile format ["UPSMON_SUPPLY_%1_UNITS",side _grp])) - [_grp];
_supplyselected = [];
_supplygrp = ObjNull;


{
	if (!IsNull _x) then
	{
		_group = _x;
		if (({alive _x} count units _group) > 0) then
		{
			if (((_grp getVariable ["UPSMON_Transportmission",[]]) select 0) == "WAITING" || ((_grp getVariable ["UPSMON_Transportmission",[]]) select 0) == "RETURNBASE" || ((_grp getVariable ["UPSMON_Transportmission",[]]) select 0) == "LANDBASE") then
			{
				_assignedvehicles = [];
				_cargonumber = 0;
				{
					if (alive _x) then
					{
						if (canMove _x) then
						{
							if (vehicle _x != _x) then
							{
								_support =  tolower gettext (configFile >> "CfgVehicles" >> typeOf _vehicle >> "vehicleClass");
								if (_support == "Support") then
								{
									if (!((vehicle _x) in _assignedvehicles)) then
									{
										_repair = getnumber (configFile >> "cfgVehicles" >> typeOf (_vehicle) >> "transportRepair");
										_fuel = getnumber (configFile >> "cfgVehicles" >> typeOf (_vehicle) >> "transportFuel");
										_munsupply = getnumber (configFile >> "cfgVehicles" >> typeOf (_vehicle) >> "attendant");
										
										if ("repair" in _supplyneeded) then
										{
											if (_repair > 0) then
											{
												_points = _points + _repair;
											};
										};
										
										if ("fuel" in _supplyneeded) then
										{
											if (_fuel > 0) then
											{
												_points = _points + _fuel;
											};
										};

										if ("munition" in _supplyneeded) then
										{
											if (_munsupply > 0) then
											{
												_points = _points + _munsupply;
											};
										};
										
										_supplyselected pushBack [_group,_points];
									};
								};
							};
						};
					};
				} forEach units _group;
			};
		};
	};
} forEach _supplyarray;

if (count _supplyselected > 0) then
{
	_supplyselected = [_supplyselected, [], {_x select 1}, "DESCEND"] call BIS_fnc_sortBy;
	_supplygrp = (_supplyselected select 0) select 0;
};

_supplygrp