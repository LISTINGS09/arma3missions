params ["_unit", "_container"];
private _intelItems = missionNameSpace getVariable ["A3E_IntelItems",["Files","FileTopSecret","FilesSecret","FlashDisk","DocumentsSecret","Wallet_ID","FileNetworkStructure","MobilePhone","SmartPhone"]];
if (A3E_Param_UseIntel==1) then {
	private _intels = magazines _unit select {_x in _intelItems};
	if (count _intels > 0) then { [count _intels] remoteExec ["A3E_fnc_RevealPOI", 2] };
	{ _unit removeMagazine _x } forEach _intels;
};