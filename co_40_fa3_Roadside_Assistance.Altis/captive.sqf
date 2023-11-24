captivesFree = [];

if (isServer) then {
    {
		removeFromRemainsCollector [_x];
        _x setCaptive true;
        _x disableAI "TARGET";
        _x disableAI "AUTOTARGET";
        _x disableAI "MOVE";
        _x spawn {
            waitUntil {_this in captivesFree};
            _this setCaptive false;
            _this enableAI "MOVE";
        };
        _x spawn {
            _anim = "Acts_AidlPsitMstpSsurWnonDnon05";
            _this playMove _anim;
            waitUntil {_this in captivesFree};
            _this playMoveNow "Acts_AidlPsitMstpSsurWnonDnon_out";
        };
    } forEach units group _this;
};

{
    _x addAction ["Set Hostages Free",{
        {
            if (!(_x in captivesFree)) then {
                captivesFree pushBack _x;
                sleep random .5;
            };
        } forEach units group (_this select 0);
        publicVariable "captivesFree";
    },nil,6,true,true,"","!(_target in captivesFree) && _this distance _target < 4"];
} forEach units group _this;
