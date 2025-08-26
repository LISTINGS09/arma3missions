/****************************************************************
File: UPSMON_getunits.sqf
Author: Azroul13

Description:
	
Parameter(s):
	<--- Array of units
Returns:
	Array of units
****************************************************************/

private ["_units","_validunits"];

_units = _this select 0;

_validunits = [];

{
	if (alive _x) then 
	{
		if (vehicle _x == _x) then 
		{
			if (_x getVariable ["UPSMON_Supstatus",""] != "SUPRESSED") then
			{
				if (canMove _x) then
				{
					if (canstand _x) then
					{
						if (!([_x] call UPSMON_Inbuilding)) then
						{
							_validunits pushBack _x;
						};
					};
				};
			};
		};
	};
}forEach _units;
	
_validunits