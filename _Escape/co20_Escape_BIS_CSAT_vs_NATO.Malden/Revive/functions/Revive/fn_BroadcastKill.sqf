params["_unit", "_killer", "_projectile"];

if((side _unit == side _killer) && (_unit != _killer)) then {
	private _inGameMsg = format["%1 was shot by %2.",name _unit, name _killer];
	_inGameMsg remoteExec ["systemchat", 0, false];

	private _currentWeapon = currentWeapon _killer;
	private _distance = _killer distance _unit;
	diag_log format["Teamkill Report: %1 was shot by %2 with %3 (projectile %4) from %5 meters", name _unit, name _killer, _currentWeapon, _projectile, _distance];
} else {
	private _msg = format["%1 is unconscious.",name _unit];
	_msg remoteExec ["systemchat", 0, false];
};