/*
ARMA3 - ZCM FILL HOUSE SCRIPT v0.2 - by 26K
Fills house or buildings in defined range with soldiers

Calling the script:
_nul = [thisTrigger,30] execVM "scripts\z_fillHouse.sqf";

Parameters:
	target 		= 	center point 	(Game Logics/Objects/Marker name, ex: GL01 or this or "marker1")
*/

if !isServer exitWith{};

params [[ "_trigger", objNull], ["_unitCount", -1]];

// **** USER VARIABLES ****
private _side = WEST;
private _grpConfig = configfile >> "CfgGroups" >> "West" >> "VN_AUS" >> "vn_b_group_men_aus_army_70" >> "vn_b_group_men_aus_army_70_01";

// **** MAIN SCRIPT (Don't edit below here!)

// Get Units List
private _unitTypes = [];

if (_grpConfig isEqualType configFile) then {
	for "_i" from 0 to ((count _grpConfig) - 1) do {
		private _item = _grpConfig select _i;
		if (isClass _item) then { _unitTypes pushBack getText(_item >> "vehicle") };
	};
} else { _unitTypes = _grpConfig };

if (_unitTypes isEqualTo [] || isNull _trigger) exitWith { systemChat format ["[ZFH] ERROR - %1", if (isNull _trigger) then { "Trigger not found" } else { format["No units in %1",_unitTypes] }] };

