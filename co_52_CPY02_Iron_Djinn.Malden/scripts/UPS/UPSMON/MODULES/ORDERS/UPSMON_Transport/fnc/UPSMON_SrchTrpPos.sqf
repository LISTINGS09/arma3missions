/****************************************************************
File: UPSMON_SrchTrpPos.sqf
Author: Azroul13

Description:
	Search for a valid patrol position.

Parameter(s):
	<--- leader of the group
	<--- Position
	<--- Group type (Array: "Air","Tank","car","ship","infantry")
Returns:
	Position
****************************************************************/
	private ["_npc","_direction","_dir","_jumpers","_position","_targetPos","_incar","_inheli","_inboat","_isdiver","_dist","_currPos","_water","_mindist","_i"];
	
_npc = _this select 0;
_position = _this select 1;
_typeOfgrp = _this select 2;
	
_currPos = _position;
_direction =[_currPos,getposATL _npc] call BIS_fnc_DirTo;
_dir = [_direction + 270, _direction + 90];
_targetPos = [];
_isMan = false;
_dist = 1;
_mindist = 10;
_road = [0,100];
_water = 0;
	
if (!("ship" in _typeOfgrp) && !("air" in _typeOfgrp)&& !("car" in _typeOfgrp) && !("tank" in _typeOfgrp)) then {_isMan = true;};
	
// find a new target that's not too close to the current position

if (!_isMan) then
{
	if (("car" in _typeOfgrp) || ("tank" in _typeOfgrp) || ("air" in _typeOfgrp && (group _npc) getVariable ["UPSMON_MOVELANDING",false])) then		
	{
		_dist = 10;
		_mindist = 30;
		_road = [1,200];
	}
	else // boat or plane
	{
		if ("air" in _typeOfgrp) then
		{
			_water = 1;
			_dist = 0;
			_mindist = 70;
		}
		else // boat
		{
			_water = 2;
			_dist = 0;
			_mindist = 30;
		};
	};
};
	
_i = 0;

while {count _targetPos == 0 && _i < 40} do 
{
	_i = _i + 1;
	_targetPosTemp = [_position,[0,200],_dir,_water,_road,_dist] call UPSMON_pos;
	if (count _targetPos == 0) then 
	{
		if (("car" in _typeOfgrp) || ("tank" in _typeOfgrp) || ((group _npc) getVariable ["UPSMON_LANDDROP",false])) then
		{
			if (!(surfaceIsWater _targetPosTemp)) then
			{
				_terrainscan = _targetPosTemp call UPSMON_sample_terrain;
				if ((_terrainscan select 0) == "meadow" || (_terrainscan select 0) == "forest") then
				{
					if ((_terrainscan select 1) < 90) then
					{
						if ((count (_targetPosTemp isflatempty [100,0,10,10,0,false,objnull]) > 0) || (isOnRoad _targetPosTemp)) then
						{
							_targetpos = _targetPosTemp;
						};
					};
				};
			};
		}
		else
		{
			if ("ship" in _typeOfgrp && (surfaceIsWater _targetPosTemp)) then
			{
				_targetpos = _targetPosTemp;
			} 
			else
			{
				if (!(surfaceIsWater _targetPosTemp) || ("air" in _typeOfgrp)) then
				{
					_targetpos = _targetPosTemp;
				};
			};
		};
	};
	sleep 0.02;
};
	
if (count _targetPos == 0) then {_targetPos = _currPos;};
_targetPos;

