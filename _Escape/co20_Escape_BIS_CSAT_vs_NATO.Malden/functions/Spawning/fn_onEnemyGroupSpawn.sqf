params["_grp"];

[_grp] call A3E_fnc_TrackGroup_Add;

_grp addEventHandler ["EnemyDetected", {_this call A3E_fnc_onEnemyDetected;}];

if (local _grp) then { 
	_grp deleteGroupWhenEmpty true
} else {
	[_grp, true] remoteExec ["deleteGroupWhenEmpty", groupOwner _grp]
};