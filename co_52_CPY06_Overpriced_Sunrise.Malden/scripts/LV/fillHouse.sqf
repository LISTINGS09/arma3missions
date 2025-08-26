/*
				***		ARMA3Alpha FILL HOUSE SCRIPT v1.61Z - by SPUn / lostvar	/ 26K ***

						Fills house or buildings in defined range with soldiers
						
			Calling the script:
			
					default: nul = [this] execVM "scripts\LV\fillHouse.sqf";
					
					custom:  nul = [target, side, patrol, patrol type, spawn rate, radius, skills, group, 
									custom init, ID] execVM "scripts\LV\fillHouse.sqf";

		Parameters:
		
	target 		= 	center point 	(Game Logics/Objects/Marker name, ex: GL01 or this or "marker1")
	side 		= 	"NATO", "WEST", "CSAT", "EAST", "AFF" or "FIA"											DEFAULT: "NATO"
	patrol 		= 	true or false 	(if true, units will patrol) 											DEFAULT: true
	patrol type = 	1 or 2 			(1=only inside building, 2=also outside of building) 					DEFAULT: 2
	spawn rate  = 	1-100 OR Array 	(on how many percentage of possible positions are soldiers spawned) 	DEFAULT: 50
				NOTE: Array - you can also use following syntax: [amount,random amount] for example:
				[10,12] will spawn at least 10 units + random 12 units 
	radius 		= 	1 or larger number (1=nearest building. if larger number, then all buildings in radius) DEFAULT: 1
	skills 		= 	"default" 	(default AI skills) 														DEFAULT: "default"
				or	number	=	0-1.0 = this value will be set to all AI skills, ex: 0.8
				or	array	=	all AI skills invidiually in array, values 0-1.0, order:
		[aimingAccuracy, aimingShake, aimingSpeed, spotDistance, spotTime, courage, commanding, general, endurance, reloadSpeed] 
		ex: 	[0.75,0.5,0.6,0.85,0.9,1,1,0.75,1,1] 
	group 		= 	group name or nil (if you want units in existing group, set it here. if nil, 			DEFAULT: nil
					new group is made) EXAMPLE: (group player)
	custom init = 	"init commands" (if you want something in init field of units, put it here) 			DEFAULT: nil
				NOTE: Keep it inside quotes, and if you need quotes in init commands, you MUST use ' or "" instead of ".
				EXAMPLE: "hint 'this is hint';"
	ID 			= 	number (if you want to delete units this script creates, you'll need ID number for them)DEFAULT: nil

EXAMPLE: 	nul = [this, 2, true, 2, 50, 1, 0.75, nil, nil, 9] execVM "scripts\LV\fillHouse.sqf";
			spawns in nearest building east soldiers in 50% of possible building positions with skill 0.75,
			and makes them patrol in & outside of that building

			_nul = [this,"NATO",false,1,[1,round random 8],20] execVM "scripts\LV\fillHouse.sqf";
*/
if !isServer exitWith{};
private ["_center0","_aaf_insurgent","_usa_d","_usa_w","_usmc_w","_usmc_d","_takiban","_rusVDV","_rusMSV","_csat_urban","_csat_arid","_csat_sarid","_csat_woodland","_csat_special","_revDir","_blueMenArray3","_blueMenArray2","_BLUarrays","_FIAarrays","_redMenArray2","_OPFarrays","_greenMenArray","_skls","_buildings","_rat","_milHQ","_menArray","_newPos","_unitType","_unit","_building","_blueMenArray","_redMenArray","_bPoss","_pFile"];
params ["_center",["_sideOption","NATO"],["_patrol",false],["_pType",2],["_ratio",50],["_radius",1],["_skills",[0.4,0.5,1,0.8,0.7,1,1,1,1,1]],["_milGroup",nil],["_customInit",nil],["_grpId",nil]];

if (isNil("FH_ACskills")) then {FH_ACskills = compile preprocessFile "scripts\LV\fnc_ACskills.sqf"};
if (isNil("FH_vehicleInit")) then {FH_vehicleInit = compile preprocessFile "scripts\LV\fnc_vehicleInit.sqf"};
if (isNil("FH_nearestBuilding")) then {FH_nearestBuilding = compile preprocessFile "scripts\LV\fnc_nearestBuilding.sqf"};

#include "groupsList.sqf";

if(_center in allMapMarkers)then {
		_center0 = getMarkerPos _center;
} else {
	if (typeName _center == "ARRAY") then {
		_center0 = _center;
	} else {
		_center0 = getPos _center;
	};
};

