/****************************************************************
File: UPSMON_CallRenf.sqf
Author: Azroul13

Description:
	The script will assign a combat waypoint to the group

Parameter(s):
	<--- Group
	<--- lastposition
Returns:
	nothing
****************************************************************/

private ["_grp","_currpos","_targetpos","_radiorange","_Eniescapacity","_renfgroup","_list","",""];

_grp = _this select 0;
_currpos = _this select 1;
_targetpos = _this select 2;
_radiorange = _this select 3;
_Eniescapacity = _this select 4;

_renfgroup = ObjNull;
_list = [];

_grp setVariable ["UPSMON_ONRADIO",true];	

_UPSMON_Renf = (call (compile format ["UPSMON_REINFORCEMENT_%1_UNITS",side _grp])) - [_grp];

if (UPSMON_Debug>0) then {diag_log format["%1 ask reinforcement position %2 KRON_Renf: %3",_npcpos,_fixedtargetpos,_UPSMON_Renf]};
if (count _UPSMON_Renf > 0) then
{
	{
		if (!IsNull _x) then
		{
			if (({alive _x && !(captive _x)} count units _x) > 0) then
			{
				if (!(_x getVariable ["UPSMON_ReinforcementSent",false])) then
				{
					if (_x getVariable ["UPSMON_Grpmission",""] != "RETREAT") then
					{
						if (_x getVariable ["UPSMON_Grpstatus","GREEN"] == "GREEN") then
						{
							if ((_currpos vectordistance (getposATL (leader _x))) <= _radiorange) then
							{
								_points = 0;
								if (surfaceIsWater _targetpos) then
								{
									if ("ship" in (_x getVariable ["UPSMON_typeOfgrp",[]])) then
									{
										if ("armed" in (_x getVariable ["UPSMON_typeOfgrp",[]])) then
										{
											_points = _points + 100;
										};
									};
									
									if ("air" in (_x getVariable ["UPSMON_typeOfgrp",[]])) then
									{	
										if ("at1" in (_x getVariable ["UPSMON_GroupCapacity",[]]) || "at2" in (_x getVariable ["UPSMON_GroupCapacity",[]])) then
										{
											_points = _points + 200;
										};
									};
								}
								else
								{
									if (!("ship" in (_x getVariable ["UPSMON_typeOfgrp",[]]))) then
									{
										_points = _points + (_x getVariable ["UPSMON_Grpratio",0]);
									};
									
									if ("aa2" in _Eniescapacity) then
									{
										if ("air" in (_x getVariable ["UPSMON_typeOfgrp",[]])) then
										{
											_points = _points - 200;
										};
									};
									
									if ("at3" in _Eniescapacity) then
									{
										if (("at3" in (_x getVariable ["UPSMON_GroupCapacity",[]])) || ("at2" in (_x getVariable ["UPSMON_GroupCapacity",[]]))) then
										{
											_points = _points + 200;
										};
									};
									
									if ("at2" in _Eniescapacity) then
									{
										if ("air" in (_x getVariable ["UPSMON_GroupCapacity",[]]) && "at1" in (_x getVariable ["UPSMON_GroupCapacity",[]])) then
										{
											_points = _points + 100;
										};
									};
								};
								
								_list pushBack [_x,_points];
							};
						};
					};
				};
			};
		};
		
		if (count _list > 0) then
		{
			_list = [_list, [], {_x select 1}, "DESCEND"] call BIS_fnc_sortBy;
			_renfgroup = (_list select 0) select 0;
		};
		
		if (!IsNull _renfgroup) then
		{
			_renfgroup setVariable ["UPSMON_PosToRenf",[_targetpos select 0,_targetpos select 1,0]];
			_renfgroup setVariable ["UPSMON_GrpToRenf",_grp];
			_grp setVariable ["UPSMON_RenfGrps",_renfgroup getVariable ["UPSMON_RenfGrps",[]] + _renfgroup];
		};
	} forEach _UPSMON_Renf;
};
	
_grp setVariable ["UPSMON_ONRADIO",false];