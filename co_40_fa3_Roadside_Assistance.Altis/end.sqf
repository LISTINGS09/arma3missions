if (!isServer) exitWith {};

["Alert",[format ["Hostages rescued: %1/12",{alive _x} count hostages]]] remoteExec ["BIS_fnc_showNotification"];
sleep 2;

if ({alive _x} count hostages > 8) then {
    [1] call f_fnc_mpEnd;
} else {
    [3] call f_fnc_mpEnd;
};