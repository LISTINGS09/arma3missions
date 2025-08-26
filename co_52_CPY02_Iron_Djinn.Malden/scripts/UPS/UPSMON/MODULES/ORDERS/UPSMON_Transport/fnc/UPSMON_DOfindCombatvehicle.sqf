/****************************************************************
File: UPSMON_DOfindCombatvehicle.sqf
Author: Azroul13

Description:
	Search for near combat vehicles.

Parameter(s):
	<--- Group
	<--- Id of the group
Returns:
	nothing
****************************************************************/

private ["_grp","_npc","_unitsIn","_vehicle","_timeout"];
	
_grp = _this select 0;

//Get in combat vehicles				
_unitsIn = [];
_npc = leader _grp;
_grp setVariable ["UPSMON_embarking",true];
_unitsIn = [_npc,["air","land","sea","gun"],200] call UPSMON_GetIn_NearestVehicles;	
_timeout = time + 30;
				
	if ( count _unitsIn == 0) then 
	{							
		//if (UPSMON_Debug>0 ) then {player sidechat format["%1: Geting in combat vehicle targetdist=%2",_grp getVariable ["UPSMON_Grpid",0],_npc distance _target]}; 																												
						
		{ 
			waituntil {vehicle _x != _x || !canMove _x || !canstand _x || !alive _x || time > _timeout || movetofailed _x}; 
		}forEach _unitsIn;
						
		// did the leader die?
		if (({alive _x} count units _grp) == 0) exitWith {};								
						
		//Return to combat mode
		_timeout = time + 30;
		{ 
			waituntil {vehicle _x != _x || !canMove _x || !alive _x || time > _timeout || movetofailed _x}; 
		}forEach _unitsIn;
						
	{								
		if ( vehicle _x  isKindOf "Air") then 
		{
			//moving hely for avoiding stuck
			if (driver vehicle _x == _x) then 
			{
				_vehicle = vehicle (_x);									
				nul = [_vehicle,1000] spawn UPSMON_domove;	
				//Execute control stuck for helys
				[_vehicle] spawn UPSMON_HeliStuckcontrol;
				//if (UPSMON_Debug>0 ) then {diag_log format["UPSMON %1: Getting in combat vehicle - distance: %2 m",_grpidx,_npc distance _target]}; 	
			};									
		};
							
		if (driver vehicle _x == _x) then 
		{
			//Starts gunner control
			nul = [vehicle _x] spawn UPSMON_Gunnercontrol;								
		};
	} forEach _unitsIn;									
};
_grp setVariable ["UPSMON_embarking",false];