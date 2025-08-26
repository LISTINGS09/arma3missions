/****************************************************************
File: UPSMON_FireFlare.sqf
Author: Azroul13

Description:
	
Parameter(s):

Returns:

****************************************************************/
private["_grp","_muzzle","_munition","_weapon","_muzzles","_cfg","_parents","_muns","_flaresclass"];	

_grp = _this select 0;	
_targetpos = _this select 1;

_muzzle = "";
_munition = "";

{
	if (alive _x) then
	{
		_unit = _x;
		if (vehicle _unit == _unit) then
		{
			if (Unitready _unit) then
			{
				_weapon = primaryWeapon _unit;
				if (_weapon != "") then
				{
					_muzzles = getArray(configFile>> "cfgWeapons" >> _weapon >> "muzzles");
					_continue = false;
					{
						if (_x != "this") then
						{
							_cfg = (configFile>> "cfgWeapons" >> _weapon >> _x);
							_parents = [_cfg,true] call BIS_fnc_returnParents;
							if ("UGL_F" in _parents) exitWith
							{
								_muzzle = _x;
								_continue = true;
							};
						};
					} forEach _muzzles;
				
					if (_continue) then
					{
						_muns = getarray (configFile>> "cfgWeapons" >> _weapon >> _muzzle >> "magazines");
						_flaresclass = [];
						{
							_ammo = tolower gettext (configFile>> "CfgMagazines" >> _x >> "ammo");
							_cfg = getnumber (configFile>> "CfgAmmo" >> _ammo >> "useFlare");

							if (_cfg == 1) then
							{
								_flaresclass pushBack _x;
							};
						} forEach _muns;
					
						if (count _flaresclass > 0) then
						{
							_continue = false;
							{
								if (_x in (magazines _unit)) exitWith
								{
									_munition = _x;
									_continue = true;
								};
							} forEach _flaresclass;
						
							if (_continue) exitWith
							{
								[_unit,_muzzle,_munition,_targetpos] spawn UPSMON_DoFireFlare;
							};
						};
					};
				};
			};
		}
	}
} forEach units _grp;
