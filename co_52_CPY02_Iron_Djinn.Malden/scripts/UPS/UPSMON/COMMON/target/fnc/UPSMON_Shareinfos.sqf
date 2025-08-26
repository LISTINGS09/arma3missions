/****************************************************************
File: UPSMON_Shareinfos.sqf
Author: Azroul13

Description:

Parameter(s):
	<--- Array of enemies
	<--- leader
Returns:
	Nothing
****************************************************************/

private ["_enemies","_npc","_arrnpc","_side","_pos","_alliednpc","_alliedlead","_enemy"];
	
_npc = _this select 0;
_arrnpc = UPSMON_NPCs - [group _npc];
_side = side _npc;
_pos = getposATL _npc;
_alliednpc = [];
_enemies = [];
	
{
	if (!IsNull _x) then
	{
		if (alive (leader _x)) then
		{
			if (_x getVariable ["UPSMON_Shareinfos",false]) then
			{
				if (_side == side _x) then
				{
					if (count (_x getVariable ["UPSMON_GrpEnies",[]]) > 0) then
					{
						if (round ([_pos,getposATL (leader _x)] call UPSMON_distancePosSqr)  <= UPSMON_sharedist) then 
						{
							_alliednpc pushBack _x;
						};
					};
				};
			};
		};
	};
} forEach _arrnpc;

			
{
	if (!IsNull _x) then
	{
		_alliedlead = leader _x;
		if (alive _alliedlead) then
		{
			_enies = _x getVariable ["UPSMON_GrpEnies",[]];
			{
				if (alive _x) then
				{
					if (!(_x in _enemies)) then
					{
						_enemies pushBack _x;
					};
				};
			} forEach _enies;
		};
		sleep 0.1;
	};
} forEach _alliednpc;

_enemies