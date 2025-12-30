private _inCam = missionNamespace getvariable["ATHSC_Run",false];
if(_inCam) then {
	openMap [false,false];
	missionNamespace setvariable["ATHSC_Run",false];
	
	[] spawn {
		"HSC" cutFadeOut 0;
		("HSC" call BIS_fnc_rscLayer) cutText ["","PLAIN"]; //remove
		[] spawn {
			cutText ["", "BLACK OUT",0.5];
			sleep 0.5;
			cutText ["", "BLACK IN",0.5];
			sleep 0.5;
		};
		sleep 0.5;
		if(!isNull ATHSC_Cam) then {
			ATHSC_Cam cameraEffect ["terminate","back"];
			camDestroy ATHSC_Cam;
			ATHSC_Cam = objNull;

		};
		player switchCamera "Internal";
	};
	private _keh = missionNamespace getvariable ["ATHSC_KeyDownHandler", -1];
	if(_keh >= 0) then {
		(findDisplay 46) displayRemoveEventHandler ["keyDown", _keh];
		ATHSC_KeyDownHandler = nil;
	};
	_keh = missionNamespace getvariable ["ATHSC_MouseHandler", -1];
	if(_keh >= 0) then {
		(findDisplay 46) displayRemoveEventHandler ["mouseMoving", _keh];
		ATHSC_MouseHandler = nil;
	};
	_keh = missionNamespace getvariable ["ATHSC_MouseZHandler", -1];
	if(_keh >= 0) then {
		(findDisplay 46) displayRemoveEventHandler ["mouseZChanged", _keh];
		ATHSC_MouseZHandler = nil;
	};
};