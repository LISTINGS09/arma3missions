/****************************************************************
File: UPSMON_getleader.sqf
Author: Monsada

Description:
	Check if leader is alive and if not search for a replacement in the group
Parameter(s):
	<--- leader
	<--- group
Returns:
	leader
****************************************************************/

private ["_npc","_grp","_members","_list"];
	
_npc = _this select 0;
_grp = _this select 1;
_members = units _grp;
	
//sleep 0.05;
if (!alive _npc) then 
{
		
	//soldier not in vehicle takes the lead or not in tank vehicle
	_list = [];
	{
		if (alive _x) then
		{	
			if (!isPlayer _x) then
			{
				if (canMove _x) then
				{
					_points = 0;
					if (_x == vehicle _x) then
					{
						switch (rank _x) do
						{
							case "CORPORAL":
							{
								_points = _points + 20;
							};
							case "SERGEANT":
							{
								_points = _points + 30;
							};
							case "LIEUTENANT":
							{
								_points = _points + 40;
							};
							case "MAJOR":
							{
								_points = _points + 50;
							};
							case "COLONEL":
							{
								_points = _points + 60;
							};
							case "PRIVATE":
							{
								_points = _points + 10;
							};
						};		
					}
					else
					{
						if (vehicle _x isKindOf "TANK" || vehicle _x isKindOf "Wheeled_APC") then
						{
							if ((assignedVehicleRole _x) select 0 == "Commander") then
							{
								_points = _points + 80;
							};
							
							if ((assignedVehicleRole _x) select 0 == "Gunner") then
							{
								_points = _points + 40;
							};
						};
					};
					
					_list pushBack [_x,_points];
				};
			};
		};
	} forEach _members;					
		
	if (count _list > 0) then
	{
		_list = [_list, [], {(_x select 1)}, "DESCEND"] call BIS_fnc_sortBy;
		_npc = (_list select 0) select 0;
	};
	//if no soldier out of vehicle takes any
	if (!alive _npc ) then 
	{
		{
			if (alive _x && canMove _x) exitWith {_npc = _x;};
		} forEach _members;	
	};

	//if not alive or already leader or is player exits
	{
		{
			if (alive _x && !isPlayer _x) exitWith {_npc = [_npc,_grp] call UPSMON_getleader;};
		} forEach _members;				
	};	
		
	if (leader _grp == _npc) exitWith {_npc};			
		
	//Set new _npc as leader		
	_grp selectLeader _npc;					
};

_npc // return