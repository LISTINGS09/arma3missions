/****************************************************************
File: UPSMON_artillerysetBattery.sqf
Author: Azroul13

Description:
	All artillery stop and set to battery
Parameter(s):
	<--- Group
	<--- Type of group
	<--- Nowp (true/false)
	<--- Targetpos
Returns:
	nothing
****************************************************************/
private ["_grp","_typeOfgrp","_nowp","_npc","_target","_pos","_staticteam","_backpack","_batteryunits"];

_grp = _this select 0;
_typeOfgrp = _this select 1;
_nowp = _this select 2;
_target = _this select 3;

_npc = leader _grp;
_currpos = getposATL _npc;

_grp setVariable ["UPSMON_OnBattery",false];

if (count (_grp getVariable ["UPSMON_Battery",[]]) > 0) then
{
	if (!(_grp getVariable ["UPSMON_GrpinAction",false])) then
	{
		if (!("static" in _typeOfgrp) || !_nowp) then
		{
			{
				Dostop _x;
			} forEach units _grp;
			
			_pos =  _currpos isFlatEmpty [10,1,0.5,10,20,false];
			
			if (count _pos > 0) then
			{
				_pos = ASLToATL _pos;
			}
			else
			{
				_pos = _currpos;
			};
	
			[_grp,_pos,"HOLD","LINE","LIMITED","COMBAT","YELLOW",1] spawn UPSMON_DocreateWP;
	
			if (typename ((_grp getVariable ["UPSMON_Battery",[]])select 0) == "ARRAY") then
			{
				sleep 2;
				_staticteam = (_grp getVariable ["UPSMON_Battery",[]])select 0;
				_batteryunits = _staticteam;
				{
					if (alive _x && vehicle _x != _x && !((vehicle _x) getVariable ["UPSMON_disembarking",false])) then 
					{
						waituntil {vehicle _x == _x || !alive _x};
					};
					if (!alive _x) exitWith {_batteryunits = [];};
				} forEach _staticteam; 
					
				if (count _batteryunits > 0) then
				{
					_grp call UPSMON_DeleteWP;
					_backpack = backpack (_batteryunits select 0);
					_vehicle = ([_backpack] call UPSMON_checkbackpack) select 0;
					[_staticteam select 0,_staticteam select 1,_pos,_target,_vehicle] call UPSMON_Unpackbag;
					_grp setVariable ["UPSMON_OnBattery",true];
					[_grp,_pos,"HOLD","LINE","LIMITED","COMBAT","YELLOW",1] spawn UPSMON_DocreateWP;
				};		
			}
			else
			{
				sleep 2;
				_grp setVariable ["UPSMON_OnBattery",true];
			};
		}
		else
		{
			_grp setVariable ["UPSMON_OnBattery",true];
		};
	};
};