/****************************************************************
File: UPSMON_getequipment.sqf
Author: Azroul13

Description:
	In order to respawn a unit with the same loadout
	Called from UPSMON.sqf
Parameter(s):
	<--- unit
Returns:
	Array of equipments
****************************************************************/

private ["_unit","_maguniformunit","_magbackunit","_magvestunit","_uniform","_headgear","_vest","_bag","_classbag","_itemsunit","_weaponsunit","_equipmentarray"];
_unit = _this;
_maguniformunit = [];
_magbackunit = [];
_magvestunit = [];


_uniform = uniform _unit;
if (_uniform != "") then {_maguniformunit = getMagazineCargo uniformContainer _unit;};

_headgear = headgear _unit;

_vest = vest _unit;
if (_vest != "") then {_magvestunit = getMagazineCargo vestContainer _unit;};

_bag = unitBackpack _unit;
_classbag = typeOf _bag;
if (_classbag != "") then {_magbackunit = getMagazineCargo backpackContainer _unit;};


_itemsunit = items _unit;
_assigneditems = assignedItems _unit;
_primaryweapon = [];
_secondaryweapon = [];
_handgunweapon = [];
if (primaryweapon _unit != "") then
{
	_primaryweapon pushBack (primaryweapon _unit);
	_primaryweapon pushBack (primaryWeaponItems _unit);
	_primaryweapon pushBack ((getArray (configFile >> "CfgWeapons" >> (primaryweapon _unit) >> "magazines")) select 0);
};

if (secondaryweapon _unit != "") then
{
	_secondaryweapon pushBack (secondaryweapon _unit);
	_secondaryweapon pushBack (secondaryWeaponItems _unit);
	_secondaryweapon pushBack ((getArray (configFile >> "CfgWeapons" >> (secondaryweapon _unit) >> "magazines")) select 0);
};

if (handgunWeapon _unit != "") then
{
	_handgunweapon pushBack (handgunWeapon _unit);
	_handgunweapon pushBack (handgunItems _unit);
	_handgunweapon pushBack ((getArray (configFile >> "CfgWeapons" >> (handgunWeapon _unit) >> "magazines")) select 0);
};

_weaponsunit = [_primaryweapon,_secondaryweapon,_handgunweapon];

_allmag = [] + [_maguniformunit] + [_magvestunit] + [_magbackunit];
_equipmentarray = [_uniform,_headgear,_vest,_classbag,_itemsunit,_assigneditems,_allmag,_weaponsunit];
_equipmentarray