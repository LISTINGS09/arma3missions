/****************************************************************
File: UPSMON_analysegrp.sqf
Author: Azroul13

Description:
	get all information about the group
Parameter(s):
	<--- Group
Returns:
	----> type of the group (array) ["arti","infantry","incargo","tank","transport","armed","apc","car","ship","static","staticbag"]
	----> Capacity of the group (array) ["aa1","aa2","at1","at2","at3"] [AAcapability but without missile,AA missile,At Rocket,At missile,At gun]
	----> Assigned vehicles (array)
****************************************************************/

private ["_grp","_assignedvehicles","_typeOfgrp","_capacityofgrp","_result","_vehicleClass","_MagazinesUnit","_Cargo","_gunner","_ammo","_irlock","_laserlock","_airlock","_checkbag","_staticteam","_points","_vehicle"];
_grp = _this select 0;
	
_assignedvehicles = [];
_typeOfgrp = [];
_capacityofgrp = [];
_engagementrange = 600;
_result = [];
_points = 0;
	
if (({alive _x} count units _grp) == 0) exitWith {_result = [_typeOfgrp,_capacityofgrp,_assignedvehicles,_engagementrange];_result;};

_artibatteryarray = [];

{
	if (alive _x) then
	{
		if ((vehicle _x) != _x && !(Isnull assignedVehicle _x) && !(_x in (assignedCargo assignedVehicle _x))) then 
		{
			if (!((assignedVehicle _x) in _assignedvehicles)) then 
			{
				_vehicle = assignedVehicle _x;
				_assignedvehicles pushBack _vehicle;
				_MagazinesUnit = (magazines _vehicle);
				_Cargo  = getNumber  (configFile >> "CfgVehicles" >> typeOf _vehicle >> "transportSoldier");
				_armor  = getNumber  (configFile >> "CfgVehicles" >> typeOf _vehicle >> "armor");
				_support =  tolower gettext (configFile >> "CfgVehicles" >> typeOf _vehicle >> "vehicleClass");
				_cfgArtillery = getnumber (configFile >> "cfgVehicles" >> typeOf (_vehicle) >> "artilleryScanner");
				_repair = getnumber (configFile >> "cfgVehicles" >> typeOf (_vehicle) >> "transportRepair");
				_fuel = getnumber (configFile >> "cfgVehicles" >> typeOf (_vehicle) >> "transportFuel");
				_munsupply = getnumber (configFile >> "cfgVehicles" >> typeOf (_vehicle) >> "attendant");
				
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
									if (!("aa1" in _capacityofgrp)) then
									{
										_capacityofgrp pushBack "aa1";
									};
								};
							};
							
							if (_airlock == 2) then
							{
								if (!(_ammo isKindOf "BulletBase")) then
								{
									if (!("aa2" in _capacityofgrp)) then
									{
										_capacityofgrp pushBack "aa2";
									};
								};
							};

							if (_irlock>0 || _laserlock>0) then
							{
								if (_ammo isKindOf "MissileBase") then
								{
									if (!("at2" in _capacityofgrp)) then
									{
										_capacityofgrp pushBack "at2";
									};
								};
							};

							if (_ammo isKindOf "ShellBase") then
							{
								if (!("arti" in _typeOfgrp)) then
								{
									if (!("at3" in _capacityofgrp)) then
									{
										_capacityofgrp pushBack "at3";
									};
								};
							};
					
							if (_ammo isKindOf "BulletBase") then
							{
								if (_hit >= 40) then
								{
									if (!("at1" in _capacityofgrp)) then
									{
										_capacityofgrp pushBack "at1";
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
					if (!("car" in _typeOfgrp)) then
					{
						_typeOfgrp pushBack "car";
					};
					
					if (_armor >= 500) then
					{
						if (!("heavy" in _typeOfgrp)) then
						{
							_typeOfgrp pushBack "heavy";
						};
					};
				
					if (_armor >= 250 && _armor < 500) then
					{
						if (!("medium" in _typeOfgrp)) then
						{
							_typeOfgrp pushBack "medium";
						};
					};
				
					if (_armor < 250) then
					{
						if (!("light" in _typeOfgrp)) then
						{
							_typeOfgrp pushBack "light";
						};
					};					
				};

				if (_vehicle isKindOf "staticweapon") then
				{
					if (!("static" in _typeOfgrp)) then
					{
						_typeOfgrp pushBack "static";
					};
				};

				if (_vehicle isKindOf "air") then
				{
					if (!("air" in _typeOfgrp)) then
					{
						_typeOfgrp pushBack "air";
					};
				};
				
				if (_vehicle isKindOf "PLANE") then
				{
					if ("aa2" in _capacityofgrp || "aa1" in _capacityofgrp || "at1" in _capacityofgrp || "at2" in _capacityofgrp) then
					{
						if (!("plane" in _typeOfgrp)) then
						{
							_typeOfgrp pushBack "plane";
						};
					};
				};
				
				if (_vehicle isKindOf "Ship") then
				{
					if (!("Ship" in _typeOfgrp)) then
					{
						_typeOfgrp pushBack "Ship";
					};
				};
				
				if (_cargo >= 6) then
				{
					if (!("transport" in _typeOfgrp)) then
					{
						_typeOfgrp pushBack "transport";
					};
				};
				
				if (!IsNull (Gunner _vehicle)) then
				{
					if (!("armed" in _capacityofgrp)) then
					{
						_capacityofgrp pushBack "armed";
						_engagementrange = 1000;
					};
				};
				
				if (_cfgArtillery == 1) then 
				{
					if (!(_vehicle in _artibatteryarray)) then
					{
						_artibatteryarray pushBack _vehicle;
						_grp setVariable ["UPSMON_Battery",_artibatteryarray];
					};
					
					if (!("arti" in _typeOfgrp)) then
					{
						_typeOfgrp pushBack "arti";
					};
				};
				
				if (_support == "Support") then 
				{
					if (!("supply" in _typeOfgrp)) then
					{
						_typeOfgrp pushBack "supply";
					};
					
					if (_repair > 0) then
					{
						if (!("repair" in _capacityofgrp)) then
						{
							_capacityofgrp pushBack "repair";
						};
					};
										
					if (_fuel > 0) then
					{
						if (!("fuel" in _capacityofgrp)) then
						{
							_capacityofgrp pushBack "fuel";
						};
					};
					
					if (_munsupply > 0) then
					{
						if (!("ammo" in _capacityofgrp)) then
						{
							_capacityofgrp pushBack "ammo";
						};
					};
					
					if (!("support" in _typeOfgrp)) then
					{
						_typeOfgrp pushBack "support";
					};
				};
				
				if (_vehicle isKindOf "tank" && !("tank" in _typeOfgrp)) then 
				{_typeOfgrp pushBack "tank";};
				if (_vehicle isKindOf "Wheeled_APC_F" && !("apc" in _typeOfgrp)) then 
				{_typeOfgrp pushBack "apc";};
					
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

				if (_airlock==2) then
				{
					if (!(_ammo isKindOf "BulletBase")) then
					{
						if (_ammo in _smagazineclass) then
						{
							if (!("aa2" in _capacityofgrp)) then
							{
								_capacityofgrp pushBack "aa2";
							};
						};
					};
				};
				
				if (_irlock>0 || _laserlock>0) then
				{
					if ((_ammo isKindOf "RocketBase") || (_ammo isKindOf "MissileBase")) then
					{
						if (_ammo in _smagazineclass) then
						{
							if (!("at2" in _capacityofgrp)) then
							{
								_capacityofgrp pushBack "at2";
							};
						};
					};
				};

				if (_irlock==0 || _laserlock==0) then
				{
					if ((_ammo isKindOf "RocketBase") || (_ammo isKindOf "MissileBase")) then
					{
						if (_ammo in _smagazineclass) then
						{
							if (!("at1" in _capacityofgrp)) then
							{
								_capacityofgrp pushBack "at1";
							};
						};
					};
				};
				
				if (_ammo isKindOf "ShellBase" || (_ammo isKindOf "RocketBase") || (_ammo isKindOf "MissileBase") && !(_ammo in _ammorated) && (_ammo in _smagazineclass)) then
				{
					_points = _points + _hit;
					_ammorated pushBack _ammo;
				};
			} forEach _MagazinesUnit;
				
			if (!("infantry" in _typeOfgrp)) then 
			{_typeOfgrp pushBack "infantry";};
		};
		_points = _points + ((1+(morale _x)) + (1-(damage _x)) + ((_x skillFinal "Endurance") + (_x skillFinal "courage")));
	};
	
} forEach units _grp;
	
