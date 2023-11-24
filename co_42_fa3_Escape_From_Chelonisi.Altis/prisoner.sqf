_this setCaptive true;
_this spawn {
    sleep .1; // i hate arma
    _this setCaptive true;
};

if (isServer) then {
    if (isNil "prisoners") then {prisoners = [];};
    prisoners pushBack _this;
};

waitUntil {count weapons _this > 0};

_this setCaptive false;