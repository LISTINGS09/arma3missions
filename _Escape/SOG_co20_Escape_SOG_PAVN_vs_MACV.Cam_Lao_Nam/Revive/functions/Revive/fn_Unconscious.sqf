params["_unit",["_instant",false]];

private _inVehicle = (vehicle _unit != _unit);

_unit setvariable ["ATR_UnconsciousTransition",true];
_unit setvariable ["ATR_UnconsciousInVehicle",_inVehicle];

if(!_inVehicle && !_instant) then {
	if(isWeaponDeployed _unit) then {
		_player setPos (_player modelToWorld [0,0,0]);
	};
	_ragdoll = [_unit] spawn ATR_FNC_ragdoll;
} else {
	private["_vehicle"];
	_vehicle = vehicle _unit;
	if(getdammage _vehicle < 1) then {
		[_unit] call ATR_FNC_SwitchVehicleDeadAnimation;
	} else {
		moveOut _unit;
		if(!_instant) then {
			_ragdoll = [_unit] spawn ATR_FNC_ragdoll;
		};
	};
};

_unit setDamage 0.9;
_unit setVelocity [0,0,0];
_unit allowDammage false;
_unit setCaptive true;

if(surfaceIsWater getpos _unit && ((getPosASL _unit) select 2)<1 && (vehicle _unit == _unit)) then {
	[_unit] call ATR_FNC_WashAshore;
};

if(AT_Revive_Camera==1 && _unit==player) then {
	[] spawn ATHSC_fnc_createCam;
};


[_unit,_instant] spawn {
	params["_unit","_instant"];
	private ["_ragdoll"];
	sleep 0.5;
	while{_unit getvariable ["ATR_UnconsciousTransition",false]} do {
		if(!(_unit getvariable ["ATR_Ragdolling",false])) then
		{
			if(surfaceIsWater getpos _unit && ((getPosASL _unit) select 2)<1 && (vehicle _unit == _unit)) then {
				[_unit] call ATR_FNC_WashAshore;
			};
			_unit setvariable ["ATR_UnconsciousTransition",false];
		};
	};

	if(_instant) then {
		[_unit,"AinjPpneMstpSnonWnonDnon"] remoteExec ["ATR_fnc_unconsciousAnimation", 0, false];
		sleep 0.2;
	};


	
	while { !isNull _unit && alive _unit && (_unit getVariable "AT_Revive_isUnconscious")} do
	{
		
		if(vehicle _unit == _unit && (_unit getvariable ["ATR_UnconsciousInVehicle",false])) then {
			_unit setvariable ["ATR_UnconsciousInVehicle",false];
			_ragdoll = [_unit] spawn ATR_FNC_ragdoll;
			waituntil{scriptDone _ragdoll};
			sleep 0.25;
		};
		if(vehicle _unit != _unit && !(_unit getvariable ["ATR_UnconsciousInVehicle",false])) then {
			_unit setvariable ["ATR_UnconsciousInVehicle",true];
			[_unit] call ATR_FNC_SwitchVehicleDeadAnimation;
			sleep 0.25;
		};
		sleep 0.5;
	};
	

	private _pos = getposATL _unit;

	
	private _reviveStats = missionNamespace getvariable ["A3E_Revive_Count",0];
	missionNamespace setvariable ["A3E_Revive_Count",_reviveStats+1,true];

	_unit allowDamage true;
	_unit setCaptive false;
	_unit setPosATL _pos; 
	sleep 0.1;
	[_unit,"AmovPpneMstpSnonWnonDnon",false] remoteExec ["ATR_fnc_unconsciousAnimation", 0, false];

	
	if(missionNamespace getvariable["ATHSC_Run",false]) then {
		[] call athsc_fnc_exit;
	};

};