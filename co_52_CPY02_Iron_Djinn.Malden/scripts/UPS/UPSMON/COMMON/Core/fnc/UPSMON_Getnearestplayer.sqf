/****************************************************************
File: UPSMON_Getnearestplayer.sqf
Author: Azroul13

Description:
	Get the nearest player near the position.
Parameter(s):
	<--- Position
	<--- Distance
Returns:
	Nearest unit or ObjNull
****************************************************************/
private ["_position","_nearestdist","_height","_nearest","_haslos"];

_position = _this select 0;
_nearestdist = _this select 1;

_nearest = objNull;

{
	if (isPlayer _x) then
	{
		if ((getposATL _x) select 2 <= 100) then
		{
			if ((getposATL _x vectorDistance [_position select 0,_position select 1,0]) <= _nearestdist) exitWith
			{
				_nearest=_x;
			};
		};
	};
} forEach playableUnits;

//playableUnits;
_nearest
