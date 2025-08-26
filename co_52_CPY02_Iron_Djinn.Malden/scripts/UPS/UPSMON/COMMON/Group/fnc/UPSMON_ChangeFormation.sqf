/****************************************************************
File: UPSMON_SetStances.sqf
Author: Azroul13

Description:

Parameter(s):

Returns:

****************************************************************/

private ["_grp","_supstatus","_attackpos","_dist","_terrainscan","_haslos","_time"];

_grp = _this select 0;
_supstatus = _this select 1;
_attackpos = _this select 2;
_dist = _this select 3;
_terrainscan = _this select 4;
_haslos = _this select 5;
_typeOfgrp = _this select 6;

if (!(_grp getVariable ["UPSMON_haschangedformation",false])) then
{
	_grp setVariable ["UPSMON_haschangedformation",true];
	if ("air" in _typeOfgrp) then
	{
		if ((Speedmode _grp) != "FULL") then
		{
			_grp setspeedmode "FULL";
		};
	}
	else
	{
		if (_supstatus != "SUPRESSED") then
		{
			if (count _attackpos > 0) then
			{
				if (_dist > 500 || !_haslos) then
				{
					if (vehicle (leader _grp) == (leader _grp)) then
					{
						if ((Speedmode _grp) != "NORMAL") then
						{
							_grp setspeedmode "NORMAL";
						};
						if (_dist < 200) then
						{
							if ((Formation _grp) != "LINE") then
							{
								_grp setformation "LINE";
							};
						}
						else
						{
							if ((Formation _grp) != "STAG COLUMN") then
							{
								_grp setformation "STAG COLUMN";
							};
						};
					};
				}
				else
				{
					if (_dist > 150) then
					{
						if (!(Behaviour (leader _grp) in ["COMBAT","STEALTH"])) then
						{
							_grp setBehaviour "COMBAT";
						};
					
						if ((Formation _grp) != "WEDGE") then
						{
							_grp setformation "WEDGE";
						};
					};
				
					if (_dist <= 150) then
					{
						if ((_terrainscan select 0) == "forest" || (_terrainscan select 0) == "inhabited") then
						{				
							if ((Speedmode _grp) != "LIMITED") then
							{
								_grp setspeedmode "LIMITED";
							};
						
							if ((_terrainscan select 0) == "inhabited") then
							{
								if ((_terrainscan select 1) > 230) then
								{
									if ((Formation _grp) != "STAG COLUMN") then
									{
										_grp setformation "STAG COLUMN";
									};
								};
							};
						};
						
						if ((_terrainscan select 0) == "meadow") then
						{
							if ((Speedmode _grp) != "FULL") then
							{
								_grp setspeedmode "FULL";
							};
							if ((Formation _grp) != "LINE") then
							{
								_grp setformation "LINE";
							};							
						};
					};
				};
			};
		}
		else
		{
			if (_supstatus != "") then
			{
				if ((behaviour (leader _grp)) != "COMBAT") then
				{
					(leader _grp) setbehaviour "COMBAT";
				};
		
				if ((_terrainscan select 0) == "meadow") then
				{
					if (Speedmode _grp != "NORMAL") then
					{
						_grp setspeedmode "NORMAL";
					};
				};
		
				if ((_terrainscan select 0) == "forest" || (_terrainscan select 0) == "inhabited") then
				{
					if ((Speedmode _grp) != "LIMITED") then
					{
						_grp setspeedmode "LIMITED";
					};
			
					if ((Formation _grp) != "DIAMOND") then
					{
						_grp setformation "DIAMOND";
					};			
				};
			}
			else
			{
				if ((Speedmode _grp) != "LIMITED") then
				{
					_grp setSpeedmode "LIMITED";
				};	
				
				if ((Behaviour (leader _grp)) != "STEALTH") then
				{
					_grp setBehaviour "STEALTH";
				};
			};
		};
	};
};

[_grp] spawn 
{
	private ["_grp"];
	
	_grp = _this select 0;
	
	sleep 20;
	if (!IsNull _grp) then
	{
		_grp setVariable ["UPSMON_haschangedformation",false];
	};
};