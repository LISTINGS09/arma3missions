/****************************************************************
File: UPSMON_Clones.sqf
Author: Azroul13

Description:
	The group dismount the vehicle, if the vehicle is unarmed the driver will dismount too.

Parameter(s):
	<--- Vehicle which unload his cargo
	<--- Group disembarking
Returns:
	nothing
****************************************************************/

if (UPSMON_Debug>0) then { player globalchat format["Mon_disembark started"];};
private ["_transport","_unitsgetout","_grp","_grps","_driver","_driverout"];				

_transport = _this select 0;
_unitsgetout = _this select 1;
_grp = _this select 2;
_supstatus = _this select 3;

_transport setVariable ["UPSMON_disembarking",true];

_grps = [];
_grps pushBack _grp;
	
if (!alive _transport) exitWith{};
	
_driver = driver _transport;

if ( count _unitsgetout > 0 ) then 
{		
	{
		if (!(group _x in _grps)) then {_grps pushBack (group _x)};
	} forEach _unitsgetout;
	
	{
		_x getVariable ["UPSMON_disembarking",true];
	} forEach _grps;
	
	// All units disembark if the vehicle is a Car
	Dostop _driver;
	_driver disableAI "MOVE";
	//Stop the veh for 5.5 sek
	sleep 1.5; // give time to actualy stop
	
	if (Isnull (gunner _transport)) then
	{
		//We removed the id to the vehicle so it can be reused
		_transport setVariable ["UPSMON_grpid", 0, false];	
		_transport setVariable ["UPSMON_cargo", [], false];	
						
		// [_npc,_x, _driver] spawn UPSMON_checkleaveVehicle; // if every one outside, make sure driver can walk
		if (((group _transport) getVariable ["UPSMON_Grpmission",""]) != "TRANSPORT") then
		{
			_driver enableAI "MOVE";
			_unitsgetout pushBack _driver
		};
		
		//We removed the id to the vehicle so it can be reused
		_transport setVariable ["UPSMON_grpid", 0, false];	
	};
		
	if (_supstatus != "") then
	{
		_weapons  = getarray  (configFile >> "CfgVehicles" >> typeOf _transport >> "weapons");
		if ("SmokeLauncher" in _weapons) then
		{
			_nosmoke = [_grp] call UPSMON_NOSMOKE;
			if (!_nosmoke) then {[_transport] spawn UPSMON_DoSmokeScreen;};
		};
	};
	[_transport,_unitsgetout] call UPSMON_UnitsGetOut;
	_driver enableAI "MOVE";
		
	_transport setVariable ["UPSMON_cargo", [], false];	
};

if (UPSMON_Debug > 0) then {diag_log format ["transport:%1",_unitsgetout]};
if (((group _transport) getVariable ["UPSMON_Grpmission",""]) == "TRANSPORT") then
{
	[_transport] spawn UPSMON_Returnbase;
};

_transport setVariable ["UPSMON_disembarking",false];
{
	_x getVariable ["UPSMON_disembarking",false];
	if (_x getVariable ["UPSMON_InTransport",false]) then {_x setVariable ["UPSMON_InTransport",false];};
	if (_x getVariable ["UPSMON_Grpmission",""] == "WAITTRANSPORT") then {_x setVariable ["UPSMON_Grpmission","PATROL"]};
} forEach _grps;