private ["_cycle","_grp","_members","_grpmission","_grpstatus","_grpid","_Ucthis","_lastcurrpos","_lastpos","_lastattackpos","_areamarker","_npc","_driver","_buildingdist","_deadbodiesnear","_stuck","_makenewtarget","_targetpos","_attackpos","_dist","_target","_wptype","_traveldist","_targetdist","_speedmode","_behaviour","_combatmode","_currPos","_grpcomposition","_typeOfgrp","_capacityofgrp","_assignedvehicle","_supstatus","_TargetSearch"];

while {true} do 
{
	_cycle = ((random 1) + 1.5);
	{
		if (!IsNull _x) then
		{
			_grp = _x;
		
			_members = (_grp getVariable "UPSMON_Origin") select 4;

			_grpmission = _grp getVariable "UPSMON_GrpMission";
			_grpstatus = _grp getVariable "UPSMON_Grpstatus";
		
			_grpid = _grp getVariable "UPSMON_grpid";
			_Ucthis = _grp getVariable "UPSMON_Ucthis";
		
			_lastcurrpos = (_grp getVariable "UPSMON_Lastinfos") select 0;
			_lastpos = (_grp getVariable "UPSMON_Lastinfos") select 1;
			_lastattackpos = _grp getVariable ["UPSMON_Lastattackpos",[]];
		
			_areamarker = _Ucthis select 1;
		
			if (({alive _x && !(captive _x)} count units _grp) == 0 ||  _grp getVariable ["UPSMON_Removegroup",false]) exitWith
			{
				[_grp,_UCthis] call UPSMON_RESPAWN;
			}; 	
		
			_npc = leader _grp;
			_driver = driver (vehicle _npc);
		
			// did the leader die?
			_npc = [_npc,_grp] call UPSMON_getleader;							
			if (!alive _npc || isplayer _npc) exitWith {[_grp,_UCthis] call UPSMON_Respawngrp;};			
		
			_buildingdist = 50;
			_deadbodiesnear = false;
			_stuck = false;
			_makenewtarget = false;
			_targetpos = [0,0];
			_Attackpos = [];
			_wptype = "MOVE";
			_targetdist = 1000;
			_traveldist = 0;
			_dist = 10000;
			_safemode = ["CARELESS","SAFE"];
		
			_target = ObjNull;
			
			_speedmode = speedmode _npc;
			_behaviour = behaviour _npc;
			_combatmode = "YELLOW";
		

			// current position
			_currPos = getposATL _npc;

			if (count(waypoints _grp) != 0) then
			{
				_wppos = waypointPosition [_grp,count(waypoints _grp)-1];
				_targetpos = _wppos;
				_wptype = waypointType [_grp,count(waypoints _grp)-1];
				_targetdist = [_currpos,_targetpos] call UPSMON_distancePosSqr;
			};
		
			_grpcomposition = [_grp] call UPSMON_analysegrp;
			_typeOfgrp = _grpcomposition select 0;
			_capacityofgrp = _grpcomposition select 1;
			_assignedvehicle = _grpcomposition select 2;
	
			_supstatus = [_grp] call UPSMON_supstatestatus;
			_nowp = [_grp,_target,_supstatus] call UPSMON_NOWP;
		
		if (_grp getVariable ["UPSMON_GrpHostility",0] > 0) then
		{
			_TargetSearch 	= [_grp,_areamarker] call UPSMON_TargetAcquisitionCiv;
			_target = _TargetSearch select 0;
			_dist = _TargetSearch select 1;
			_attackpos = _TargetSearch select 2;
		
			if (_grp getVariable ["UPSMON_Grpmission",""] != "HARASS") then
			{
				if (!Isnull _target) then
				{
					_grp setVariable ["UPSMON_Grpmission","HARASS"]
				};
			}
			else
			{
				if (Isnull _target) then
				{
					[_grp] call UPSMON_BackToNormal;
				};		
			};
		};
	
		//if in safe mode if find dead bodies change behaviour
		{
			if (alive _x) then
			{
				if (vehicle _x == _x) then
				{
					if (!(_x getVariable ["UPSMON_Civfleeing",false])) then
					{
						if ((_x getVariable ["UPSMON_SUPSTATUS",""]) == "") then
						{
							if (UPSMON_deadBodiesReact)then 
							{
								_dead = [_x,_buildingdist] call UPSMON_deadbodies;
								if (!IsNull _dead) exitWith 
								{
									["FLEE",_x,Objnull] spawn UPSMON_Civaction;
								};
							};	
						}
						else
						{
							["FLEE",_x,Objnull] spawn UPSMON_Civaction;
						};
					
					};
				};
			};
		} forEach units _grp;
			
		//Stuck control
		if (!(_npc getVariable ["UPSMON_Civdisable",false])) then
		{
			_stuck = [_npc,_lastcurrpos,_currpos] call UPSMON_Isgrpstuck;
		};
		
//*********************************************************************************************************************
// 											ORDERS	
//*********************************************************************************************************************	
		
		switch (_grp getVariable "UPSMON_GrpMission") do 
		{	
			case "PATROL":
			{
				_speedmode = Speedmode _npc;
				_behaviour = Behaviour _npc;
				_wpformation = Formation _npc;
					
				if (!(_grp getVariable ["UPSMON_InTransport",false])) then
				{

					if (!(_grp getVariable ["UPSMON_searchingpos",false])) then
					{
						if (!([_targetpos,_areamarker] call UPSMON_pos_fnc_isBlacklisted) 
							|| _stuck
							|| _targetdist <= 5
							|| count(waypoints _grp) == 0 
							|| ((("tank" in _typeOfgrp) || ("ship" in _typeOfgrp) || ("apc" in _typeOfgrp) ||("car" in _typeOfgrp)) && _targetdist <= 25)
							|| (("air" in _typeOfgrp && !(_grp getVariable ["UPSMON_landing",false])) && (_targetdist <= 70 || Unitready _driver))) then
						{
							_makenewtarget=true;
						};
					};
				};
					
				// Search new patrol pos
				if (_makenewtarget) then
				{
					if (UPSMON_Debug > 0) then {diag_log format ["Grp%1 search newpos",_grp getVariable ["UPSMON_grpid",0]];};
					[_grp,_wpformation,_speedmode,_areamarker,_Behaviour,_combatmode,_typeOfgrp] spawn UPSMON_DOPATROL;
				};					
			};
		
			case "RELAX":
			{
				[_grp,_areamarker] call UPSMON_DORELAX;
			};
		
			case "HARASS":
			{
				{
					if (alive _x) then
					{
						if (canMove _x) then
						{
							if (vehicle _x == _x) then
							{
								if (!(_x getVariable ["UPSMON_Civfleeing",false])) then
								{
									if (_x getVariable ["UPSMON_Throwstone",time] <= time) then
									{
										if (!IsNull _target) then
										{
											if (_dist > 100 && !([_x,_target,100,130] call UPSMON_Haslos)) then
											{
												if (_x getVariable ["UPSMON_Civdisable",false]) then 
												{
													_x switchmove "";
													_x enableAI "MOVE";
													_x setVariable ["UPSMON_Civdisable",false];	
												};
											
												if (_x getVariable ["UPSMON_Movingtotarget",time] <= time) then
												{
													Dostop _x;
													_x domove _attackpos;
													_x setDestination [_attackpos, "LEADER PLANNED", true];
													_time = time + 120;
													_x setVariable ["UPSMON_Movingtotarget",_time];
												};
											}
											else
											{
												[_x,_attackpos] spawn UPSMON_throw_stone;
											};
										};
									};
								};
							};
						};
					};
					sleep 0.2;
				} forEach units _grp;
			};		
		
			case "STATIC":
			{
			
			};
					
		};
	
		if (count(waypoints _grp) != 0) then
		{
			_wppos = waypointPosition [_grp,count(waypoints _grp)-1];
			_targetpos = _wppos;
			_wptype = waypointType [_grp,count(waypoints _grp)-1];
			_targetdist = [_currpos,_targetpos] call UPSMON_distancePosSqr;
		};
		
		if (!_nowp) then
		{
			if (_grp getVariable "UPSMON_GrpMission" == "PATROL") then
			{
///////////////////////////////////////////////////////////////////////////
///////////					Disembarking 				//////////////////
//////////////////////////////////////////////////////////////////////////
		
				if (!(_grp getVariable ["UPSMON_disembarking",false])) then
				{
					if (!(_grp getVariable ["UPSMON_searchingpos",false])) then
					{
						if (_targetpos select 0 != 0 && _targetpos select 1 != 0) then 
						{
							if (!(_npc getVariable ["UPSMON_Civfleeing",false])) then
							{
								if (count _assignedvehicle > 0) then
								{
									[_grp,_assignedvehicle,_dist,_targetdist,_supstatus] call UPSMON_Disembarkment;
								};
							};
						};
					};
				};
///////////////////////////////////////////////////////////////////////////
///////////					Embarking 				     //////////////////
//////////////////////////////////////////////////////////////////////////

				if (!(_grp getVariable ["UPSMON_embarking",false])) then
				{
					if (!(_grp getVariable ["UPSMON_Disembarking",false])) then
					{
						if (!(_grp getVariable ["UPSMON_searchingpos",false])) then
						{
							if (!(_grp getVariable ["UPSMON_landing",false])) then
							{
								[_grp,_typeOfgrp,_targetpos,_dist,_targetdist,_assignedvehicle,_supstatus,_speedmode,_behaviour] call UPSMON_Embarkment;
							};
						};
					};
				};
			};
		};// !NOWP
		
		if (({alive _x && !(captive _x)} count units _grp) == 0 ||  _grp getVariable ["UPSMON_Removegroup",false]) exitWith
		{
			[_grp,_UCthis] call UPSMON_RESPAWN;
		}; 	
		
		_grp setVariable ["UPSMON_Grpstatus",_grpstatus];
		_grp setVariable ["UPSMON_Lastinfos",[_currpos,_targetpos]];
		_grp setVariable ["UPSMON_Lastattackpos",_attackpos];
		_grp setVariable ["UPSMON_LastGrpmission",_grp getVariable ["UPSMON_Grpmission",""]];
		
		sleep 0.1;
		
		};
		
	} forEach UPSMON_Civs;
	if (ObjNull in UPSMON_NPCs) then {UPSMON_NPCs = UPSMON_NPCs - [ObjNull]};
	sleep _cycle;
};