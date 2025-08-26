/****************************************************************
File: UPSMON_Nowp.sqf
Author: Azroul13

Description:

Parameter(s):

Returns:

****************************************************************/

private ["_grp","_target","_supstatus","_nowp"];

_grp = _this select 0;
_target = _this select 1;
_supstatus = _this select 2;

_nowp = true;

if (_grp getVariable ["UPSMON_NOWP",0] == 0) then
{
	if (_grp getVariable ["UPSMON_Grpmission",""] != "AMBUSH") then
	{
		if (_grp getVariable ["UPSMON_Grpmission",""] != "FORTifY") then
		{
			if (_grp getVariable ["UPSMON_Grpmission",""] != "RETREAT") then
			{
				if (_grp getVariable ["UPSMON_Grpmission",""] != "SURRENDER") then
				{
					_nowp = false;
				};
			}
		};
	};
}
else
{
	switch (_grp getVariable ["UPSMON_NOWP",0]) do
	{
		case 1:
		{
			if (!IsNull _target) then
			{
				_nowp = false;
			};
		};
		case 2:
		{
			if (_supstatus == "INCAPACITED") then
			{
				_nowp = false;
			};
		};
		case 3:
		{
			//Always Nowp = true
		};
	};
};

_nowp