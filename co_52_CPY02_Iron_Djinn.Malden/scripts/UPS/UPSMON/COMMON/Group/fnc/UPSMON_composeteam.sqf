/****************************************************************
File: UPSMON_composeteam.sqf
Author: Azroul13

Description:
	Each units of the group is assigned to a team
Parameter(s):
	<--- group
Returns:
	----> Support Team (array of units)
	----> Assault Team (array of units)
	----> ATteam (array of units)
	----> AAteam (array of units)
****************************************************************/
private ["_grp","_units","_Assltteam","_Supportteam","_Atteam","_result","_units","_at","_unit","_weapon","_sweapon","_typeweapon"];

_grp = _this select 0;
	
_Assltteam = [];
_Supportteam = [];
_Atteam = [];
_AAteam = [];
_snpteam = [];
_mgteam = [];
_result = [];
	
if (({alive _x} count units _grp) == 0) exitWith {_result = [];_result;};
	
// add leader and people to team 1
_Supportteam pushBack (vehicle (leader _grp));
_unitsleft = units _grp;
_unitsleft = _unitsleft - [leader _grp];
_unitsinvalid = [];
_vehiclesnbr = 0;

//Add vehicles with gunner in the support team
{
	if (alive _x) then
	{
		if (vehicle _x != _x) then
		{
			if (!(_x in (assignedCargo assignedVehicle _x))) then
			{
				if (!IsNull (gunner vehicle _x)) then
				{
					if (!(vehicle _x in _Supportteam)) then
					{
						_Supportteam pushBack (vehicle _x);
						_vehiclesnbr = _vehiclesnbr + 1;
					};
					
					_unitsinvalid pushBack _x;
				};
			};
		};
	}
	else
	{
		_unitsinvalid pushBack _x;
	};
} forEach _unitsleft;

_unitsleft = _unitsleft -  _Supportteam;
_unitsleft = _unitsleft -  _unitsinvalid;


{
	if (alive _x) then
	{
		if (canMove _x) then
		{
			if (_x == vehicle _x) then
			{
				_weapon = currentweapon _x;
				_sweapon = secondaryWeapon _x;
				_typeweapon = tolower gettext (configFile / "CfgWeapons" / _weapon / "cursor");
				if (_sweapon != "") then 
				{
					_smagazineclass = (getArray (configFile / "CfgWeapons" / _sweapon / "magazines")) select 0;
					_ammo = tolower gettext (configFile >> "CfgMagazines" >> _smagazineclass >> "ammo");
					_irlock	= getNumber (configfile >> "CfgAmmo" >> _ammo >> "irLock");
					_laserlock	= getNumber (configfile >> "CfgAmmo" >> _ammo >> "laserLock");
					_airlock	= getNumber (configfile >> "CfgAmmo" >> _ammo >> "airLock");
					
					if (_airlock==2 && !(_ammo isKindOf "BulletBase") && !(_x in _AAteam)) then
					{_AAteam pushBack _x};
					if ((_irlock==0 || _laserlock==0) && 
					((_ammo isKindOf "RocketBase") || (_ammo isKindOf "MissileBase") || (_ammo isKindOf "RocketBase") || (_ammo isKindOf "MissileBase")) && !(_x in _ATteam)) then
					{_Atteam pushBack _x};
				};
				
				if (!(_x in _Supportteam) && (_typeweapon in ["mg","srifle"] ||  _sweapon != "")) then
				{
					_Supportteam pushBack _x;
					if (_typeweapon == "mg") then {_mgteam pushBack _x;};
					if (_typeweapon == "srifle") then {_snpteam pushBack _x;};
				};				
			};
		}
		else
		{
			_unitsinvalid pushBack _x;
		};
	}
	else
	{
		_unitsinvalid pushBack _x;
	};
} forEach _unitsleft;
	
//Add the rest to the Assltteam

_unitsleft = _unitsleft -  _unitsinvalid;
_Assltteam = _unitsleft - _Supportteam;


if ({alive _x && vehicle _x == _x} count units _grp <= 4) then
{
	if (_vehiclesnbr == 0) then
	{
		_Assltteam = units _grp;
	}
	else
	{
		if (count _Assltteam <= 1 && count _Supportteam > 1) then 
		{
			_arr2 = _Supportteam;
			
			{
				if (_x != vehicle (leader _grp)) then
				{
					if (count _arr2 > count _Assltteam) then
					{
						_Assltteam pushBack _x;
						_arr2 = _arr2 - [_x];
					};
				};
			} forEach _Supportteam;
			
			_Supportteam = _arr2;
		};			
	};
}
else
{
	if (count _Assltteam <= 1 && count _Supportteam > 4) then 
	{
		_arr2 = _Supportteam;	
		{
			if (_x != vehicle (leader _grp)) then
			{
				if (vehicle _x == _x) then
				{
					if (count _arr2 > count _Assltteam) then
					{
						_Assltteam pushBack _x;
						_arr2 = _arr2 - [_x];
					};
				};
			};
		} forEach _Supportteam;
	
		_Supportteam = _arr2;
	};	
};



{_x assignTeam "RED"} forEach _Assltteam;
{_x assignTeam "BLUE"} forEach _Supportteam;
	
_result = [_Supportteam,_Assltteam,_Atteam,_AAteam];
_result;