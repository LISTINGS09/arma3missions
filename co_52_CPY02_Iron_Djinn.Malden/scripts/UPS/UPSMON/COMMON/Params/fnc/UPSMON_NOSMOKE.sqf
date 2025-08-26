/****************************************************************
File: UPSMON_BackToNormal.sqf
Author: Azroul13

Description:

Parameter(s):
	<--- group
Returns:
	Nothing
****************************************************************/
private["_grp","_nosmoke"];	

_grp = _this select 0;
_nosmoke = true;

if (random 100 > UPSMON_USE_SMOKE) then
{	
	if (_grp getVariable ["UPSMON_SmokeTime",0] < time) then
	{
		if (!(_grp getVariable ["UPSMON_NOSMOKE",false])) then
		{
			_nosmoke = false;
		};
	};
};

_nosmoke
