/****************************************************************
File: UPSMON_Rearm.sqf
Author: Azroul13

Description:
	
Parameter(s):
	<--- Array of units
Returns:
	Array of units
****************************************************************/

private ["_unit","_magsneeded","_supplylist","_supplies","_supply","_ammo","_points","_ammoclass","_array","_list","_containers"];

_unit = _this select 0;
_magsneeded = _this select 1;
_supplylist = [];

if (!(_unit getVariable ["UPSMON_Rearming",false])) then
{
	if (canMove _unit) then
	{
		if (unitready _unit) then
		{
			if (IsNull(assignedTarget _unit) || (getposATL (assignedTarget _unit)) vectordistance (getposATL _unit) > 300) then
			{
				if (_unit getVariable ["UPSMON_SUPSTATUS",""] == "") then
				{
					if (vehicle _unit == _unit) then
					{
						_supplies = (getposATL _unit) nearSupplies 50;
						
						{
							if (!(_x getVariable ["UPSMON_Supplyuse",false])) then
							{
								_supply = _x;
								_ammo = [];
								if (_supply != _unit) then
								{
									if (_supply isKindOf "MAN") then
									{
										if (alive _supply) then
										{
											if (side _supply == side _unit) then
											{
												_ammo = (getMagazineCargo backpackContainer _supply) select 0;
											};
										}
										else
										{
											_containers = [];
											_containers pushBack (backpackContainer _supply);
											_containers pushBack (vestContainer _supply);
											_containers pushBack (uniformContainer _supply);
											{
												_ammo = [_ammo, (getMagazineCargo _x) select 0] call BIS_fnc_arrayPushStack
											} forEach _containers;
										};
									}
									else
									{
										if (_supply isKindOf "CAR" || _supply isKindOf "TANK" || _supply isKindOf "AIR") then
										{
											if ((IsNull (driver _supply)) || !alive (driver _supply) || (side (driver _supply) == side _unit)) then
											{
												_ammo = (getMagazineCargo _supply) select 0;
											};
										}
										else
										{
											_ammo = (getMagazineCargo _supply) select 0;
										};
									};
								};
							
								if (count _ammo > 0) then
								{
									_points = 0;
									_ammoclass = [];							
									if ({_x in (_magsneeded select 0)} count _ammo > 0) then
									{
										{
											if (_x in (_magsneeded select 0)) then
											{
												if (_unit canAdd _x) then
												{
													_ammoclass pushBack _x;
												};
											};
										} forEach _ammo;
										_points = _points + 100;
									};
								
									if ({_x in (_magsneeded select 1)} count _ammo > 0) then
									{
										{
											if (_x in (_magsneeded select 1)) then
											{
												if (_unit canAdd _x) then
												{
													_ammoclass pushBack _x;
												};
											};
										} forEach _ammo;
										_points = _points + 50;
									};								
								
									_supplylist pushBack [_supply,_ammoclass,_points];
								};
							};
						} forEach _supplies;
						
						if (count _supplylist > 0) then
						{
							_list = [_supplylist, [], {_x select 2}, "DESCEND"] call BIS_fnc_sortBy;
							_array = _list select 0;
							_array resize 2;
							[_unit,_array] spawn UPSMON_DoRearm;
						};
					};
				};
			};
		};
	};
};