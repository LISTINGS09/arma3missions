
private ["_grp","_dist","_ratio","_supstatus","_unitsneedammo","_typeOfgrp","_haslos"];

_grp = _this select 0;
_dist = _this select 1;
_ratio = _this select 2;
_supstatus = _this select 3;
_unitsneedammo = _this select 4;
_typeOfgrp = _this select 5;
_haslos = _this select 6;


if (_grp getVariable ["UPSMON_Grpmission",""] != "RETREAT") then
{
	if (UPSMON_SURRENDER) then
	{
		if ((random 100) <= (call (compile format ["UPSMON_%1_SURRENDER",(_grp getVariable ["UPSMON_Origin",[]]) select 5]))) then
		{
			if (!("air" in _typeOfgrp)) then
			{
				if (_ratio > 2 || ((count units _grp) == count _unitsneedammo) || (_supstatus != "")) then
				{
					if (_supstatus == "SUPRESSED") then
					{
						if (_dist < 300) then
						{
							if (_haslos) then
							{
								_grp setVariable ["UPSMON_Grpmission","SURRENDER"];
								_grpstatus = "BLUE";
							};						
						};
					};
				};
			};
		};
	};
};