if (hasInterface) then {
    _light = "#lightpoint" createVehicleLocal position _this;
    _light setLightBrightness 2;
    _light setLightColor [.7,.25,.15];
    _light lightAttachObject [_this,[0,0,5]];
};

if (isServer) then {
    createVehicle ["test_EmptyObjectForFireBIG", position _this,[],0,"CAN_COLLIDE"];
};