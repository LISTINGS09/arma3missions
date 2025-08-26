/****************************************************************
File: UPSMON_avoidDissembark.sqf
Author: MONSADA

Description:
	if every on is outside, make sure driver can move
Parameter(s):
	<--- leader
Returns:
	Nothing
****************************************************************/
private["_npc","_vehicle","_timeout"];
	
_npc = _this select 0;
_vehicle = vehicle _npc;
	
_timeout = 120;
_timeout = time + _timeout;
	
while {_npc == vehicle _npc && alive _npc && canMove _npc && time < _timeout} do {
	sleep 1;
};
		
if (!alive _npc || !canMove _npc || time >= _timeout || driver vehicle _npc == _npc) exitWith{};	
_npc stop true;
	
while {_npc != vehicle _npc && alive _npc && canMove _npc} do {sleep 1;};
_npc stop false;
sleep 0.5;	
	
if (!alive _npc || !canMove _npc) exitWith{};	