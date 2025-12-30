// Build start position
private _fenceRotateDir = random 360;

private _backPack = (selectRandom (missionNameSpace getVariable ["a3e_arr_PrisonBackpacks", ["B_AssaultPack_khk"]])) createVehicle A3E_StartPos;

private _template = selectRandom(["a3e_fnc_BuildPrison", "a3e_fnc_BuildPrison1", "a3e_fnc_BuildPrison2", "a3e_fnc_BuildPrison3", "a3e_fnc_BuildPrison4", "a3e_fnc_BuildPrison5"]);

[A3E_StartPos, _fenceRotateDir, _backPack] remoteExec [_template, 0, true];

missionNameSpace setVariable ["A3E_FenceIsCreated", true, true];

_backPack;