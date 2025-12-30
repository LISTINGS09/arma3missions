params["_player"];

diag_log format["[ESCAPE]: %1 initPlayer", name _player];

_player addEventHandler["HandleScore","_this call A3E_FNC_handleScore;"];

[_player, true] remoteExec ["setCaptive", _player, false];
diag_log format["[ESCAPE]: %1 waiting for prison creation.", name _player];

//Wait until most of the mission is loaded and the player is locally ready (means no weapons etc)
waitUntil{uiSleep 0.5;(!isNil("A3E_FenceIsCreated") && !isNil("A3E_StartPos") && !isNil("A3E_ParamsParsed"))};

diag_log format["[ESCAPE]: %1 ready and will be placed by the server [F:%2, S:%3, P:%4]", name _player, A3E_FenceIsCreated, A3E_StartPos, A3E_ParamsParsed];
private _placed = false;
if(!isNil("A3E_EscapeHasStarted")) then {
	private _players = [] call A3E_fnc_GetPlayers;
	//Remove player from list
	_players deleteAt (_players find _player); 
	while{(count _players) > 0 && !_placed} do {
		private _refPlayer = selectRandom _players;
		private _refVehicle = vehicle _refPlayer;
		if((_refVehicle != _refPlayer) && ((_refVehicle) emptyPositions "Commander">0 || (_refVehicle) emptyPositions "Driver">0 || (_refVehicle) emptyPositions "Gunner">0 || (_refVehicle) emptyPositions "Cargo">0)) then {
				//_player moveInAny _refVehicle;
				//Teleports the player remotely into the Vehicle, needs to be called local at player
				[_player,_refVehicle] remoteExec ["moveInAny", _player]; 
				sleep 0.5;
				if(_player in _refVehicle) then {
					_placed = true;
					diag_log format["[ESCAPE]: %1 placed at %2 in cargo of vehicle", name _player, name _refPlayer];
				} else {
					diag_log format["[ESCAPE]: Unable place %1 in cargo of %2", name _player, name _refPlayer];
					_placed = false;
				};
			} else {
				_player setpos [(getpos _refPlayer select 0) + (random 4) - 2, (getpos _refPlayer select 1) + (random 6) - 3, 0];
				_placed = true;
				diag_log format["[ESCAPE]: Place %1 beside %2", name _player, name _refPlayer];
			};
		//Remove the player to test another one
		_players deleteAt (_players find _refPlayer); 				
	};
};
if (!_placed) then {
	_player setPos [(A3E_StartPos select 0)+random 3.0-1.5,(A3E_StartPos select 1)+random 3.0-1.5,0];
	_player setDir (random 360);
	diag_log format["[ESCAPE]: %1 placed at prison", name _player];
};
uiSleep 0.5;
diag_log format["[ESCAPE]: %1 now ready (server)", name _player];

//A3E_PlayerInitializedServer means the player was placed in Prison and is ready for the "Intro"
_player setVariable["A3E_PlayerInitializedServer", true, true];

waitUntil{!isNil("A3E_EscapeHasStarted")};

[_player, false] remoteExec ["setCaptive", _player, false];