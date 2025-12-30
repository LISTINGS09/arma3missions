private _worldCenter = worldSize / 2;
//systemChat "Reset detection triggers";

missionNameSpace setVariable ["A3E_var_PlayerCanBeDetected",true];

private _opforTrigger = missionNameSpace getVariable["A3E_OpforDetectionTrigger",objNull];
	
if(!isNull _opforTrigger) then { deletevehicle _opforTrigger };	
	
_opforTrigger = createTrigger["EmptyDetector", [_worldCenter, _worldCenter, 0],false];
_opforTrigger setTriggerInterval 5;
_opforTrigger setTriggerArea[_worldCenter, _worldCenter, 0, true];
_opforTrigger setTriggerActivation[A3E_VAR_Side_Blufor_Str, A3E_VAR_Side_Opfor_Str+" D", false];
_opforTrigger setTriggerStatements["this && A3E_var_PlayerCanBeDetected", format["[""%1""] spawn A3E_FNC_ReportToHQ;",str A3E_VAR_Side_Opfor], ""];

missionNameSpace setVariable["A3E_OpforDetectionTrigger",_opforTrigger];

private _indepTrigger = missionNameSpace getVariable["A3E_IndepDetectionTrigger",objNull];
	
if(!isNull _indepTrigger) then { deletevehicle _indepTrigger };	

_indepTrigger = createTrigger["EmptyDetector", [_worldCenter, _worldCenter, 0],false];
_indepTrigger setTriggerInterval 5;
_indepTrigger setTriggerArea[_worldCenter, _worldCenter, 0, true];
_indepTrigger setTriggerActivation[A3E_VAR_Side_Blufor_Str, A3E_VAR_Side_Ind_Str+" D", false];
_indepTrigger setTriggerStatements["this && A3E_var_PlayerCanBeDetected", format["[""%1""] spawn A3E_FNC_ReportToHQ;",str A3E_VAR_Side_Ind], ""];

missionNameSpace setVariable["A3E_IndepDetectionTrigger",_indepTrigger];