
private ["_grp","_assignedvehicle","_dist","_targetdist","_get_out_dist","_unitsincargo"];

_grp = _this select 0;
_assignedvehicle = _this select 1;
_dist = _this select 2;
_targetdist = _this select 3;
_supstate = _this select 4;
_safemode = ["CARELESS","SAFE"];

{
	_vehicle = vehicle _x;
	_unitsincargo = [_vehicle] call UPSMON_FN_unitsInCargo;
	

	if (!(_vehicle isKindOf "AIR") && !(_vehicle isKindOf "StaticWeapon") && !(_vehicle isKindOf "MAN")) then
	{
		_get_out_dist = UPSMON_closeenoughV  * ((random .4) + 1);
		if (_vehicle isKindOf "TANK" || _vehicle isKindOf "Wheeled_APC_F" || !(IsNull (gunner _vehicle))) then {_get_out_dist = UPSMON_closeenough  * ((random .4) + 0.8);};
		if ((behaviour _x) in _safemode) then 
		{
			if (_grp getVariable ["UPSMON_Grpmission",""] != "TRANSPORT") then
			{
				_targetdist = 20000
			};
		};		
		
		if (UPSMON_Debug>0) then {diag_log format ["UPSMON: Disembark - Group:%7 canMove:%1 Alive:%2 Dist1:%3 targetDist:%4 Gothit:%5 Cargo:%6",canMove _vehicle,alive (driver _vehicle),_dist <= _get_out_dist,_targetdist <= (200 * ((random .4) + 1)),_supstate,_unitsincargo,groupID _grp];};
			
		if (!(_vehicle getVariable ["UPSMON_disembarking",false])) then
		{
			if (!(canMove _vehicle) 
				|| !(alive (driver _vehicle))
				|| _dist <= _get_out_dist 
				|| (_supstate != "") 
				|| _targetdist <= (200 * ((random .4) + 1))) then
			{
				[_vehicle,_unitsincargo,_grp,_supstate] spawn UPSMON_dodisembark;
			};
		}
	};
	
	if (_vehicle isKindOf "AIR") then
	{
		if (count _unitsincargo > 0) then
		{
			if (_grp getVariable ["UPSMON_Grpmission",""] == "TRANSPORT") then
			{
				_get_out_dist = UPSMON_paradropdist * ((random 0.4) + 1);
				if (UPSMON_Debug>0) then {diag_log format ["UPSMON: Disembark - Group:%7 canMove:%1 Alive:%2 Dist1:%3 targetDist:%4 Gothit:%5 Cargo:%6",canMove _vehicle,alive (driver _vehicle),_dist <= _get_out_dist,_targetdist <= (200 * ((random .4) + 1)),_supstate,_unitsincargo,groupId _grp];};
				if (_targetdist <= _get_out_dist || _dist <= 800) then
				{
					if (((_grp getVariable ["UPSMON_Transportmission",[]]) select 0) == "LANDING" || ((_grp getVariable ["UPSMON_Transportmission",[]]) select 0) == "LANDBASE") then
					{
						if (_dist <= 800) then
						{
							if (!(_grp getVariable ["UPSMON_ChangingLZ",false])) then
							{
								_targetpos = [_vehicle,getposATL _vehicle,["car"]] call UPSMON_SrchTrpPos;
								_mission = (_grp getVariable ["UPSMON_Transportmission",[]]) select 0;
								_group = (_grp getVariable ["UPSMON_Transportmission",[]]) select 2;
								_grp setVariable ["UPSMON_Transportmission",[_mission,_targetpos,_group]];
								[_grp,_targetpos,"MOVE","COLUMN","FULL","CARELESS","YELLOW",1,UPSMON_flyInHeight] call UPSMON_DocreateWP;
								_grp getVariable ["UPSMON_ChangingLZ",true];
							};
						};
						if ((abs(velocity _vehicle select 2)) <= 1 && ((getposATL _vehicle) select 2) <= 4) then
						{
							[_vehicle,_unitsincargo,_grp] spawn UPSMON_dohelidisembark;
						};
					}
					else
					{
						[_vehicle] spawn UPSMON_KeepAltitude;
						[_vehicle,_unitsincargo,_grp] spawn UPSMON_doparadrop;
					};
				};
			};
		};
	};								
} forEach _assignedvehicle;