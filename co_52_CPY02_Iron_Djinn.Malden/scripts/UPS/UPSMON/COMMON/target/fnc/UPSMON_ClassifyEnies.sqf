private ["_grp","_enies","_npcpos","_capacitygrp","_typeOfgrp","_list","_points","_armor"];

_grp = _this select 0;
_enies = _this select 1;

_npcpos = getposATL (leader _grp);
_capacitygrp = _grp getVariable ["UPSMON_GroupCapacity",[]];
_typeOfgrp = _grp getVariable ["UPSMON_typeOfgrp",[]];
_list = [];

{
	if (alive _x) then
	{
		_points = 0;
		
		if ([leader _grp,_x,_npcpos vectordistance ((_x getVariable "UPSMON_TargetInfo") select 0),130] call UPSMON_Haslos) then
		{
			_points = _points + 200;
		};
		
		if (vehicle _x != _x) then
		{
			if ("ship" in _typeOfgrp) then
			{
				if ((vehicle _x) isKindOf "ship") then
				{
					_points = _points + 200;
				};
			};
		
			if ("air" in _typeOfgrp || "aa1" in _capacitygrp || "aa2" in _capacitygrp) then
			{
				if ("aa1" in _capacitygrp || "aa2" in _capacitygrp) then
				{
					if ((vehicle _x) isKindOf "air") then
					{
						_points = _points + 300;
					};
				};
			};
		
			if ("at1" in _capacitygrp || "at2" in _capacitygrp || "at3" in _capacitygrp) then
			{
				_armor  = getNumber  (configFile >> "CfgVehicles" >> typeOf (vehicle _x) >> "armor");
				if (_armor >= 500 && ("at2" in _capacitygrp || "at3" in _capacitygrp)) then
				{
					_points = _points + 300;
				};
				
				if (_armor < 500 && "at1" in _capacitygrp) then
				{
					_points = _points + 200;
				};
				
				if (_armor < 250) then
				{
					_points = _points + 200;
				};

				if (!IsNull (Gunner (vehicle _x))) then
				{
					_points = _points + 100;
				};
			};
		};
		_points = _points - ((_npcpos vectordistance ((_x getVariable "UPSMON_TargetInfos") select 0)) / 10);
		if (_points < 0) then {_points = 0;};
		_list pushBack [_x,_points];
	}
} forEach _enies;

_list = [_list, [], {(_x select 1)}, "DESCEND"] call BIS_fnc_sortBy;

{
	_enies pushBack (_x select 0);
} forEach _list;

_enies