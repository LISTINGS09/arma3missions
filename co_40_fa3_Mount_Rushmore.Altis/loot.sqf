if (!isServer) exitWith {};

_lootTable = [
    ["30Rnd_556x45_Stanag",6],
    ["30Rnd_556x45_Stanag_Tracer_Red",4],
    ["1Rnd_HE_Grenade_shell",2],
    ["1Rnd_Smoke_Grenade_shell",2],
    ["HandGrenade",2],
    ["MiniGrenade",2],
    ["SmokeShell",2],
    ["SmokeShellGreen",2],
    ["Chemlight_blue",2],
    ["200Rnd_65x39_cased_Box",2],
    ["200Rnd_65x39_cased_Box_Tracer",2],
    ["16Rnd_9x21_Mag",4],
    ["NLAW_F",1]
];

for '_i' from 1 to 4 + floor random 4 do {
    _loot = _lootTable call BIS_fnc_selectRandom;
    _this addMagazineCargoGlobal [_loot select 0,ceil random (_loot select 1)];
};