/****************************************************************
File: 
Author: 

Description:
	
Parameter(s):

Returns:

****************************************************************/
private["_grp","_typeOfgrp","_side"];	

_grp = _this select 0;
_typeOfgrp = _this select 1;

_side = side _grp;


switch (_side) do
{
	case "WEST":
	{
		if ("arti" in _typeOfgrp) then 
		{
			if (!(_grp in UPSMON_ARTILLERY_WEST_UNITS)) then {UPSMON_ARTILLERY_WEST_UNITS pushBack _grp;};
		}
		else
		{
			if (_grp in UPSMON_ARTILLERY_WEST_UNITS) then {UPSMON_ARTILLERY_WEST_UNITS = UPSMON_ARTILLERY_WEST_UNITS - [_grp];};
		};
		
		if ("plane" in _typeOfgrp) then 
		{
			if (!(_grp in UPSMON_SUPPORT_WEST_UNITS)) then {UPSMON_SUPPORT_WEST_UNITS pushBack _grp;};
		}
		else
		{
			if (_grp in UPSMON_SUPPORT_WEST_UNITS) then {UPSMON_SUPPORT_WEST_UNITS = UPSMON_SUPPORT_WEST_UNITS - [_grp];};
		};
		
		if ("supply" in _typeOfgrp) then 
		{
			if (!(_grp in UPSMON_SUPPLY_WEST_UNITS)) then {UPSMON_SUPPLY_WEST_UNITS pushBack _grp;};
		}
		else
		{
			if (_grp in UPSMON_SUPPLY_WEST_UNITS) then {UPSMON_SUPPLY_WEST_UNITS = UPSMON_SUPPLY_WEST_UNITS - [_grp];};
		};
	};
	
	case "EAST":
	{
		if ("arti" in _typeOfgrp) then 
		{
			if (!(_grp in UPSMON_ARTILLERY_EAST_UNITS)) then {UPSMON_ARTILLERY_EAST_UNITS pushBack _grp;};
		}
		else
		{
			if (_grp in UPSMON_ARTILLERY_EAST_UNITS) then {UPSMON_ARTILLERY_EAST_UNITS = UPSMON_ARTILLERY_EAST_UNITS - [_grp];};
		};
		
		if ("plane" in _typeOfgrp) then 
		{
			if (!(_grp in UPSMON_SUPPORT_EAST_UNITS)) then {UPSMON_SUPPORT_EAST_UNITS pushBack _grp;};
		}
		else
		{
			if (_grp in UPSMON_SUPPORT_EAST_UNITS) then {UPSMON_SUPPORT_EAST_UNITS = UPSMON_SUPPORT_EAST_UNITS - [_grp];};
		};	
		
		if ("supply" in _typeOfgrp) then 
		{
			if (!(_grp in UPSMON_SUPPLY_EAST_UNITS)) then {UPSMON_SUPPLY_EAST_UNITS pushBack _grp;};
		}
		else
		{
			if (_grp in UPSMON_SUPPLY_EAST_UNITS) then {UPSMON_SUPPLY_EAST_UNITS = UPSMON_SUPPLY_EAST_UNITS - [_grp];};
		};
	};
	
	case "RESISTANCE":
	{
		if ("arti" in _typeOfgrp) then 
		{
			if (!(_grp in UPSMON_ARTILLERY_GUER_UNITS)) then {UPSMON_ARTILLERY_GUER_UNITS pushBack _grp;};
		}
		else
		{
			if (_grp in UPSMON_ARTILLERY_GUER_UNITS) then {UPSMON_ARTILLERY_GUER_UNITS = UPSMON_ARTILLERY_GUER_UNITS - [_grp];};
		};
		
		if ("plane" in _typeOfgrp) then 
		{
			if (!(_grp in UPSMON_SUPPORT_GUER_UNITS)) then {UPSMON_SUPPORT_GUER_UNITS pushBack _grp;};
		}
		else
		{
			if (_grp in UPSMON_SUPPORT_GUER_UNITS) then {UPSMON_SUPPORT_GUER_UNITS = UPSMON_SUPPORT_GUER_UNITS - [_grp];};
		};
		
		if ("supply" in _typeOfgrp) then 
		{
			if (!(_grp in UPSMON_SUPPLY_GUER_UNITS)) then {UPSMON_SUPPLY_GUER_UNITS pushBack _grp;};
		}
		else
		{
			if (_grp in UPSMON_SUPPLY_GUER_UNITS) then {UPSMON_SUPPLY_GUER_UNITS = UPSMON_SUPPLY_GUER_UNITS - [_grp];};
		};		
	};
};