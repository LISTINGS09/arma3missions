private ["_grp","_unit","_currpos","_lastpos","_timeontarget","_time","_civnear","_position","_positionfound","_rnd"];

_grp = _this select 0;
_areamarker = _this select 1;

{
	if (alive _x) then
	{
		if (canMove _x) then
		{
			if (vehicle _x == _x) then
			{
				if (!(fleeing _x)) then
				{
					if (!(captive _x)) then
					{
						_unit = _x;
						_currpos = getposATL _x;
						_lastpos = _unit getVariable ["UPSMON_lastpos",[0,0]];
						_timeontarget = time;
						_destination = _unit getVariable ["UPSMON_Destination",[]];
						
						if (count (_unit getVariable ["UPSMON_Destination",[]]) == 0) then
						{
							_destination = _currpos;
						};
				
						if (_unit getVariable ["UPSMON_Wait",time] <= time && !(_unit getVariable ["UPSMON_Civfleeing",false])) then
						{
							if (_unit getVariable ["UPSMON_Civdisable",false]) then
							{
								_unit switchmove "";
								_unit enableAI "MOVE";
								_unit setVariable ["UPSMON_Civdisable",false];
							};
							
							if (!IsNull (_unit getVariable ["UPSMON_fireplace",ObjNull])) then
							{
								Deletevehicle (_unit getVariable ["UPSMON_fireplace",ObjNull]);
							};
						
							_position = [];
							if (random 100 < 25 && !(IsOnroad _currpos) && ((overcast < 0.5 || rain == 0) || ([_unit] call UPSMON_Inbuilding))) then
							{
								_civnear = ObjNull;
								
								_civsnear = [(nearestObjects [_unit, ["CAManBase"], 10]), {(side _x == (side _unit)) && (alive _x) && (_x getVariable ["UPSMON_Civdisable",false])} ] call BIS_fnc_conditionalSelect;
								
								if (count _civsnear > 0) then
								{
									_civnear = _civsnear select 0;
								};
								
								if (random 100 < 12 && !IsNull _civnear) then
								{
									_timeontarget = time + 120;
									if (UPSMON_Debug > 0) then {[_currpos,"ICON","hd_dot","ColorYellow",0] call UPSMON_createmarker;};
									_unit setVariable ["UPSMON_Civdisable",true];
									["TALK",_unit,_civnear] spawn UPSMON_Civaction;
								}
								else
								{
									_timeontarget = time + 70;
									_unit disableAI "MOVE";
									_unit setVariable ["UPSMON_Civdisable",true];
									["SIT",_unit] spawn UPSMON_Civaction;
								};
								_unit setVariable ["UPSMON_wait",_timeontarget];
							}
							else
							{
								if ((_destination vectordistance _currpos <= 1) || (_unit getVariable ["UPSMON_Utimeontarget",time] <= time)) then
								{
									if (random 100 <= 45) then 
									{
										_bldpositions = [_currpos,"RANDOMDN"] call UPSMON_GetNearestBuilding;
							
										if (count _bldpositions > 0) then
										{
											_bldpos = _bldpositions select 1;
											_position = _bldpos select 0;
										};
									};
									if (count _position == 0) then {_position = [_areamarker,0,[],1] call UPSMON_pos;};
									if (count _position > 0) then
									{
										if (!(IsOnroad _position)) then
										{
											_unit setVariable ["UPSMON_destination", _position, false];
											_unit setVariable ["UPSMON_lastpos",_currpos];
											if (UPSMON_Debug > 0) then {[_position,"ICON","hd_dot","ColorRed",0] call UPSMON_createmarker;};
											_timeontarget = time + (1.6*(_currpos vectordistance _position)); 
											Dostop _unit;
											_unit domove _position;
											_unit setDestination [_position, "LEADER PLANNED", true];
										};
									};
								};
								_unit setVariable ["UPSMON_Utimeontarget",_timeontarget];	
							};
						};
					};
				};
			};
		};
	};
	sleep 0.2;
} forEach units _grp;