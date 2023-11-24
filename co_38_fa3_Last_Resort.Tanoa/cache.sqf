if (!isServer) exitWith {};

if (isNil {caches}) then {
	caches = [];
};
caches pushBack _this;

_this addEventHandler ["Killed",{
	_this select 0 spawn {
		sleep (.75 + random 2);
		createVehicle ["IEDUrbanSmall_Remote_Ammo",position _this,[],0,"CAN_COLLIDE"] setDamage 1;
		deleteVehicle _this;
	};
}];