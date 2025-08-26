
private ["_grp","_dist","_ratio","_supstatus","_unitsneedammo","_typeOfgrp","_assignedvehicles","_attackpos"];

_grp = _this select 0;
_dist = _this select 1;
_ratio = _this select 2;
_supstatus = _this select 3;
_unitsneedammo = _this select 4;
_typeOfgrp = _this select 5;
_attackpos = _this select 6;
_assignedvehicles = _this select 7;


if (_grp getVariable ["UPSMON_Grpmission",""] != "RETREAT") then
{
	if (!("static" in _typeOfgrp)) then
	{
		if (_ratio > 2 || (count units _grp) == count _unitsneedammo || (_supstatus != "INCAPACITED") || ("arti" in _typeOfgrp) || ("support" in _typeOfgrp)) then
		{
			if (_dist >= 300) then
			{
				if (_supstatus != "SUPRESSED") then
				{
					if (!(fleeing (leader _grp))) then
					{
						if ((random 100) <= (call (compile format ["UPSMON_%1_RETREAT",(_grp getVariable ["UPSMON_Origin",[]]) select 5]))) then
						{
							[_grp,_attackpos,_typeOfgrp,_assignedvehicles] spawn UPSMON_DORETREAT;
							_grp setVariable ["UPSMON_Grpmission","RETREAT"];
							_grpstatus = "BLUE";
						};						
					};
				};
			};
		};
	};
};