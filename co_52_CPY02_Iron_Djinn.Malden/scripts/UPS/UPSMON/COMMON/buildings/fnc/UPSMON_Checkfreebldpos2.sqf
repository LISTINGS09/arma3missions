/****************************************************************
File: UPSMON_Checkfreebldpos2.sqf
Author: Azroul13

Description:
	Filter the building position and check if there're no unit near the position.

Parameter(s):
	<--- Building positions 
Returns:
	Building positions
****************************************************************/
private ["_bldpos","_bldpostemp","_id","_altura","_unitnear"];
	
_bldpos = _this select 0;
_bldpostemp = _bldpos;
_id = -1;
_unitnear = [];

{
	_id = _id + 1;
	if (typename _x == "ARRAY") then
	{
		_altura = _x;
		if (count _altura > 0) then
		{
			_unitnear = _altura nearEntities [["CAManBase","STATICWEAPON"],0.5];
			if (count _unitnear > 0) then 
			{
				_bldpostemp set [_id,"deletethis"];
				_bldpostemp = _bldpostemp - ["deletethis"];
			};
		};
	};
} forEach _bldpos;

_bldpostemp;