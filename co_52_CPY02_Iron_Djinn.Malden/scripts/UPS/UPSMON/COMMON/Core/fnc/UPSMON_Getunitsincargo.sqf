/****************************************************************
File: UPSMON_Getunitsincargo.sqf
Author: Azroul13

Description:
	Function for order a unit to exit if no gunner
Parameter(s):

Returns:

****************************************************************/
private["_vehicle","_unitsincargo","_crew"];	
				
_vehicle = _this select 0;

_unitsincargo = [];

_crew = crew _vehicle;

{
	if (alive _x) then
	{
		if () then
		{
			_unitsincargo pushBack _x;
		};
	};
} forEach _crew;

_unitsincargo