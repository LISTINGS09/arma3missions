
private ["_grp","_nowp","_attackpos","_typeOfgrp","_maneuver"];

_grp = _this select 0;
_nowp = _this select 1;
_attackpos = _this select 2;
_typeOfgrp = _this select 3;

_maneuver = false;

if (!_nowp) then
{
	if (count _attackpos > 0) then
	{
		if (!("static" in _typeOfgrp)) then
		{
			if (!("arti" in _typeOfgrp)) then
			{
				if (!("supply" in _typeOfgrp)) then
				{
					if (_grp getVariable ["UPSMON_TIMEORDER",time] <= time) then
					{
						if (_grp getVariable ["UPSMON_Grpmission",""] != "TRANSPORT") then
						{
							_maneuver = true;
						};
					};
				};
			};
		};
	};
};

_maneuver;