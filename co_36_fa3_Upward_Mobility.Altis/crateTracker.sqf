if (!isServer) exitWith {};
_boxes = [box] call ws_fnc_collectObjectsNum;

boxesCollected = 0;

sleep 30;

while {true} do {
    boxesCollected = {_x distance dropoff < 25} count _boxes;
    [format ["%1/%2 boxes collected",boxesCollected,count _boxes],"hintSilent"] call BIS_fnc_MP;
    sleep 5;
};