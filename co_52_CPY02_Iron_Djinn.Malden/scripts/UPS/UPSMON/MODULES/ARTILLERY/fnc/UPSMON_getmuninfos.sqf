/****************************************************************
File: UPSMON_getrounnbr.sqf
Author: Azroul13

Description:
	Get the number of rounds the unit has
Parameter(s):
	<--- fire mission 
	<--- battery units
Returns:
	[Number of rounds,class of the munition,indirect range value,hit value]
****************************************************************/

private ["_askmission","_vehicles","_rounds","_class","_indirectrange","_hit","_mags","_ammo","_parents","_cfg","_result"];

_askmission = _this select 0;
_vehicles = _this select 1;

_rounds = 0;
_class = ObjNull;
_indirectrange = 0;
_hit = 0;
_mags = [];

{
	if (alive _x) then
	{
		_mags = [_mags,magazinesAmmo _x] call BIS_fnc_arrayPushStack
	};
} forEach _vehicles;

{
	Switch (_askmission) do 
	{
		case "HE": 
		{
			_ammo = tolower gettext (configFile>> "CfgMagazines" >> (_x select 0) >> "ammo");
			_parents = [(configFile>> "CfgAmmo" >> _ammo),true] call BIS_fnc_returnParents;
	
			if ("ShellBase" in _parents) then
			{
				_class = _x select 0;
				_rounds = _rounds + (_x select 1);
				_indirectrange = (getnumber (configFile >> "CfgAmmo" >> _ammo >> "indirectHitRange")) * 8;
				_hit = getnumber (configFile >> "CfgAmmo" >> _ammo >> "Hit");
			};
		};
		
		case "AT": 
		{
			_ammo = tolower gettext (configFile>> "CfgMagazines" >> (_x select 0) >> "ammo");
			_cfg = tolower gettext (configFile>> "CfgAmmo" >> _ammo >> "submunitionAmmo");
	
			if (_cfg == "M_Mo_82mm_AT_LG") then
			{
				_class = _x select 0;
				_rounds = _rounds + (_x select 1);
				_indirectrange = getnumber (configFile >> "CfgAmmo" >> _ammo >> "indirectHitRange");
				_hit = getnumber (configFile >> "CfgAmmo" >> _ammo >> "Hit");
			};
		};
		
		case "SMOKE": 
		{
			_ammo = tolower gettext (configFile>> "CfgMagazines" >> (_x select 0) >> "ammo");
			_cfg = tolower gettext (configFile>> "CfgAmmo" >> _ammo >> "submunitionAmmo");
	
			if (_cfg == "SmokeShellArty") then
			{
				_class = _x select 0;
				_rounds = _rounds + (_x select 1);
				_indirectrange = getnumber (configFile >> "CfgAmmo" >> _ammo >> "indirectHitRange");
				_hit = getnumber (configFile >> "CfgAmmo" >> _ammo >> "Hit");
			};
		};
		
		case "ILLUM": 
		{
			_ammo = tolower gettext (configFile>> "CfgMagazines" >> (_x select 0) >> "ammo");
			_parents = [(configFile>> "CfgAmmo" >> _ammo),true] call BIS_fnc_returnParents;
	
			if ("FlareCore" in _parents) then
			{
				_class = _x select 0;
				_rounds = _rounds + (_x select 1);
				_indirectrange = getnumber (configFile >> "CfgAmmo" >> _ammo >> "indirectHitRange");
				_hit = getnumber (configFile >> "CfgAmmo" >> _ammo >> "Hit");
			};
		};
	};	
} forEach _mags;

_result = [_rounds,_class,_indirectrange,_hit];
_result