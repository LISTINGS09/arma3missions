params["_unit"];

if (!alive _unit || (_unit getVariable ["unit_done", false])) exitWith {};

_unit setVehicleAmmo (0.2 + random 0.4);

private _nighttime = if(daytime > 19 OR daytime < 8) then { true } else { false };

//Hopefully fixing BIS broken scripts:
private _AISkill = 0.1;
switch (A3E_Param_EnemySkill) do {
	case 0: { _AISkill = 0.1; };
	case 1: { _AISkill = 0.2; };
	case 2: { _AISkill = 0.3; };
	case 3: { _AISkill = 0.4; };
	case 4: { _AISkill = 0.5; };
	default { _AISkill = 0.2; };
};
_unit setSkill _AISkill;
_unit setSkill ["spotdistance", _AISkill];
_unit setSkill ["aimingaccuracy", _AISkill]; 
_unit setSkill ["aimingshake", _AISkill]; 
_unit setSkill ["spottime", _AISkill];
_unit setSkill ["commanding", _AISkill];

_unit removeItem "FirstAidKit";

//Chance for a random scope (and no scope):
if(random 100 < 70) then {

	removeAllPrimaryWeaponItems _unit;
	if((random 100 < 30)) then {
		_scopes = A3E_arr_Scopes;
		if(A3E_Param_NoNightvision==0) then {
			_scopes = _scopes + A3E_arr_TWSScopes;
		};
		if(_nighttime) then {
			_scopes = _scopes + A3E_arr_NightScopes;
		};
		_scope = selectRandom _scopes;
		_unit addPrimaryWeaponItem _scope;
	};
};

private _nvgs = hmd _unit; //NVGoggles
if (_nvgs isEqualTo "") then {
	private _cfgWeapons = configFile >> "CfgWeapons";
	{
		if (616 == getNumber (_cfgWeapons >> _x >> "ItemInfo" >> "type")) exitWith { _nvgs = _x };
	} forEach items _unit;
};
if(_nvgs != "") then {
	if((_nighttime) && (random 100 > 40) || !(_nighttime) && (random 100 > 5) || (A3E_Param_NoNightvision>0)) then {
		_unit unlinkItem _nvgs;
		_unit removeItem _nvgs;
	};
} else {
	if(time > 10 && (((_nighttime) && (random 100 < 40)) || (!(_nighttime) && (random 100 < 5))) && (A3E_Param_NoNightvision==0)) then {
		_unit linkItem "NVGoggles_OPFOR";
	};
};


//Bipod chance
if((random 100 < 20)) then { _unit addPrimaryWeaponItem (selectRandom a3e_arr_Bipods) };

//Chance for silencers
if(((random 100 < 10) && (!_nighttime)) OR ((random 100 < 40) && (_nighttime))) then {
	//Not yet
};

//Remove assigned items
{ if (random 100 > 20 || time < 5) then { _unit unlinkItem _x } } forEach (assignedItems _unit);

//Chance for random attachment
if(((random 100 < 15) OR (_nighttime)) && hmd _unit == "") then {
	if(random 100 < 70 || (A3E_Param_NoNightvision>0)) then {
		_unit addPrimaryWeaponItem "acc_flashlight";
	} else {
		_unit addPrimaryWeaponItem "acc_pointer_IR";
		_unit linkItem "NVGoggles_OPFOR";
	};
};

if(A3E_Param_UseIntel==1) then { [_unit] spawn A3E_fnc_AddIntel };

_unit setVariable ["unit_done", true];