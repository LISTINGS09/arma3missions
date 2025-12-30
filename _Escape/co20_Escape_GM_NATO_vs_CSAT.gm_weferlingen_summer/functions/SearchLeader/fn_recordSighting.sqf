params["_reporter","_reported"];
//[format["This is %1 of squad %2. Reporting an enemy at %3. Looks like %4.",name _reporter, str(group _reporter),mapGridPosition _reported,name _reported]] remoteexec ["systemChat",0];
private _knowledge = _reporter targetKnowledge _reported;
_knowledge params ["_knownByGroup", "_knownByUnit", "_lastSeen", "_lastThreat", "_side", "_errorMargin", "_position"];

if !(_position isEqualTo [0,0,0]) then { [_position,_errorMargin] call A3E_fnc_CreateKnownPosition };

[] spawn {
	sleep 60;
	[] call A3E_fnc_PlayerDetection;
};