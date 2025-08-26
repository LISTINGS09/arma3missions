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

private [];

_targetPos = _this select 0;
_munradius = _this select 1;
_side = _this select 2;

_result = false;
//Must check if no friendly squad near fire position
{	
	if (!IsNull _x) then
	{
		if (alive (leader _x)) then 
		{
			if (_side == side _x) then
			{
				if ((round([getposATL (leader _x),_targetPos] call UPSMON_distancePosSqr)) <= (_munradius)) exitWith {_result = true;_result};
			};
		};
	};
} forEach UPSMON_NPCs;

_result