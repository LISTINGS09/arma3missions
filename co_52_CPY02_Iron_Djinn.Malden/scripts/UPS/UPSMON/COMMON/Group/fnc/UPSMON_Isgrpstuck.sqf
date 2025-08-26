/****************************************************************
File: UPSMON_Isgrpstuck.sqf
Author: Azroul13

Description:
	Check if the group is stuck
Parameter(s):

Returns:
	boolean
****************************************************************/

private ["_npc","_lastcurrpos","_currpos","_grp","_stuck","_rstuckControl"];

_npc = _this select 0;
_lastcurrpos = _this select 1;
_currpos = _this select 2;
_grp = group _npc;	
_stuck = false;

//Stuck control
if (alive _npc) then
{
	if (canMove _npc) then
	{
		if (!((vehicle _npc) isKindOf "air")) then
		{
			if (_grp getVariable ["UPSMON_NOWP",0] == 0) then
			{
				if (_lastcurrpos select 0 == _currpos select 0 && _lastcurrpos select 1 == _currpos select 1) then
				{
					//time > _grp getVariable ["UPSMON_TIMEONTARGET",time]
					if (_grp getVariable ["UPSMON_Grpmission",""] != "DEFEND") then
					{
						if (_grp getVariable ["UPSMON_Grpmission",""] != "FORTifY") then
						{
							if (_grp getVariable ["UPSMON_Grpmission",""] != "AMBUSH") then
							{
								if (!(_npc getVariable ["UPSMON_searchingpos",false])) then
								{
									if (!(_grp getVariable ["UPSMON_movetolanding",false])) then
									{
										if (!(_grp getVariable ["UPSMON_embarking",false])) then 
										{
											if (!((vehicle _npc) getVariable ["UPSMON_disembarking",false])) then
											{
												_rstuckControl = (_grp getVariable ["UPSMON_RSTUCKCONTROL",0]) + 1;
												_grp setVariable ["UPSMON_RSTUCKCONTROL",_rstuckControl];
								
												if (_rstuckControl >= 10) then 
												{
													//[_npc] call UPSMON_cancelstop;
													//{if (alive _x && leader _x != _x) then {_x dofollow (leader _x)};} forEach units _grp;
													_grp setVariable ["UPSMON_RSTUCKCONTROL",0];
													_stuck = true;
		
													if (UPSMON_Debug>0) then {player sidechat format["%1 stucked, moving",_grp getVariable ["UPSMON_Grpid",0]]};	
													if (UPSMON_Debug>0) then {diag_log format["%1 stuck for %2 seconds - trying to move again",_grp getVariable ["UPSMON_Grpid",0]]};
												};
											};
										};
									};
								};
							};
						};
					};
				};
			};
		};
	};
};

_stuck