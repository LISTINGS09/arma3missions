params["_unit"];
_unit setvariable ["ATR_Ragdolling",true];

private _group = creategroup (side _unit);
[_unit, true] remoteExec ["hideObject", 0, false];
private _dummy = _group createUnit [typeof _unit, [0,0,0], [], 0, "FORM"];
if(!isNull _dummy) then {
	_dummy setposASL getPosASL _unit;
	_dummy setdir getdir _unit;
	_dummy setVelocity velocity _unit;
	private _state = animationState _unit;
	[_dummy,_unit] spawn ATR_FNC_copyGear;
	[_dummy, _state] remoteExec ["ATR_fnc_unconsciousAnimation", 0, false];
	_dummy setdammage 1;
	if(_unit==player) then {
		_dummy switchCamera "Internal";
	};
	
	for[{_i=0},{_i<50},{_i=_i+1}] do {
		if(((_dummy selectionPosition "Neck") select 2)<0.2 && _i>25) then {
			_i = 50;
			sleep 0.5;
		};
		sleep 0.1;
	};

	[_unit, false] remoteExec ["hideObject", 0, false];
	
	[_unit, "AinjPpneMstpSnonWrflDnon"] remoteExec ["ATR_fnc_unconsciousAnimation", 0, false];

	if((getpos _unit select 2) > 2) then {
		_unit setpos ((getpos _unit) set [2,0]);
	};
	if(_unit == player) then {
		player switchCamera "Internal";
	};
	_dummy setpos [0,0,0];
	deletevehicle _dummy;
};

[_unit, "AinjPpneMstpSnonWrflDnon"] remoteExec ["switchMove", 0, false];

_unit setvariable ["ATR_Ragdolling",false];