private _center = getPos _trigger; _center set [2,0];
private _radius = ((triggerArea _trigger)#0) max ((triggerArea _trigger)#1);

// Priority Buildings
private _milPrimary = [
	"Land_Cargo_HQ_V1_F","Land_Cargo_HQ_V2_F","Land_Cargo_HQ_V3_F","Land_Cargo_HQ_V4_F","Land_Medevac_HQ_V1_F",
	"Land_Cargo_House_V1_F","Land_Cargo_House_V2_F","Land_Cargo_House_V3_F","Land_Cargo_House_V4_F","Land_Medevac_house_V1_F",
	"Land_Cargo_Patrol_V1_F","Land_Cargo_Patrol_V2_F","Land_Cargo_Patrol_V3_F","Land_Cargo_Patrol_V4_F",
	"Land_Cargo_Tower_V1_F","Land_Cargo_Tower_V2_F","Land_Cargo_Tower_V3_F","Land_Cargo_Tower_V4_F",
	"Land_HBarrier_01_tower_green_F","Land_HBarrier_01_big_tower_green_F","Land_BagBunker_01_large_green_F","Land_BagBunker_01_small_green_F",
	"Land_HBarrierTower_F","Land_BagBunker_Tower_F","Land_BagBunker_Large_F","Land_BagBunker_Small_F",
	"Land_Airport_01_controlTower_F","Land_Airport_02_controlTower_F",
	"Land_Barracks_01_camo_F","Land_Barracks_01_dilapidated_F","Land_Barracks_01_grey_F","Land_Barracks_06_F",
	"Land_Bunker_01_HQ_F","Land_Bunker_01_big_F","Land_Bunker_01_small_F","Land_Bunker_01_tall_F",
	"Land_Cargo_Tower_V1_No1_F","Land_Cargo_Tower_V1_No2_F","Land_Cargo_Tower_V1_No3_F","Land_Cargo_Tower_V1_No4_F","Land_Cargo_Tower_V1_No5_F","Land_Cargo_Tower_V1_No6_F","Land_Cargo_Tower_V1_No7_F",
	"Land_ControlTower_01_F","Land_ControlTower_02_F",
	"Land_DeerStand_01_F","Land_DeerStand_02_F",
	"Land_GuardTower_01_F","Land_GuardTower_02_F","Land_MilOffices_V1_F",
	"Land_i_Barracks_V1_F","Land_i_Barracks_V2_F","Land_u_Barracks_V2_F","Land_vn_airport_02_controltower_f",
	"Land_vn_b_gunpit_01","Land_vn_b_mortarpit_01","Land_vn_b_tower_01","Land_vn_b_trench_bunker_04_01","Land_vn_b_trench_firing_05","Land_vn_bagbunker_01_large_green_f","Land_vn_bagbunker_01_small_green_f","Land_vn_barracks_01_camo_f","Land_vn_barracks_01_dilapidated_f","Land_vn_barracks_01_grey_f","Land_vn_barracks_06_f","Land_vn_bunker_big_01","Land_vn_bunker_big_02","Land_vn_bunker_small_01","Land_vn_controltower_01_f",
	"Land_vn_hut_tower_01","Land_vn_hut_tower_02",
	"Land_vn_i_barracks_v1_dam_f","Land_vn_i_barracks_v1_f","Land_vn_i_barracks_v2_dam_f","Land_vn_i_barracks_v2_f",
	"Land_vn_o_bunker_02","Land_vn_o_bunker_03","Land_vn_o_bunker_04",
	"Land_vn_o_platform_01","Land_vn_o_platform_02","Land_vn_o_platform_03","Land_vn_o_platform_04","Land_vn_o_platform_05","Land_vn_o_platform_06",
	"Land_vn_o_shelter_02","Land_vn_o_shelter_05",
	"Land_vn_o_snipertree_01","Land_vn_o_snipertree_02","Land_vn_o_snipertree_03","Land_vn_o_snipertree_04","Land_vn_o_tower_01","Land_vn_o_tower_02","Land_vn_o_tower_03","Land_vn_pillboxbunker_01_big_f","Land_vn_pillboxbunker_01_hex_f","Land_vn_pillboxbunker_02_hex_f","Land_vn_radar_01_antenna_base_f","Land_vn_radar_01_hq_f",
	"Land_vn_tent_01_01","Land_vn_tent_01_02","Land_vn_tent_01_03","Land_vn_tent_01_04","Land_vn_tent_02_01","Land_vn_tent_02_02","Land_vn_tent_02_03","Land_vn_tent_02_04",
	"vn_o_snipertree_01","vn_o_snipertree_02","vn_o_snipertree_03","vn_o_snipertree_04"
];

private _buildings = (nearestObjects [_center, _milPrimary, _radius]) call BIS_fnc_arrayShuffle;
_buildings append (((nearestObjects [_center, ["building","Structure"], _radius]) select { count (_x buildingPos -1) > 2 }) call BIS_fnc_arrayShuffle);

if (_unitCount < 1) then { _unitCount = ((count _buildings) * 0.5) * 4 min 60 };

systemChat format ["[ZFH] Spawning %1 units at %2", _unitCount, _center];

private _setUnitPos = {
	params ["_unit"];
	private _unitEyePos = eyePos _unit;
	
	// Make unit crouch if they have sky above their heads.
	if (count (lineIntersectsWith [_unitEyePos, (_unitEyePos vectorAdd [0, 0, 10])] select {_x isKindOf 'Building'}) < 1) then {
		_unit setUnitPos "MIDDLE";
		// Reset source to new height.
		_unitEyePos = eyePos _unit; 
	}; 
	
	// Force unit to hold - doStop is a 'soft' hold, disableAI stops movement permanently.
	if (random 1 > 0.7) then { doStop _unit } else { _unit disableAI "PATH" };
	
	private _p1 = []; // Great pos, facing outside building.
	private _p2 = []; // Good pos but facing inside building.
	private _p3 = []; // OK pos but not best views.
	private _p4 = []; // Bad pos facing wall.
	
	// Get Building Direction
	private _unitBld = nearestBuilding _unit;
	
	for "_dir" from (getDir _unitBld) to ((getDir _unitBld) + 359) step 45 do { 
		// Check 3m
		if (count (lineIntersectsWith [_unitEyePos, [_unitEyePos, 3, _dir] call BIS_fnc_relPos] select {_x isKindOf 'Building'}) > 0) then { 
			_p4 pushBack _dir;
		} else { 
			// Check 10m
			if (count (lineIntersectsWith [_unitEyePos, [_unitEyePos, 10, _dir] call BIS_fnc_relPos] select {_x isKindOf 'Building'}) > 0) then { 
				_p3 pushBack _dir;
			} else { 
				if (abs ((_unitEyePos getDir _unitBld) - _dir) >= 120) then {
					_p1 pushBack _dir;
				} else {
					_p2 pushBack _dir;
				};
			};
		};
	};  
		
	// Pick a random angle from the best grouping.
	private _finalDir = -1;
	{	
		if (count _x > 0) then {_finalDir = selectRandom _x };
		if (_finalDir >= 0) exitWith {}; 
	} forEach [_p1, _p2, _p3, _p4];
	
	_unit doWatch (_unit getPos [200,_finalDir]);
	
	// Semi-exposed area, set to kneel.
	if (count (_p1 + _p2) >= 5 && random 1 > 0.2) then { _unit setUnitPos "MIDDLE" };

	// Exposed area, set to prone.
	if (count (_p1 + _p2) >= 7) then { 
		if (random 1 > 0.8) then { _unit setUnitPos "MIDDLE" } else { _unit setUnitPos "DOWN" };
	};	
};

private _grp = createGroup [_side, true];

// Fill Buildings
{
	private _bld = _x;
	private _bFill = false;
	if (_unitCount < 1) exitWith {};
	
	private _bPos = _bld buildingPos -1; 
	private _places = if (count _bPos > 6) then { ceil random 4 } else { 2 };
	
	for "_i" from 0 to _places do {
		if (count _bPos < 1 || _unitCount < 1) exitWith {};
		
		private _tempPos = selectRandom _bPos;
		_bPos = _bPos - [_tempPos];
		
		if (count (_tempPos nearEntities ["Man", 2]) < 1) then {
			_unitCount = _unitCount - 1;
			_bFill = true;
			private _unitType = selectRandom _unitTypes;
			private _unit = _grp createUnit [_unitType, getPos _bld, [], 0, "NONE"];
			_unit setPosATL _tempPos;
			_unit spawn _setUnitPos;	
		};
	};
	
	if (_bFill && count (_bld nearEntities ["EmptyDetector", 50]) isEqualTo 0) then {
			private _trg = createTrigger ["EmptyDetector", getPos _bld];
			_trg setTriggerArea [50, 50, 0, false, 15];
			_trg setTriggerActivation ["ANYPLAYER", "PRESENT", false];
			_trg setTriggerInterval 5;
			_trg setTriggerStatements [
				"this", 
				"{ if (local _x) then { if (!(_x checkAIFeature 'PATH') && random 1 < 0.4) then { doStop _x; _x enableAI 'PATH' }; }; } forEach (allUnits inAreaArray thisTrigger);",
				"{ if (local _x) then { if !(_x checkAIFeature 'PATH') then { _x doFollow leader _x; _x enableAI 'PATH' }; }; } forEach (allUnits inAreaArray thisTrigger);"
			];
	};
	
	sleep 0.1;
} forEach _buildings;

_grp spawn { sleep 5; _this enableDynamicSimulation true; };

//Add to Zeus
{ _x addCuratorEditableObjects [units _grp, true] } forEach allCurators;

systemChat format ["[ZFH] Created %1 units at %2", count units _grp, _center];