_checkbag = [_grp] call UPSMON_GetStaticTeam;
_staticteam = _checkbag select 0;
if (count _staticteam == 2) then
{
	_cfgArtillery = getnumber (configFile >> "cfgVehicles" >> (_checkbag select 1) >> "artilleryScanner");
	
	_capacityofgrp pushBack ["staticbag"];
	_engagementrange = 1000;
	
	if (_cfgArtillery == 1) then
	{
		if (!("arti" in _typeOfgrp)) then
		{
			_typeOfgrp pushBack "arti";
		};
		
		if (!((_staticteam select 0) in _artibatteryarray)) then
		{
			_artibatteryarray pushBack _staticteam;
			_grp setVariable ["UPSMON_Battery",_artibatteryarray];
		};

		if (count (_grp getVariable ["UPSMON_Mortarmun",[]]) == 0) then
		{
			_rounds = [_checkbag select 1] call UPSMON_GetDefaultmun;
			_grp setVariable ["UPSMON_Mortarmun",_rounds];
		};
	};
};

[_grp,_typeOfgrp] call UPSMON_AddtoArray;

_points = _points;

{
	if (!IsNull _x) then
	{
		if ((_renfgroup getVariable ["UPSMON_GrpToRenf",ObjNull]) == _grp) then
		{
			if (({alive _x && !(captive _x)} count units _x) > 0) then
			{
				_points = _points + (_x getVariable ["UPSMON_Grpratio",0]);
			};
		};
	};
} forEach (_grp getVariable ["UPSMON_RenfGrps",[]]);

