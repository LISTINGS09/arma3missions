params[["_msg","No Message",[""]],["_types","General",["",[]]],["_data",[]]];

if(isNil("A3E_DebugLog")) then {
	A3E_DebugLog = [];
};
if(count A3E_DebugLog > (missionNameSpace getVariable ["A3E_MaxLogMessages",100])) then {
	A3E_DebugLog deleteAt 0;
};

private _filter = (missionNameSpace getVariable ["A3E_DebugLogFilter",[]]);
if(_types isEqualType "") then
{
	_types = [_types];
};

A3E_DebugLog append [[_types,_msg,time,_data]];

//Write to Chat/rpt if Debug is on
if(	(missionNameSpace getVariable ["A3E_Debug",false] && ({_x in _types} count _filter) == 0 )
	|| (!(missionNameSpace getVariable ["A3E_Debug",false]) && ({_x in _types}count _filter) > 0 )
	) then {
	[format["Log: %1 %2 %3", _msg, _types, _data]] call a3e_fnc_systemChat;
	[format["Escape: %1 - %2 %3", _msg, _types, _data]] call a3e_fnc_rptLog;
};