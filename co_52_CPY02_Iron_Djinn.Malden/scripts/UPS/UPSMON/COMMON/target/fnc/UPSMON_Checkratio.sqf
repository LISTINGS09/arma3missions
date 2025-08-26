/****************************************************************
File: UPSMON_Checkratio.sqf
Author: Azroul13

Description:
	Comparison between Allied and Enemies forces in 800 radius
Parameter(s):
	<--- Group
	<--- Array of allied groups
	<--- Array of enies units
Returns:
	---> Ratio Eni/Allies
	---> Array of importants targets 
****************************************************************/
private ["_grp","_allies","_enies","_pointsallies","_pointsenies","_ratedveh","_Itarget","_result","_points","_vehicle","_MagazinesUnit","_Cargo","_armor","_assignedvehicles"];
	
_grp = _this select 0;
_allies = _this select 1;
_enies = _this select 2;
_pointsallies = 0;
_pointsenies = 0;
_ratedveh = [];
_typeOfeni = [];
_enicapacity = [];
_assignedvehicles = []; 

_allies pushBack _grp;
	
{
	if(!IsNull _x) then
	{
		if (({alive _x} count units _x) > 0) then
		{
			_pointsallies = _pointsallies + (_x getVariable ["UPSMON_Grpratio",0]);
		};
	};
} count _allies > 0;

