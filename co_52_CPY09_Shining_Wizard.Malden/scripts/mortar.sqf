// By: 2600K
// Simple, fair mortar script. Only engages known targets.
// Usage - Put in INIT of artillery unit:
// _nul = [this] execVM "scripts\mortar.sqf";
if !isServer exitWith {};

sleep 5;

params ["_mortar"];

_minDelay = 160; // Minimum delay between missions (maximum is 2x value).
_maxDispersion = 300; // Maximum target dispersion in meters.

while {alive _mortar && canFire _mortar} do {
	// Get target that is alive, in distance, known as enemy and not flying.
	_targetArr = (playableUnits + switchableUnits) select {alive _x && _x distance2D _mortar < 3500 && (side _mortar knowsAbout _x) >= 1 && isTouchingGround _x};
	_sleepTime = 5;
	
	// Fire rounds if we have targets.
	if (count _targetArr > 0) then {
		_target = selectRandom _targetArr;
		
		for "_i" from 0 to (4 + random 4) do {
			_firePos = [_target, random _maxDispersion, random 360] call BIS_fnc_relPos;
			_mortar commandArtilleryFire [_firePos, (getArtilleryAmmo [_mortar] select 0), 1];
			sleep 5;
		};
		
		// Mission complete, so wait a while.
		_sleepTime = _minDelay + random _minDelay;
	};
	
	// Refill any spent ammo.
	_mortar setVehicleAmmo 1;
	
	// Wait for next mission.
	sleep _sleepTime;
};