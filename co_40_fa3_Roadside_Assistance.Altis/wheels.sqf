if (!isServer) exitWith {};

_wheels = [];
_glass = [];
{
    if (["wheel",_x] call BIS_fnc_inString) then {
        _wheels append [_x];
    };
    if (["glass",_x] call BIS_fnc_inString) then {
        _glass append [_x];
    };
} forEach (getAllHitPointsDamage _this select 0);

for "_i" from 1 to 4 do {
    _this setHitPointDamage [_wheels call BIS_fnc_selectRandom,1];
};
_this setHitPointDamage ["HitEngine",1];
_this setHitPointDamage ["HitBody",.8];
_this setHitPointDamage ["HitFuel",.8];
for "_i" from 1 to 2 do {
    _this setHitPointDamage [_glass call BIS_fnc_selectRandom,1];
};