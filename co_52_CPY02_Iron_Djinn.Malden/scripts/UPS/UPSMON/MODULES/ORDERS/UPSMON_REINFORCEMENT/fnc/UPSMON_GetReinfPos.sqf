/****************************************************************
File: UPSMON_GetReinfPos.sqf
Author: Azroul13

Description:
	The script will assign a combat waypoint to the group

Parameter(s):
	<--- Group
	<--- lastposition
Returns:
	nothing
****************************************************************/

private ["_grp","_lastpos","_fixedtargetpos","_rfidcalled"];
	
_grp = _this select 0;
_lastpos = _this select 1;

_fixedtargetpos = [];
_rfidcalled = false;

if (!(isnil (compile format ["UPSMON_reinforcement%1",_grp getVariable ["UPSMON_RFID",0]]))) then 
{
	_rfidcalled= call (compile format ["UPSMON_reinforcement%1",_grp getVariable ["UPSMON_RFID",0]])
};


if (UPSMON_reinforcement || _rfidcalled) then
{
	if (_grp getVariable ["UPSMON_Reinforcement",false]) then
	{
		if (!(_grp getVariable ["UPSMON_ReinforcementSent",false])) then
		{			
			if (_rfidcalled) then 
			{
				_fixedtargetPos = call (compile format ["UPSMON_reinforcement%1_pos",_grp getVariable ["UPSMON_RFID",0]]); // will be position os setfix target of sending reinforcement
				if (isnil "_fixedtargetPos") then 
				{
					_fixedtargetPos = [];
				}
				else
				{
					_fixedtargetPos =  [_fixedtargetPos select 0,_fixedtargetPos select 1,0];
				};
			} 
			else 
			{
				_fixedtargetPos = _grp getVariable ["UPSMON_PosToRenf",[]];
			};
				
			if (count _fixedtargetPos > 0) then
			{
				if (_fixedtargetPos select 0 != 0 && _fixedtargetPos select 1 != 0) then 
				{ 
					_grp setVariable ["UPSMON_ReinforcementSent",true];
					_grp setVariable ["UPSMON_Grpmission","REINFORCEMENT"];
					_grp setVariable ["UPSMON_NOWP",0];
					[_grp,_fixedtargetPos,"MOVE","COLUMN","FULL","AWARE","YELLOW",1] spawn UPSMON_DocreateWP;
				};
			};
			if (UPSMON_Debug>0) then {player sidechat format["%1 called for reinforcement %2 %3",_grp getVariable ["UPSMON_Grpid",0],_fixedtargetPos,_grp getVariable ["UPSMON_ReinforcementSent",false]]};	
		};
	};
};

_fixedtargetpos