{
	_eni = _x;
	_points = 0;
	
	if (!IsNull _eni) then
	{
		if (alive _eni) then
		{
			if ((vehicle _eni) != _eni && !(Isnull assignedVehicle _eni) && !(_eni in (assignedCargo assignedVehicle _eni))) then 
			{
				if (!((assignedVehicle _eni) in _assignedvehicles)) then 
				{
					_vehicle = assignedVehicle _eni;
					_assignedvehicles pushBack _vehicle;
					_MagazinesUnit=(magazines _vehicle);
					_Cargo  = getNumber  (configFile >> "CfgVehicles" >> typeOf _vehicle >> "transportSoldier");
					_armor  = getNumber  (configFile >> "CfgVehicles" >> typeOf _vehicle >> "armor");
					_gunner = gunner _vehicle;
					_ammorated = [];
					
					_points = _points + 1;
					
					if (!IsNull _gunner) then
					{
						if (alive _gunner) then
						{
							{
								_ammo = tolower gettext (configFile >> "CfgMagazines" >> _x >> "ammo");
								_irlock	= getNumber (configfile >> "CfgAmmo" >> _ammo >> "irLock");
								_laserlock	= getNumber (configfile >> "CfgAmmo" >> _ammo >> "laserLock");
								_airlock	= getNumber (configfile >> "CfgAmmo" >> _ammo >> "airLock");
								_hit	= getNumber (configfile >> "CfgAmmo" >> _ammo >> "hit");
					
							if (_airlock == 1) then
							{
								if (_ammo isKindOf "BulletBase") then
								{
									if (!("aa1" in _enicapacity)) then
									{
										_enicapacity pushBack "aa1";
									};
								};
							};
							
							if (_airlock == 2) then
							{
								if (!(_ammo isKindOf "BulletBase")) then
								{
									if (!("aa2" in _enicapacity)) then
									{
										_enicapacity pushBack "aa2";
									};
								};
							};

							if (_irlock>0 || _laserlock>0) then
							{
								if (_ammo isKindOf "MissileBase") then
								{
									if (!("at2" in _enicapacity)) then
									{
										_enicapacity pushBack "at2";
									};
								};
							};

							if (_ammo isKindOf "ShellBase") then
							{
								if (!(arti in _typeOfgrp)) then
								{
									if (!("at3" in _enicapacity)) then
									{
										_enicapacity pushBack "at3";
									};
								};
							};
					
							if (_ammo isKindOf "BulletBase") then
							{
								if (_hit >= 40) then
								{
									if (!("at1" in _enicapacity)) then
									{
										_enicapacity pushBack "at1";
									};						
								};
							};
								if (!(_ammo in _ammorated)) then
								{
									_points = _points + _hit;
									_ammorated pushBack _ammo;
								};
						
							} forEach _MagazinesUnit;
						};
					};
					
					_points = _points + _armor;

					
					if (_vehicle isKindOf "car") then
					{
						if (!("car" in _typeOfeni)) then
						{
							_typeOfeni pushBack "car";
						};
					
						if (_armor >= 500) then
						{
							if (!("heavy" in _typeOfeni)) then
							{
								_typeOfeni pushBack "heavy";
							};
						};
				
						if (_armor >= 250 && _armor < 500) then
						{
							if (!("medium" in _typeOfeni)) then
							{
								_typeOfeni pushBack "medium";
							};
						};
				
						if (_armor < 250) then
						{
							if (!("light" in _typeOfeni)) then
							{
								_typeOfeni pushBack "light";
							};
						};					
					};

					if (_vehicle isKindOf "air") then
					{
						if (!("air" in _typeOfeni)) then
						{
							_typeOfeni pushBack "air";
						};
					};
				
					if (_vehicle isKindOf "Ship") then
					{
						if (!("Ship" in _typeOfeni)) then
						{
							_typeOfeni pushBack "Ship";
						};
					};
				
					if (!IsNull (Gunner _vehicle)) then
					{
						if (!("armed" in _typeOfeni)) then
						{
							_typeOfeni pushBack "armed";
						};
					};
					
				};		
			}
			else
			{
				if (vehicle _x != _x) then
				{
					if (!((assignedVehicle _x) in _assignedvehicles)) then
					{
						_assignedvehicles pushBack (assignedVehicle _x);
					}
				};
				_sweapon = secondaryWeapon _x;
				_MagazinesUnit=(magazines _x);
				_smagazineclass = [];
				if (_sweapon != "") then 
				{
					_smagazineclass = getArray (configFile >> "CfgWeapons" >> _sweapon >> "magazines");
				};
				_ammorated = [];
			
				_points = _points + 1;
					
				{
					_ammo = tolower gettext (configFile >> "CfgMagazines" >> _x >> "ammo");
					_irlock	= getNumber (configfile >> "CfgAmmo" >> _ammo >> "irLock");
					_laserlock	= getNumber (configfile >> "CfgAmmo" >> _ammo >> "laserLock");
					_airlock	= getNumber (configfile >> "CfgAmmo" >> _ammo >> "airLock");
					_hit	= getNumber (configfile >> "CfgAmmo" >> _ammo >> "hit");

					if (_airlock==2 && !(_ammo isKindOf "BulletBase") && !("aa2" in _enicapacity) && (_ammo in _smagazineclass)) then
					{_enicapacity pushBack "aa2";};
					if ((_irlock>0 || _laserlock>0) && 
					((_ammo isKindOf "RocketBase") || (_ammo isKindOf "MissileBase")) && !("at2" in _enicapacity) && (_ammo in _smagazineclass)) then
					{_enicapacity pushBack "at2";};
					if ((_irlock==0 || _laserlock==0) && 
					((_ammo isKindOf "RocketBase") || (_ammo isKindOf "MissileBase")) && !("at1" in _enicapacity) && (_ammo in _smagazineclass)) then
					{_enicapacity pushBack "at1";};
					
					if (_ammo isKindOf "ShellBase" || (_ammo isKindOf "RocketBase") || (_ammo isKindOf "MissileBase") && !(_ammo in _ammorated) && (_ammo in _smagazineclass)) then
					{
						_points = _points + _hit;
						_ammorated pushBack _ammo;
					};
				} forEach _MagazinesUnit;
				
				if (!("infantry" in _typeOfeni)) then 
				{_typeOfeni pushBack "infantry";};
			};
			_points = _points + ((1+(morale _eni)) + (1-(damage _eni)) + ((_eni skillFinal "Endurance") + (_eni skillFinal "courage")));
			_pointsenies = _points;
		};
	};
} forEach _enies;

//diag_log str _pointsenies;
//diag_log str _pointsallies;
_ratio = _pointsenies/_pointsallies;
	
_result = [_ratio,_enicapacity,_typeOfeni];
_result;