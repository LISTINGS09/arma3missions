if (!isServer) exitWith {};

while {alive _this} do {
    sleep (20 + random 20);
    playSound3d [format ["A3\Sounds_f\sfx\radio\ambient_radio%1.wss",2 + floor random 20],_this,true,getPosASL _this,1];
};