if(_radius > 1)then{
	_buildings = ["radius",_center,_radius] call FH_nearestBuilding;
}else{
	_buildings = ["nearest",_center] call FH_nearestBuilding;
};

if(count _buildings == 0) exitWith {
	_mkr = createMarkerLocal[str _center,_center0];
	_mkr setMarkerShapeLocal "ICON";
	_mkr setMarkerSizeLocal [0.6,0.6];
	_mkr setMarkerTypeLocal "mil_warning";
	["fillHouse.sqf",format["No <font color='#0080FF'><marker name='%1'>buildings</marker></font color> found.",_mkr]] call f_fnc_logIssue;
	diag_log text format["[LV] ERROR (fillHouse.sqf): No buildings found at location %1",_center0];
};

_bPoss = [];
{	
	_bPoss append (_x buildingPos -1);
} forEach _buildings;

if(typeName _ratio == "ARRAY")then{
	_rat = (_ratio select 0) + (random (_ratio select 1));
}else{
	_rat = ceil((_ratio / 100) * (count _bPoss));
};

for "_i" from 0 to _rat do {
	if (count _bPoss == 0) exitWith {};
	_newPos = selectRandom _bPoss;
	_bPoss = _bPoss - [_newPos];
	//if (missionNamespace getVariable["f_param_debugMode",0] == 1) then { diag_log text format["[LV] DEBUG (fillHouse.sqf): Creating man %1 at %4. Positions: %2. Ratio: %3",_i,count _bPoss,_rat,_newPos]; };

    _unitType = _menArray select (floor(random(count _menArray)));
	_unit = _milGroup createUnit [_unitType, _newPos, [], 0, "NONE"];
	_unit setPosATL _newPos;
	
	// Is in a building?
	_posU = getPosASL _unit;
	_intersects = lineIntersectsWith [_posU,[_posU select 0,_posU select 1,(_posU select 2)+5]];
	
	if ({_x isKindOf "HouseBase" || _x isKindOf "BagBunker_base_F"} count _intersects > 0) then {
		// Enable DS for the unit if in building.
		group _unit enableDynamicSimulation true;
		
		// Is inside building
		_posU = getPos _unit;
		_posASL = if (_unit isKindOF "CAMANBASE") then [{eyePos _unit},{GetPosASL (_unit)}];

		// Get position 15m from units view
		_relpos = [[_posU select 0,_posU select 1,(_posU select 2)],15, getDir _unit] call BIS_fnc_relPos;

		// Get any intersecting buildings
		_intersects = lineIntersectsObjs [_posASL,ATLTOASL _relpos];
		
		// If blocked, turn unit 180
		if ({(_x isKindOf "HouseBase" || _x isKindOf "BagBunker_base_F")} count _intersects > 0) then {
			_udir = getDir _unit - 180;	
			_unit setFormDir _udir;
			_unit setDir _udir;
		};	

		if (random 1 > 0.5) then {_unit setUnitPos "MIDDLE"};
		
	} else {
		// Is outside building
		if (random 1 > 0.3) then {_unit setUnitPos "MIDDLE"} else {_unit setUnitPos "DOWN"};
		
		// Face unit away from centre point.
		_unit setFormDir ((_unit getRelDir _center0) - 180);
		_unit setDir ((_unit getRelDir _center0) - 180);
	};

	if (random 1 > 0.2) then { doStop _unit; } else { _unit disableAI "PATH"; };	
	
	if (_skills isEqualType []) then { _skls = [_unit,_skills] call FH_ACskills; } else { _unit setSkill 0.5; };
	
	// Disable VCOMAI
	_unit setVariable ["VCOM_NOPATHING_Unit",1];
	
	//Add to Zeus
	{
		_x addCuratorEditableObjects [[_unit],true];
	} forEach allCurators;
	
	if (!isNil("_customInit")) then { 
		_nul = [_unit,_customInit] spawn FH_vehicleInit;
	};
};

if( !isNil("_grpId")) then {
	call compile format ["LVgroup%1 = _milGroup",_grpId];
	call compile format["LVgroup%1spawned = 'true';", _grpId];
	_thisArray = [];
	{ 
		if (isNil("_x")) then {
			_thisArray set[(count _thisArray),"nil0"];
		} else {
			_thisArray set[(count _thisArray),_x];
		};
	} forEach _this;
	call compile format["LVgroup%1CI = ['fillhouse',%2]",_grpId,_thisArray];
};