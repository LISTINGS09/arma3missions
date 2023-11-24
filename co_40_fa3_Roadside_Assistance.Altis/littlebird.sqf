if (!isServer) exitWith {};

_this removeWeaponTurret ["missiles_DAR",[-1]];

_this addWeaponTurret ["missiles_SCALPEL",[-1]];
_this addMagazineTurret ["2Rnd_LG_scalpel",[-1]];

_this disableTIEquipment true;