_grp setVariable ["UPSMON_Grpratio",_points];
_grp setVariable ["UPSMON_GroupCapacity",_capacityofgrp];
_grp setVariable ["UPSMON_typeOfgrp",_typeOfgrp];
_grp setVariable ["UPSMON_Assignedvehicle",_assignedvehicles];

if (count _assignedvehicles > 0) then
{
	_array = [];
	
	{
		if (canMove _x) then
		{
			if (driver _x in units _grp) then
			{
				_array pushBack _x;
			};
		};
	} forEach _assignedvehicles;
	_grp setVariable ["UPSMON_LastAssignedvehicle",_array];
};

if (count (_grp getVariable ["UPSMON_LastAssignedvehicle",_assignedvehicles]) > 0) then
{
	_array = [];
	
	{
		if (!IsNull _x) then
		{
			if (canMove _x) then
			{
				if (driver _x in units _grp) then
				{
					_array pushBack _x;
				};
			};
		};
	} forEach _assignedvehicles;
	_grp setVariable ["UPSMON_LastAssignedvehicle",_array];
};
	
//if (UPSMON_Debug>0) then {diag_log format ["Grpcompos/ typeOfgrp:%1 Capacity:%2 Assignedvehicles:%3 range:%4 Points:%5",_typeOfgrp,_capacityofgrp,_assignedvehicles,_engagementrange,_points];};
	
_result = [_typeOfgrp,_capacityofgrp,_assignedvehicles,_engagementrange];
_result;