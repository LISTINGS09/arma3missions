/****************************************************************
File: UPSMON_supstatestatus.sqf
Author: Azroul13

Description:
	Check if the group is under fire
	Activated only when TPWCAS script is present 
Parameter(s):
	<--- unit
Returns:
	Boolean
****************************************************************/
	//Check if the group is under fire
private ["_grp","_supstatus","_unitsnbr","_tpwcas_running","_statuslist"];

_grp = _this select 0;
_supstatus = "";

_unitsnbr = count (units _grp);
_tpwcas_running = if (!isNil "tpwcas_running") then {true} else {false};
_statuslist = [];
{
	if (alive _x) then
	{
		_x setVariable ["UPSMON_SUPSTATUS",""];
		if (_x in UPSMON_GOTHIT_ARRAY) then
		{
			UPSMON_GOTHIT_ARRAY = UPSMON_GOTHIT_ARRAY - [_x];
			if (damage _x < 0.3) then
			{
				_statuslist pushBack "hit";
			}
			else
			{
				_statuslist pushBack "wounded";
			};
			
			_x setVariable ["UPSMON_SUPSTATUS","UNDERFIRE"];
		};
		
		if (_tpwcas_running) then
		{
			if (_x getVariable "tpwcas_supstate" == 3) then 
			{
				_statuslist pushBack "supressed";
				_x setVariable ["UPSMON_SUPSTATUS","SUPRESSED"];
			};
			if (_x getVariable "tpwcas_supstate" == 2) then 
			{
				_statuslist pushBack "hit";
				_x setVariable ["UPSMON_SUPSTATUS","UNDERFIRE"];
			};
		};
		
		if (isNil "bdetect_enable") then
		{ 
			if (_x getVariable ["bcombat_suppression_level", 0] >= 20 && _x getVariable ["bcombat_suppression_level", 0] < 75) then
			{
				_statuslist pushBack "hit";
				_x setVariable ["UPSMON_SUPSTATUS","UNDERFIRE"];
			};
			if (_x getVariable ["bcombat_suppression_level", 0] >= 75) then
			{
				_statuslist pushBack "supressed";
				_x setVariable ["UPSMON_SUPSTATUS","SUPRESSED"];
			};
		};
	}
	else
	{
		if (_x in UPSMON_GOTKILL_ARRAY) then
		{
			UPSMON_GOTKILL_ARRAY = UPSMON_GOTKILL_ARRAY - [_x];
			_statuslist pushBack "dead";
		};
	};
} forEach units _grp;

if ({_x == "supressed" || _x == "wounded" ||  _x == "dead"} count _statuslist >= _unitsnbr) then
{
	if ({_x == "supressed"} count _statuslist < {_x == "wounded" || _x == "dead"} count _statuslist) then
	{
		_supstatus = "INCAPACITED"
	}
	else
	{
		_supstatus = "SUPRESSED"
	};
};

if (_supstatus == "") then
{
	if ("hit" in _statuslist || "wounded" in _statuslist || "dead" in _statuslist || "supressed" in _statuslist) then
	{
		_supstatus = "UNDERFIRE"
	};
};

_supstatus