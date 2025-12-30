params ["_unit", "_bodyPart", "_amountOfDamage", "_killer", "_projectile", "_hitIndex", "_instigator", "_hitPoint", "_directHit", "_context"];
if(_unit getVariable ["AT_Revive_isUnconscious",false]) then {
	_amountOfDamage = 0;
} else {
	if ((_amountOfDamage >= 1) 
		&& {_bodyPart in ["","head","face_hub","head_hit","neck","spine1","spine2","spine3","pelvis","body"]}
	) then {
		_unit setVariable ["AT_Revive_isUnconscious", true, true];
		_unit allowDamage false;
		_unit setDamage 0;
		[_unit] spawn ATR_FNC_Unconscious;
		[_unit, _killer, _projectile] call ATR_FNC_BroadcastKill;
		_amountOfDamage = 0;
	};
};
_amountOfDamage;
