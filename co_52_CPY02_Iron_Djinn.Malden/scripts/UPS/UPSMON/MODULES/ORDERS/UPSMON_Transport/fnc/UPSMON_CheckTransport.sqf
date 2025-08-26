/****************************************************************
File: UPSMON_CheckTransport.sqf
Author: Azroul13

Description:
	Return if the group keep doing transport

Parameter(s):
	<--- Group
Returns:
	Group transported
****************************************************************/

private["_grp","_transportgrp","_grptransport","_vehicles"];				

_grp = _this select 0;
_transportgrp = ObjNull;

if (!IsNull (_grp getVariable ["UPSMON_Transport",ObjNull])) then 
{
	_grptransport = _grp getVariable ["UPSMON_Transport",ObjNull];
	if (_grptransport getVariable ["UPSMON_Grpmission",""] == "TRANSPORT") then
	{
		if (count (_grptransport getVariable ["UPSMON_Assignedvehicle",_assignedvehicles]) > 0) then
		{
			_vehicles = _grptransport getVariable ["UPSMON_Assignedvehicle",_assignedvehicles];
			if ({alive _x && vehicle _x != _x && canMove _x} count _vehicles > 0) then
			{
				_transportgrp = _grptransport;
			};
		};
	};
};

_transportgrp