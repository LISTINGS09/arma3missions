if (!isServer) exitWith {};

while {true} do {
	sleep (30 + random 600);
	createVehicle ["M_Mo_82mm_AT",position _this,[],100,"NONE"];
	
};