while {true} do 
{
	_cycle = ((random 1) + 1);
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
			_surrended = false;
		
			if (({alive _x && !(captive _x)} count units _grp) == 0 ||  _grp getVariable ["UPSMON_Removegroup",false]) exitWith
			{
				[_grp,_UCthis] call UPSMON_RESPAWN;
			}; 	
		
			_npc = leader _grp;
			_driver = driver (vehicle _npc);
		
			// did the leader die?
			_npc = [_npc,_grp] call UPSMON_getleader;							
			if (!alive _npc || isplayer _npc) exitWith {[_grp,_UCthis] call UPSMON_RESPAWN;};			
		
			_buildingdist = 50;
			_deadbodiesnear = false;
			_stuck = false;
			_makenewtarget = false;
			_haslos = false;
			_terrainscan = ["meadow",10];
			_targetpos = [0,0];
			_Attackpos = [];
			_opfknowval = 0;
			_wptype = "MOVE";
			_targetdist = 1000;
			_traveldist = 0;
			_dist = 10000;
			_ratio = 0.5;
			_safemode = ["CARELESS","SAFE"];
		
			_target = ObjNull;
			_typeOfeni = [];
		
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
			_weaponrange = _grpcomposition select 3;
	
			_supstatus = [_grp] call UPSMON_supstatestatus;
			_nowp = [_grp,_target,_supstatus] call UPSMON_NOWP;
		
		if (_grp getVariable ["UPSMON_NOAI",false]) then
		{
			_fixedtargetPos = [_grp,_lastpos] call UPSMON_GetReinfPos;
			if (count _fixedtargetPos > 0) then {_targetpos = _fixedtargetPos;};
		
			_terrainscan = _currpos call UPSMON_sample_terrain;	
			_unitsneedammo = [_npc] call UPSMON_checkmunition;
			_vehiclesneedsupply = [_assignedvehicle] call UPSMON_Checkvehiclesstatus;
		
//*********************************************************************************************************************
// 											Acquisition of the target	
//*********************************************************************************************************************		
			_TargetSearch 	= [_grp] call UPSMON_TargetAcquisition;
			_Enemies 		= _TargetSearch select 0;
			_Allies 		= _TargetSearch select 1;
			_target 		= _TargetSearch select 2;
			_dist 			= _TargetSearch select 3;
			_targetsnear 	= _TargetSearch select 4;
			_attackPos 		= _TargetSearch select 5;
			_suspectenies	= _TargetSearch select 6;
			_opfknowval 	= _TargetSearch select 7;
		
			if (_opfknowval > 0) then
			{
				if (_grp getVariable ["UPSMON_lastOpfknowval",0] < _opfknowval) then
				{
					_timeontarget = (_grp getVariable ["UPSMON_TIMEONTARGET",time]) - 10;
					_grp setVariable ["UPSMON_TIMEONTARGET",_timeontarget];
				};
			};
//*********************************************************************************************************************
// 											Reactions	
//*********************************************************************************************************************				

			_nowp = [_grp,_target,_supstatus] call UPSMON_NOWP;
		
			if (!IsNull _target) then
			{
				_grp setVariable ["UPSMON_Grpstatus","RED"];
					
				_haslos = [_npc,_target,_weaponrange,130] call UPSMON_Haslos;
					
				//Analyse Targets && Allies
				_Situation = [_grp,_Allies,_Enemies] call UPSMON_Checkratio;
				_ratio = _Situation select 0;
				_enicapacity = _Situation select 1;
				_typeOfeni = _Situation select 2;
				
				//Retreat
				[_grp,_dist,_ratio,_supstatus,_unitsneedammo,_typeOfgrp,_attackpos,_assignedvehicle] call UPSMON_IsRetreating;
			
				//Surrender
				[_grp,_dist,_ratio,_supstatus,_unitsneedammo,_typeOfgrp,_haslos] call UPSMON_IsSurrending;
			
				if (_grp getVariable ["UPSMON_Grpmission",""] == "SURRENDER") exitWith {[_grp] call UPSMON_surrended;};
			
				// Artillery Support
				_artillery = [_grp] call UPSMON_ArtiChk;
				if (_artillery) then
				{
					[_grp,_currpos,_attackpos,_dist,_enies] call UPSMON_FO;
				};
					
				// Reinforcement Support
				_reinf = [_grp,_ratio,_typeOfgrp] call UPSMON_ReinfChk;
				if (_reinf) then
				{
					[_grp,_currpos,_attackpos,_radiorange,_enicapacity] spawn UPSMON_CallRenf;
				};
			};
		
			if (_supstatus == "SUPRESSED") then
			{
				_timeontarget = (_grp getVariable ["UPSMON_TIMEONTARGET",time]) + 30;
				_grp setVariable ["UPSMON_TIMEONTARGET",_timeontarget];
			};
		
			_nowp = [_grp,_target,_supstatus] call UPSMON_NOWP;
			_maneuver = [_grp,_nowp,_attackpos,_typeOfgrp] call UPSMON_Cangrpmaneuver;
		
			if (_maneuver) then
			{			
				if ("air" in _typeOfgrp) then
				{
					[_grp,_attackpos,_lastattackpos,_typeOfgrp,_dist] call UPSMON_PLANASSLT;
					_grp setVariable ["UPSMON_Grpmission","ASSAULT"];
					_grpstatus = "PURPLE";
				}
				else
				{
					if ("ship" in _typeOfgrp) then
					{
						if (_dist < 300 && (surfaceIsWater _attackpos)) then
						{
							[_grp,_attackpos,_lastattackpos,_typeOfgrp,_dist] call UPSMON_PLANASSLT;
							_grp setVariable ["UPSMON_Grpstatus","BLACK"];								
						}
						else
						{
							[_grp,_attackpos,_lastattackpos,_dist,_typeOfgrp,_terrainscan,_areamarker,_haslos] call UPSMON_PLANFLANK;
						};
					}
					else
					{
						if (_ratio < 1.2 && (_supstatus != "SUPRESSED")) then
						{
							_inmarker =  [_attackpos,_areamarker] call UPSMON_pos_fnc_isBlacklisted;
							// Offensive Behaviour
							if (_dist <= 300 && ({alive _x && !(captive _x)} count units _grp) >= 4 && !("arti" in _typeOfgrp)  && (!(_grp getVariable ["UPSMON_NOFOLLOW",false]) || !_inmarker)) then
							{
								//Assault
								if ("car" in _typeOfgrp && !("infantry" in _typeOfgrp)) then
								{
									_terrainscantarget = _attackpos call UPSMON_sample_terrain;
												
									if (((_terrainscantarget) select 0 == "inhabited" || (_terrainscantarget) select 0 == "forest") && (_terrainscantarget) select 1 > 100) then
									{
										[_grp,_attackpos,_lastattackpos,_dist,_typeOfgrp,_terrainscan,_areamarker,_haslos] call UPSMON_PLANFLANK;
									}
									else
									{
										[_grp,_attackpos,_lastattackpos,_typeOfgrp,_dist] call UPSMON_PLANASSLT;
										_grp setVariable ["UPSMON_Grpstatus","BLACK"];
									};
								}
								else
								{
									[_grp,_attackpos,_lastattackpos,_typeOfgrp,_dist,_targetdist] call UPSMON_PLANASSLT;
									_grp setVariable ["UPSMON_Grpstatus","BLACK"];
								};
							}
							else
							{	
								if (("staticbag" in _typeOfgrp) || (_grp getVariable ["UPSMON_NOFOLLOW",false] && _inmarker)) then
								{
									if ((_haslos && _dist <= _weaponrange && _dist > 300)  || (_grp getVariable ["UPSMON_NOFOLLOW",false] && _inmarker)) then
									{
										//SUPPORT
										//[_grp] call UPSMON_PLANSPT;
										if (_wptype != "HOLD") then
										{
											_timeorder = time + 15;
											_grp setVariable ["UPSMON_TIMEORDER",_timeorder];
											[_grp,_currpos,"HOLD","LINE","LIMITED","STEALTH","YELLOW",1] call UPSMON_DocreateWP;								
										};										
										_grp setVariable ["UPSMON_Grpmission","SUPPORT"];
										_grp setVariable ["UPSMON_Grpstatus","PURPLE"];
									}
									else
									{
										//FLANK
										[_grp,_attackpos,_lastattackpos,_dist,_typeOfgrp,_terrainscan,_areamarker,_haslos,_targetpos,_currpos] call UPSMON_PLANFLANK;
									};
								}
								else
								{
									//FLANK
									[_grp,_attackpos,_lastattackpos,_dist,_typeOfgrp,_terrainscan,_areamarker,_haslos,_targetpos,_currpos] call UPSMON_PLANFLANK;
								};
							};
						}
						else
						{
							//Defensive Behaviour
							if (_wptype != "HOLD") then
							{
								[_grp,_dist,_target,_supstatus,_terrainscan] spawn UPSMON_DODEFEND;
								_timeorder = time + 5;
								_grp setVariable ["UPSMON_TIMEORDER",_timeorder];								
							};
							_grp setVariable ["UPSMON_Grpmission","DEFEND"];
						};
					};
				};
			};
		
			if (IsNull _target) then
			{
				if (count (_grp getVariable ["UPSMON_attackpos",[]]) == 0) then
				{
					if (count _suspectenies > 0) then
					{
						_suspectenies = [_suspectenies, [], { _currpos distance ((_x getVariable "UPSMON_TargetInfos") select 0)}, "ASCEND"] call BIS_fnc_sortBy;
						_suspectpos = ((_suspectenies select 0) getVariable "UPSMON_TargetInfos") select 0;
						_grp setVariable ["UPSMON_SuspectPos",_suspectpos];
					};
				};
			
				if (_supstatus != "" || count (_grp getVariable ["UPSMON_SuspectPos",[]]) > 0) then
				{
					_artipos = _grp getVariable ["UPSMON_SuspectPos",[]];
				
					if (count _artipos > 0) then
					{
						[_grp,(_grp getVariable "UPSMON_SuspectPos"),_currpos] call UPSMON_GETINPATROLSRCH;
					};
					if ([] call UPSMON_Nighttime) then
					{
						if (!(UPSMON_FlareInTheAir)) then
						{
						
							if (count _artipos == 0) then
							{
								_artipos = [_currpos,[100,200],[0,360],0,[0,100],0] call UPSMON_pos;
							};
					
							if (count _artipos > 0) then
							{
								_artillery = [_grp] call UPSMON_ArtiChk;
								if (_artillery) then
								{
									[_grp,_currpos,_artipos,_dist,_enies,"ILLUM"] call UPSMON_FO;
								}
								else
								{
									if (_supstatus != "SUPRESSED") then
									{
										//Fire Flare
										[_grp,_artipos] call UPSMON_FireFlare;
									};
								};
							};
						};
					}
					else
					{
						if (_supstatus == "SUPRESSED") then
						{
							_smokepos = _grp getVariable ["UPSMON_SuspectPos",[]];
							if (count _smokepos == 0) then
							{
								_smokepos = [_currpos,[30,100],[0,360],0,[0,100],0] call UPSMON_pos;
							};
						
							if (count _smokepos > 0) then
							{
								_nosmoke = [_grp] call UPSMON_NOSMOKE;
								if (!_nosmoke) then {[units _grp,_smokepos] spawn UPSMON_CreateSmokeCover;};
							};
						};
					};
				};
			};
		
			_targetdist = [_currpos,_targetpos] call UPSMON_distancePosSqr;
		
			[_grp,_supstatus,_attackpos,_dist,_terrainscan,_haslos,_typeOfgrp] call UPSMON_ChangeFormation;
		
			if ("arti" in _typeOfgrp) then
			{
				if (_grp getVariable ["UPSMON_Grpmission",""] != "RETREAT") then
				{
					if (!(_grp getVariable ["UPSMON_OnBattery",false])) then
					{
						if (count _attackpos > 0 || count (_grp getVariable ["UPSMON_Artifiremission",[]]) > 0) then
						{
							_artitarget = _attackpos;
							if (count (_grp getVariable ["UPSMON_Artifiremission",[]]) > 0) then {_artitarget = (_grp getVariable ["UPSMON_Artifiremission",[]]) select 0;};
							[_grp,_typeOfgrp,_nowp,_artitarget] spawn UPSMON_artillerysetbattery;
							if (_grp getVariable ["UPSMON_Grpmission",""] != "FIREMISSION") then
							{
								_grp setVariable ["UPSMON_Grpmission","FIREMISSION"];
							};
						};
					};
				};
			};
		
			if (_grp getVariable ["UPSMON_TRANSPORT",false]) then
			{
				if (!(_grp getVariable ["UPSMON_GrpInAction",false])) then
				{
					if (count (_grp getVariable ["UPSMON_Transportmission",[]]) > 0) then
					{
						_grp setVariable ["UPSMON_Grpmission","TRANSPORT"];
					};
				};
			};
		
			if (_grp getVariable ["UPSMON_Supply",false]) then
			{
				if (!(_grp getVariable ["UPSMON_GrpInAction",false])) then
				{
					if (count (_grp getVariable ["UPSMON_Supplymission",[]]) > 0) then
					{
						_grp setVariable ["UPSMON_Grpmission","SUPPLY"];
					};
				};
			};
		
			if (_grpstatus == "GREEN") then
			{	
				_dead = ObjNull;
				//if in safe mode if find dead bodies change behaviour
				if (UPSMON_deadBodiesReact)then 
				{
					{
						if (alive _x) then
						{
							if (vehicle _x == _x) then
							{
								_dead = [_x,_buildingdist] call UPSMON_deadbodies;
								if (!IsNull _dead) exitWith 
								{
									_deadbodiesnear = true;
									_grp setVariable ["UPSMON_Grpstatus","YELLOW"];
								};
							};
						};
					} forEach units _grp;
			
					if (_deadbodiesnear) then
					{
						[_grp,getposATL _dead,_currpos] call UPSMON_GETINPATROLSRCH;
					};
				};
			
				//Stuck control
				_stuck = [_npc,_lastcurrpos,_currpos] call UPSMON_Isgrpstuck;
			}
			else
			{
				if (IsNull _target) then
				{
					_grpstatus = "YELLOW";
				};
			};

		}; // End NOAI
		
		if ("air" in _typeOfgrp || "car" in _typeOfgrp || "tank" in _typeOfgrp) then
		{
			if (_grp getVariable ["UPSMON_Grpmission",""] != "RESSUPLY") then
			{
				if ((_grp getVariable ["UPSMON_Grpstatus","GREEN"] == "GREEN") || (_grp getVariable ["UPSMON_Grpmission",""] == "DEFEND") || ("air" in _typeOfgrp)) then
				{
					if (_dist > 800) then
					{
						//_supplyunit = [_grp] call UPSMON_getsupply;
						//if (!IsNull _supplyunit) then
						//{
							//_grp setVariable ["UPSMON_Grpmission","RESSUPLY"];
							//_grp setVariable ["UPSMON_SupplyGrp",_supplyunit];
							//_supplypos = [_grp] call UPSMON_GetSupplyPos;
							//_supplyunit setVariable ["UPSMON_Supplymission",[_grp,_vehiclesneedsupply,_supplypos]];
						//}
						//else
						//{
							//if ("air" in _typeOfgrp) then
							//{
								//_basepos = (_grp getVariable "UPSMON_Origin") select 0;
								//[_grp,_basepos,"MOVE","COLUMN","FULL","CARELESS","YELLOW",1,UPSMON_flyInHeight] call UPSMON_DocreateWP;
								//_grp setVariable ["UPSMON_Grpmission","RESSUPLY"];
							//}
						//};
					};
				};
			};
		};
	
//*********************************************************************************************************************
// 											ORDERS	
//*********************************************************************************************************************	
		
		switch (_grp getVariable "UPSMON_GrpMission") do 
		{
			case "ASSAULT":
			{
				if (!(_grp getVariable ["UPSMON_searchingpos",false])) then
				{
					if (!(_grp  getVariable ["UPSMON_GrpinAction",false])) then
					{
						if (_targetdist <= 300) then
						{
							if (IsNull _target) then
							{
								if (_targetdist <= 100) then
								{
									[_grp,_grp getVariable ["UPSMON_attackpos",[]],_currpos] call UPSMON_GETINPATROLSRCH;
								};
							}
							else
							{
								if (vehicle _target == _target) then
								{
									if ([_target] call UPSMON_Inbuilding) then
									{
										if ((_target getVariable "UPSMON_TargetInfos") select 1 <= 10) then
										{	
											if (_dist <= 100) then
											{
												//The target is in a building, what do we do ?
												[_grp,_target] spawn UPSMON_AssltBld;
											};
										};
									}
									else
									{
										if (_dist > 50) then
										{
											if (_haslos) then
											{
												//[_grp,_target] spawn UPSMON_Assltposition;
											};
										};
									};
								};
							};
						};
					};
				};
			};
		
			case "FLANK":
			{
				if (!(_grp getVariable ["UPSMON_searchingpos",false])) then
				{
					if (_targetdist <= 20) then
					{
						if (_grp getVariable "UPSMON_TIMEORDER" <= time) then
						{
							if (IsNull _target) then
							{
								[_grp,_grp getVariable ["UPSMON_attackpos",[]],_currpos] call UPSMON_GETINPATROLSRCH;
							};
						};
					};
				};
			};
		
			case "SUPPORT":
			{
				if (_targetdist <= 10) then
				{
					if (!IsNull _target) then
					{
						if (!(_grp  setVariable ["UPSMON_GrpinAction",false])) then
						{
							if ("staticbag" in _typeOfgrp) then
							{
								//Deploy static
								[_grp,_currpos,_attackpos] call UPSMON_DeployStatic;
							};
						};
					}
					else
					{
						[_grp,(_grp getVariable "UPSMON_Attackpos"),_currpos] call UPSMON_GETINPATROLSRCH;				
					};
				};
			};		
		
			case "DEFEND":
			{
				if (!(_grp getVariable ["UPSMON_searchingpos",false])) then
				{
					if (_wptype == "HOLD") then
					{
						if (!(_grp  getVariable ["UPSMON_GrpinAction",false])) then
						{
							if (_supstatus != "SUPRESSED") then
							{
								if (_targetdist <= 100) then
								{
									if (_dist > 500) then
									{
										if ("heavy" in _typeOfeni || "medium" in _typeOfeni) then
										{
											//Put minefield
											[_grp,_attackpos] call UPSMON_SetMinefield;
										};
									};
							
									[_grp,_attackpos] spawn UPSMON_FORTifY;
								};
							};
						};
					};
				};
			};
		
			case "PATROLSRCH":
			{
				if (count (_grp getVariable ["UPSMON_Alertpos",[]]) > 0) then
				{
					if (_grp getVariable ["UPSMON_SRCHTIME",time] > time) then
					{
						if (!(_grp getVariable ["UPSMON_searchingpos",false])) then
						{
							if (!(_grp getVariable ["UPSMON_Disembarking",false])) then
							{
								if ((_targetpos select 0 == (_grp getVariable "UPSMON_Alertpos") select 0 && _targetpos select 1 == (_grp getVariable "UPSMON_Alertpos") select 1)
									|| _targetdist <= 5
									//|| _stuck
									|| moveToFailed _npc 
									|| moveToCompleted _npc 
									|| (_grp getVariable ["UPSMON_TIMEONTARGET",0] < time && !("air" in _typeOfgrp))
									//|| (("air" in _typeOfgrp && !(_grp getVariable ["UPSMON_landing",false])) && (_targetdist <= (30 + (_currpos select 2))))
									|| ("air" in _typeOfgrp && _wptype != "LOITER")) then
								{
									[_grp,_grp getVariable "UPSMON_Alertpos",_typeOfgrp,_areamarker] spawn UPSMON_DOPATROLSRCH;
								};
							};
						};
					}
					else
					{
						[_grp] spawn UPSMON_BackToNormal;
						_grp setVariable ["UPSMON_Alertpos",[]];
					};
				};
			};
		
			case "PATROLINBLD":
			{
				if (_targetdist <= 100) then
				{
					if (count (_grp getVariable ["UPSMON_bldposToCheck",[]]) > 0) then
					{
						if (!(_grp getVariable ["UPSMON_InBuilding",false])) then
						{
							_units = [units _grp] call UPSMON_Getunits;
							[_units,_grp getVariable ["UPSMON_bldposToCheck",[]],_grp,55] spawn UPSMON_patrolBuilding;
						}
					}
					else
					{
						_grp setVariable ["UPSMON_Grpmission","PATROLSRCH"];
					};
				};
			};
		
			case "REINFORCEMENT":
			{
				if (_targetdist <= UPSMON_Closeenough) then
				{
					[_grp,_targetpos,_currpos] call UPSMON_GETINPATROLSRCH;
					_grpstatus = "YELLOW"
				};
			};
		
			case "AMBUSH":
			{	
				_ambush2 = if ("AMBUSH2:" in _UCthis || "AMBUSH2" in _UCthis || "AMBUSHDIR2:" in _UCthis) then {true} else {false};
				_ambushdistance = [_currpos,(_grp getVariable "UPSMON_Positiontoambush")] call UPSMON_distancePosSqr;
				_targetdistance = 1000;
				_targetknowaboutyou = 0;
				_linkactivate = false;
			
				if (!isnull _target) then {_targetdistance = [_currpos,getposATL _target] call UPSMON_distancePosSqr;_targetknowaboutyou = _target knowsabout _npc;}; 
				//Ambush enemy is nearly aproach
				//_ambushdist = 50;		
				// replaced _target by _NearestEnemy
		
				if (_grp getVariable ["UPSMON_LINKED",0] > 0) then 
				{
					{
						if (side _x == _side) then
						{
							if (round ([_currpos,getposATL (leader _x)] call UPSMON_distancePosSqr) <= (_grp getVariable ["UPSMON_LINKED",0])) then
							{
								if (_x getVariable "UPSMON_AMBUSHFIRE") 
								exitWith {_linkactivate = true};
							};
						};
					} forEach UPSMON_NPCs
				};
			
				if (((_supstatus != "") || _linkactivate || (_grp getVariable ["UPSMON_AMBUSHWAIT",time]) < time)
					|| ((!isNull _target && "Air" countType [_target] == 0)
						&& ((_targetdistance <= _ambushdistance)
						||(round ([getposATL _target,(_grp getVariable "UPSMON_Positiontoambush")] call UPSMON_distancePosSqr) < 10) 
						|| (_npc knowsabout _target > 3 && _ambush2)))) then
				{
					sleep ((random 0.5) + 1); // let the enemy then get in the area 
				
					if (UPSMON_Debug>0) then {diag_log format["%1: FIREEEEEEEEE!!! Gothit: %2 linkactivate: %3 Distance: %4 PositionToAmbush: %5 AmbushWait:%6 %7",_grpid,_supstatus,_linkactivate,(_targetdistance <= _ambushdistance),_target distance (_grp getVariable "UPSMON_Positiontoambush") < 20,_grp getVariable ["UPSMON_AMBUSHWAIT",time] < time,(_npc knowsabout _target > 3 && _ambush2)]};
			
					_npc setBehaviour "COMBAT";
					_npc setcombatmode "YELLOW";
					_grpstatus = "PURPLE";
				
					{
						if !(isNil "bdetect_enable") then {_x setVariable ["bcombat_task", nil];};
					} forEach units _grp;
				
					_grp setVariable ["UPSMON_AMBUSHFIRE",true];
								
					//No engage yet
					_grp setVariable ["UPSMON_grpmission","SUPPORT"];
				};	
			};
		
			case "FORTifY":
			{
				if (!(IsNull _target)) then
				{
					if (!(_grp getVariable ["UPSMON_Checkbuild",false])) then
					{
						if (behaviour _npc != "COMBAT") then {_npc setbehaviour "COMBAT"};
						[_grp,_dist] call UPSMON_unitdefend;
					
						if (_grp getVariable ["UPSMON_OrgGrpMission",""] != "FORTifY") then
						{
							if (_ratio > 1.2) then
							{
								_grp setVariable ["UPSMON_Grpmission","SUPPORT"];
							}
						};
					};
				}
				else
				{
					if (_grp getVariable ["UPSMON_OrgGrpMission",""] != "FORTifY") then
					{
						[_grp,(_grp getVariable "UPSMON_Attackpos"),_currpos] call UPSMON_GETINPATROLSRCH;
						_grpstatus = "YELLOW"
					};
				};
			};
		
			case "RETREAT":
			{
				if (!(_grp getVariable ["UPSMON_searchingpos",false])) then
				{
					if (_targetdist <= 50) then
					{
						_grp setVariable ["UPSMON_Grpmission","DEFEND"];
					};
				};
			};
		
			case "TRANSPORT":
			{
				if (count _assignedvehicle > 0) then
				{
					if (((_grp getVariable ["UPSMON_Transportmission",[]]) select 0) == "MoveToRP" || ((_grp getVariable ["UPSMON_Transportmission",[]]) select 0) == "LANDRP") then
					{
						_grouptransported = [_grp] call UPSMON_CheckTransported;
					
						if (!IsNull _grouptransported) then
						{
							if (!(_grp getVariable ["UPSMON_embarking",false])) then
							{
								if (_targetdist <= 50) then
								{
									_destination = (_grp getVariable ["UPSMON_Transportmission",[]]) select 1;
									if (((_grp getVariable ["UPSMON_Transportmission",[]]) select 0) == "MoveToRP") then
									{
										//Embark group in transport (LAND)
										[_grouptransported,_assignedvehicle,_destination] spawn UPSMON_getinassignedveh;
									};
									if (((_grp getVariable ["UPSMON_Transportmission",[]]) select 0) == "LANDRP") then
									{	
										if (_currpos select 2 <= 3) then
										{
											//Embark group in transport (HELI)
											[_grouptransported,_assignedvehicle,_destination] spawn UPSMON_getinassignedveh;
										};
									};
								};
							};					
						}
						else
						{
							//if there are nobody anymore to transport then return to base
							[_assignedvehicle select 0] call UPSMON_Returnbase;						
						};
					};
					
					if (_targetdist <= 100) then
					{
						if (((_grp getVariable ["UPSMON_Transportmission",[]]) select 0) == "LANDING" || ((_grp getVariable ["UPSMON_Transportmission",[]]) select 0) == "LANDBASE" || ((_grp getVariable ["UPSMON_Transportmission",[]]) select 0) == "LANDPZ") then
						{
							if (unitReady (driver (_assignedvehicle select 0)) || toUpper(landResult (_assignedvehicle select 0)) != "NOTREADY" || (landResult (_assignedvehicle select 0)) == "") then
							{
								//Make heli land and stop or land and be ready to move :)
								if (((_grp getVariable ["UPSMON_Transportmission",[]]) select 0) == "LANDING") then {if (((getposATL (_assignedvehicle select 0)) select 2) > 20) then {(_assignedvehicle select 0) land "GET OUT";}}; 
								if (((_grp getVariable ["UPSMON_Transportmission",[]]) select 0) == "LANDRP") then {if (((getposATL (_assignedvehicle select 0)) select 2) > 20) then {(_assignedvehicle select 0) land "GET IN";}};
								if (((_grp getVariable ["UPSMON_Transportmission",[]]) select 0) == "LANDBASE") then {(_assignedvehicle select 0) land "LAND";};
							};
						};
					};
				}
				else
				{
					_grp setVariable ["UPSMON_Transport",false];
					_grp setVariable ["UPSMON_Transportmission",[]]
				};
			};
					
			case "WAITTRANSPORT":
			{
				_grouptransported = [_grp] call UPSMON_CheckTransported;
				if (IsNull _grouptransported) then
				{
					[_grp,_grp getVariable ["UPSMON_TransportDest",[]],"MOVE",_formation,_speedmode,_behaviour,"YELLOW",1] spawn UPSMON_DocreateWP;
				};
			};
		
			case "SUPPLY":
			{
				if (true) then
				{
			
				};
			};
		
			case "RESUPPLY":
			{
		
			};
		
			case "PATROL":
			{
				_speedmode = Speedmode _npc;
				_behaviour = Behaviour _npc;
				_wpformation = Formation _npc;
					
				if (!(_grp getVariable ["UPSMON_InTransport",false])) then
				{
					
					if ("arti" in _typeOfgrp) then
					{
						if (!(_grp getVariable ["UPSMON_searchingpos",false])) then
						{
							if (_targetdist <= 10 && (_grp getVariable ["UPSMON_TIMEONTARGET",time] <= time)) then
							{
								_makenewtarget=true;
							};
						};
					}
					else
					{

						if (!(_grp getVariable ["UPSMON_searchingpos",false])) then
						{
							if (!(_grp getVariable ["UPSMON_embarking",false])) then
							{
								if (!(_grp getVariable ["UPSMON_Disembarking",false])) then
								{
									if (!([_targetpos,_areamarker] call UPSMON_pos_fnc_isBlacklisted) 
											|| _stuck
											|| _targetdist <= 5 
											//|| moveToFailed _driver 
											//|| Unitready _driver
											//|| moveToCompleted _driver 
											|| count(waypoints _grp) == 0 
											|| ((("tank" in _typeOfgrp) || ("ship" in _typeOfgrp) || ("apc" in _typeOfgrp) ||("car" in _typeOfgrp)) && _targetdist <= 25)
											|| (("air" in _typeOfgrp && !(_grp getVariable ["UPSMON_landing",false])) && (_targetdist <= 70 || Unitready _driver))) then
									{
										_makenewtarget=true;
									};
								};
							};
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
		
			case "FIREMISSION":
			{
				if (count _attackpos > 0 || count (_grp getVariable ["UPSMON_Artifiremission",[]]) > 0) then
				{
					if (_grp getVariable ["UPSMON_OnBattery",false]) then
					{
						if (!(_grp getVariable ["UPSMON_Batteryfire",false])) then
						{
							_artitarget = _attackpos;
							_firemission = "HE";
							_roundsask = 1;
							_area = 10;
							if (count (_grp getVariable ["UPSMON_Artifiremission",[]]) > 0) then
							{
								_artitarget = (_grp getVariable ["UPSMON_Artifiremission",[]]) select 0;
								_firemission = (_grp getVariable ["UPSMON_Artifiremission",[]]) select 1;
								_roundsask = (_grp getVariable ["UPSMON_Artifiremission",[]]) select 2;
								_area = (_grp getVariable ["UPSMON_Artifiremission",[]]) select 2;
							};
					
							[_grp,_artitarget,_area,_roundsask,_firemission] spawn UPSMON_artillerydofire;
						}
						else
						{
							if (_grp getVariable ["UPSMON_RoundsComplete",false]) then
							{
								[_grp] call UPSMON_BackToNormal;
								_grp setVariable ["UPSMON_OnBattery",false];
								_grp setVariable ["UPSMON_RoundsComplete",false];
							};
						};
					};
				}
				else
				{
					if (_grp getVariable ["UPSMON_RoundsComplete",false]) then
					{
						[_grp] call UPSMON_BackToNormal;
						_grp setVariable ["UPSMON_OnBattery",false];
						_grp setVariable ["UPSMON_RoundsComplete",false];
					};			
				};
			};
		
			case "RELAX":
			{
				[_grp,_areamarker] call UPSMON_DORELAX;
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
///////////////////////////////////////////////////////////////////////////
///////////					Disembarking 				//////////////////
//////////////////////////////////////////////////////////////////////////
		
			if (!(_grp getVariable ["UPSMON_disembarking",false])) then
			{
				if (!(_grp getVariable ["UPSMON_searchingpos",false])) then
				{
					if (_targetpos select 0 != 0 && _targetpos select 1 != 0) then 
					{
						if (count _assignedvehicle > 0) then
						{
							[_grp,_assignedvehicle,_dist,_targetdist,_supstatus] call UPSMON_Disembarkment;
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
			};// !NOWP
		
			if (({alive _x && !(captive _x)} count units _grp) == 0 ||  _grp getVariable ["UPSMON_Removegroup",false]) exitWith
			{
				[_grp,_UCthis] call UPSMON_RESPAWN;
			}; 	
		
			_grp setVariable ["UPSMON_Lastinfos",[_currpos,_targetpos]];
			_grp setVariable ["UPSMON_lastOpfknowval",_opfknowval];
			_grp setVariable ["UPSMON_LastGrpmission",_grp getVariable ["UPSMON_Grpmission",""]];
		
			sleep 0.1;
		};
		
	} forEach UPSMON_NPCs;
	
	if (ObjNull in UPSMON_NPCs) then {UPSMON_NPCs = UPSMON_NPCs - [ObjNull]};
	sleep _cycle;
};