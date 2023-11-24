_dump = _this select 0;
_radius = _this select 1;

{deleteVehicle _x} forEach ([format["dump%1", _dump]] call ws_fnc_collectObjects);

dumpsDestroyed = dumpsDestroyed + 1;
hint format ["Ammo dump %1 destroyed!", dumpsDestroyed];

_dumpLocs = [dumponeLoc, dumptwoLoc, dumpthreeLoc, dumpfourLoc, dumpfiveLoc];
[_dumpLocs select (_dump - 1), _radius] spawn secondaryExplosions;