/****************************************************************
File: UPSMON_movetoDriver.sqf
Author: MONSADA

Description:
	Función que mueve al soldado a la posición de conductor
Parameter(s):
	<--- unit
	<--- Vehicle to mount
Returns:

****************************************************************/
private["_vehicle","_npc"];		

_npc = _this ;
_vehicle = vehicle _npc;

//Si está muerto
if (vehicle _npc == _npc || !alive _npc || !canMove _npc || !(_npc isKindOf "Man")) exitWith{};
	
if (isnull(driver _vehicle) || !alive(driver _vehicle) || !canMove(driver _vehicle)) then 
{ 	
	//if (UPSMON_Debug>0) then {player sidechat format["%1: Moving to driver of %2 ",_npc,typeOf _vehicle]}; 	
	_npc action ["getOut", _vehicle];
	doGetOut _npc;
	WaitUntil {vehicle _npc==_npc || !alive _npc || !canMove _npc};
	//Si está muerto
	if (!alive _npc || !canMove _npc) exitWith{};		
	unassignVehicle _npc;
	_npc assignasdriver _vehicle;
	_npc moveindriver _vehicle;
};