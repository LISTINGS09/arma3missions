/****************************************************************
File: UPSMON_Splashzone.sqf
Author: Azroul13

Description:
	check if there's allied near the targetpos.

Parameter(s):
	<--- Arti unit
	<--- Mission fire
Returns:
	boolean
****************************************************************/

private ["_grp","_result","_artillerysideFire","_artillerysideunits"];

_grp = _this select 0;
_result = false;

if (!(_grp getVariable ["UPSMON_NOARTILLERY",false])) then
{
	if (_grp getVariable ["UPSMON_RADIORANGE",0] > 0) then
	{
		if (_grp getVariable ["UPSMON_Articalltime",time] <= time) then
		{
			if (_grp getVariable ["UPSMON_Grpmission",""] != "AMBUSH") then
			{
				if (_grp getVariable ["UPSMON_Grpmission",""] != "SURRENDER") then
				{
					_artillerysideFire = call (compile format ["UPSMON_ARTILLERY_%1_FIRE",side _grp]);
					if (_artillerysideFire) then
					{
						_artillerysideunits = call (compile format ["UPSMON_ARTILLERY_%1_UNITS",side _grp]);
						if (count _artillerysideunits > 0) then
						{
							_result = true;
						};
					};
				};
			};
		};
	};
};

_result