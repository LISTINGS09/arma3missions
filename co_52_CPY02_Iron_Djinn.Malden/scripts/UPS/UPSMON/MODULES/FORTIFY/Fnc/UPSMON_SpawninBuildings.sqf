/****************************************************************
File: UPSMON_SpawninBuildings.sqf
Author: Azroul13

Description:
	Spawn each unit of the group in building

Parameter(s):
	<--- Group units 
	<--- Array of buildings
	<--- Leader of group
Returns:
	units not in building
****************************************************************/

private ["_minpos","_units","_blds","_blds2","_altura","_bld","_bldpos1","_bldpos2","_cntobjs1","_movein","_i","_result","_id2"];

_minpos  = 1;

_units = _this select 0;
_blds = _this select 1;
_i = 0;
if (count _this > 2) then {_i = _this select 2};

if (_i > 4) exitWith {_units};

_blds2 = [];

{
	_arraybld = _x;
	_bld 		= _x select 0;
	_bldpos1 	= (_x select 1) select 0;
	_bldpos2 	= (_x select 1) select 1;
		
	if (count _bldpos1 < _minpos) then {_bldpos1 = (_x select 1) select 1;_bldpos2 = _bldpos1;};
	if ("deletethis" in _bldpos1) then {_bldpos1 = _bldpos1 - ["deletethis"];};

	if ( count _bldpos1 >= _minpos ) then 
	{
		_cntobjs1 = 1;
		_movein = [];
		if (count _bldpos1 >= 3) then { _cntobjs1 =   round(random 1) + 2;};
		if (count _bldpos1 >= 8) then { _cntobjs1 =   round(random 2)  + 6;};
		if (count _bldpos1 >= 10) then {_cntobjs1 =   round(random 3)  + 7;};
			
		{							
			if (alive _x) then
			{
				if (canMove _x) then
				{
					if (vehicle _x == _x) then
					{
						if (_cntobjs1 > 0) then
						{
							_movein pushBack _x;
							_cntobjs1 = _cntobjs1 - 1;
						};
					};
				};
			};
		} forEach  _units;
			
		if (count _movein > 0) then
		{
			{
				if (count _bldpos1 > 0) then
				{
					_result = [_bldpos1] call UPSMON_Checkfreebldpos;
					if (count _result > 0) then
					{
						_altura = _result select 0;
						_id2 = _result select 1;
						_x setpos _altura;
						dostop _x;
						if ((group _x) getVariable ["UPSMON_NOWP",0] > 2) then {_x disableAI "TARGET"};
						[_x,getDir _x,_bld] spawn UPSMON_UnitWatchDir;
						_bldpos1 set [_id2,"deletethis"];
						_bldpos1 = _bldpos1 - ["deletethis"];
						_units = _units - [_x];
					};
				};					
			} forEach _movein;
		};
	};
	_blds2 pushBack [_bld,[_bldpos1,_bldpos2]];
} forEach _blds;

_blds = _blds2;

if (count _units > 0) then
{
	_i = _i +1;
	_units = [_units,_blds,_i] call UPSMON_SpawninBuildings;
};

_units