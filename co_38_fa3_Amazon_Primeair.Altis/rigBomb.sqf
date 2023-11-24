
private ["_bomb"];
_bomb = _this select 0;

mpTitleText = {titleText [_this select 0, "PLAIN"]};
mpAddAction = {_this select 0 addAction [_this select 1, _this select 2]};

if (f_param_debugMode == 1) then {
	player sideChat format ["rigBomb setup for %1", _bomb];
};
_bomb addAction ["Rig to Blow",
				{
				  _this select 0 setVariable ["arming", true, true];
				  [[_this select 0, _this select 2], "removeAction"] call BIS_fnc_MP;
				  titleText ["Started Rigging\nThis could take a while...", "PLAIN"];
				},
				[],
				6,
				true,
				true,
				"",
				"_this in engineers"];
if (!isServer) exitWith {};
_bomb setVariable ["armProgress", 0];
_bomb setVariable ["arming", false, true];
while {true} do {
	sleep 6;
	if (_bomb getVariable "arming") then {
		_nearEngs = [nearestObjects [getPosATL _bomb, ["Man"], 3], {alive _x && _x in engineers && ((GetPosASL _x select 2) + .5 > GetPosASL _bomb select 2)}] call BIS_fnc_conditionalSelect;
		if (f_param_debugMode == 1) then {
			player sideChat format ["%1 engineers arming %2", count _nearEngs, _bomb];
		};
		if (count _nearEngs > 0) then {
			_bomb setVariable ["armProgress", (_bomb getVariable "armProgress") + count _nearEngs];
			[[format ["Rigging %1%2 complete\nMore engineers might speed this up...", _bomb getVariable "armProgress", "%"]], "mpTitleText", _nearEngs] call BIS_fnc_MP;
		};
		if (_bomb getVariable "armProgress" >= 100) then {
			_bomb setVariable ["arming", false];
			[["Rigging Complete!\nSomeone will need to detonate it manually...", _bomb getVariable "armProgress", "%"], "mpTitleText", _nearEngs] call BIS_fnc_MP;
			[[_bomb, "Detonate Bomb", {"Bo_Mk82" createVehicle position (_this select 0)}], "mpAddAction"] call BIS_fnc_MP;
		};
	};
};
