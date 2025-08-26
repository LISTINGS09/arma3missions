private ["_units","_unitsout"];
params ["_grp","_typeOfgrp","_targetpos","_dist","_traveldist","_assignedvehicle","_gothit","_speedmode","_behaviour"];

_units = units _grp;
_unitsout = [];
{
	if (alive _x) then 
	{
		if (canMove _x) then
		{
			if (vehicle _x == _x) then
			{
				_unitsout pushBack _x;
			};
		};
	};
} forEach _units;

if (UPSMON_Debug > 0) then {diag_log format ["UPSMON: Embarkment - Group:%5 Outcargo:%1 Dist:%2 Gothit:%3 targetDist:%4",count _unitsout,_dist > 800,_gothit,_traveldist >= UPSMON_searchVehicledist,groupID _grp]};
if (count _unitsout > 0) then
{
	if ("car" in _typeOfgrp || "tank" in _typeOfgrp) then
	{
		{
			if (alive _x) then
			{
				if (Speed _x > 5) then
				{
					_x forceSpeed 5.5;
				};
			};
		} forEach _assignedvehicle;
	};
	
	if (_dist > 800 && _gothit == "") then 
	{
		if (_targetpos select 0 != 0 && _targetpos select 1 != 0) then
		{
			if (_traveldist >= UPSMON_searchVehicledist) then
			{
				if (count _assignedvehicle == 0 && count (_grp getVariable ["UPSMON_Lastassignedvehicle",[]]) == 0) then
				{
					if (_grp getVariable ["UPSMON_NOVEH",0] == 0) then 
					{
						if (!("tank" in _typeOfgrp) && !("armed" in _typeOfgrp) && !("apc" in _typeOfgrp) && !("air" in _typeOfgrp)) then
						{
							[_grp,_targetpos,_speedmode,_behaviour] spawn UPSMON_DOfindvehicle;
						};
					};
				}
				else
				{
					if ("infantry" in _typeOfgrp) then
					{
						if (count _assignedvehicle == 0) then
						{
							//_assignedvehicle = _grp getVariable ["UPSMON_Lastassignedvehicle",[]];
						};
						if (count _assignedvehicle > 0) then
						{
							[_grp,_assignedvehicle,_targetpos] spawn UPSMON_getinassignedveh;
						};
					};
				};
			};
		};
	}
	else
	{
		if (_grp getVariable ["UPSMON_NOVEH",0] < 2) then
		{
			[_grp] spawn UPSMON_DOfindCombatvehicle;
		};
	};
};