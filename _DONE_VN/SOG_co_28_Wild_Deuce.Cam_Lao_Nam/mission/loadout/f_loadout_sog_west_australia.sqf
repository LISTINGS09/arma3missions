// F3 - Folk ARPS Assign Gear Script - NATO
// Credits: Please see the F3 online manual (http://www.ferstaberinde.com/f3/en/)
// ================================
// GENERAL EQUIPMENT USED BY MULTIPLE CLASSES
// ATTACHMENTS - PRIMARY
f_radios_backpack = "vn_b_pack_lw_06";

_attach1 = "";
_attach2 = "";

_flashHider = "";
_silencer1 = ""; // Rifleman
_silencer2 = ""; // MG

_scope1 = []; // CQB
_scope2 = []; // Low
_scope3 = ["vn_o_4x_m16"]; // Medium
_scope4 = ["vn_o_9x_m40a1","vn_o_anpvs2_m14"]; // High

_bipod1 = [];

// Default setup
_attachments = []; // The default attachment set for most units, overwritten in the individual unitType

// Predefined Class Attachment Setup
_attach_co = [];
_attach_dc = []; // Also SL!
_attach_fl = [];
_attach_mg = [];
_attach_dm = [_scope4];
_attach_sn = [_scope4];

// [] = remove all
// [_attach1,_scope1,_silencer] = remove all, add items assigned in _attach1, _scope1 and _silencer1
// [_scope2] = add _scope2, remove rest

// ================================

// ATTACHMENTS - HANDGUN
_hg_silencer1 = "";
_hg_scope1 = "";

// Default setup
_hg_attachments= []; // The default attachment set for handguns, overwritten in the individual unitType

// ================================

// WEAPON SELECTION

// Basic magazine counts given to most infantry, MMG etc get _defMags_tr as default count.
_defMags = 6;
_defMags_tr = 6;

// Standard Riflemen ( MMG Assistant Gunner, Assistant Automatic Rifleman, MAT Assistant Gunner, MTR Assistant Gunner, Rifleman)
_rifle = ["vn_l1a1_01","vn_l1a1_01_camo"];
_riflemag = "vn_l1a1_20_mag";
_riflemag_tr = "vn_l1a1_20_t_mag";

// Standard Carabineer (Medic, Rifleman (AT), MAT Gunner, MTR Gunner, Carabineer)
_carbine = ["vn_l1a1_01","vn_m14_camo","vn_sten"];
_carbinemag = "vn_l1a1_20_mag";
_carbinemag_tr = "vn_l1a1_20_t_mag";

// Standard Submachine Gun/Personal Defence Weapon (Aircraft Pilot, Submachinegunner)
_smg = "vn_sten";
_smgmag = "vn_sten_mag";
_smgmag_tr = "vn_sten_t_mag";

// Diver
_diverWep = "arifle_SDAR_F";
_diverMag1 = "30Rnd_556x45_Stanag";
_diverMag2 = "20Rnd_556x45_UW_mag";

// Rifle with GL and HE grenades (CO, DC, FTLs)
_glrifle = ["vn_l1a1_xm148","vn_l1a1_xm148_camo"];
_glriflemag = "vn_l1a1_20_mag";
_glriflemag_tr = "vn_l1a1_20_t_mag";
_glmag = "vn_40mm_m381_he_mag";

// Smoke for FTLs, Squad Leaders, etc
_glsmoke = "vn_40mm_m680_smoke_w_mag";
_glsmokealt1 = "vn_40mm_m682_smoke_r_mag";
_glsmokealt2 = "vn_40mm_m576_buck_mag";

// Flares for FTLs, Squad Leaders, etc
_glflare = "vn_40mm_m583_flare_w_mag";
_glflarealt = "vn_40mm_m661_flare_g_mag";

// Pistols (CO, DC, Automatic Rifleman, Medium MG Gunner)
_pistol = "vn_hp";
_pistolmag = "vn_hp_mag";

// Grenades
_grenade = "vn_m61_grenade_mag";
_grenadealt = "vn_m14_grenade_mag";
_smokegrenade = "vn_m18_white_mag";
_smokegrenadealt = "vn_m18_green_mag";

// misc medical items.
_firstaid = "vn_b_item_firstaidkit";
_medkit = "vn_b_item_medikit_01";

// Binoculars
_binos1 = "vn_m19_binocs_grey";
_binos2 = ["vn_m19_binocs_grey","vn_anpvs2_binoc"];

// Night Vision Goggles (NVGoggles)
_nvg = "NVGoggles_OPFOR";

// UAV Terminal
_uavterminal = "B_UavTerminal";

// Chemlights
_chem =  "vn_m7_grenade_mag";
_chemalt = "vn_m34_grenade_mag";

// Backpacks
_bagsmall = "vn_b_pack_p08_01";
_bagmedium = ["vn_b_pack_p44_01","vn_b_pack_p44_02"];
_baglarge =  ["vn_b_pack_pfield_01","vn_b_pack_pfield_02"];
_bagmediumdiver =  "B_AssaultPack_blk";			// used by divers
_baguav = "B_UAV_01_backpack_F";				// used by UAV operator
_baghmgg = "vn_b_pack_pfield_01";				// used by Heavy MG gunner
_baghmgag = "vn_b_pack_pfield_02";				// used by Heavy MG assistant gunner
_baghatg = "vn_b_pack_static_tow";				// used by Heavy AT gunner
_baghatag = "vn_b_pack_static_base_01";			// used by Heavy AT assistant gunner
_bagmtrg = "vn_b_pack_static_m29_01";			// used by Mortar gunner
_bagmtrag = "vn_b_pack_static_base_01";			// used by Mortar assistant gunner
_baghsamg = "vn_b_pack_static_m2_high_01";		// used by Heavy SAM gunner
_baghsamag = "vn_b_pack_static_base_01";		// used by Heavy SAM assistant gunner

// ================================

// UNIQUE, ROLE-SPECIFIC EQUIPMENT

// Automatic Rifleman
_AR = "vn_l4";
_ARmag = "vn_l1a1_30_mag";
_ARmag_tr = "vn_l1a1_30_t_mag";

// Medium MG
_MMG = ["vn_m60","vn_m60_shorty","vn_m60_shorty_camo"];
_MMGmag = "vn_m60_100_mag";
_MMGmag_tr = "vn_m60_100_mag";

// Marksman rifle
_DMrifle = ["vn_m14","vn_m14_camo","vn_m40a1","vn_m40a1_camo"];
_DMriflemag = "vn_m14_mag";

// Rifleman AT
_RAT = "vn_m72";
_RATmag = "vn_m72_mag";
_RATmag2 = "vn_m72_mag";

// Medium AT
_MAT = "launch_RPG32_green_F";
_MATmag1 = "RPG32_F";
_MATmag2 = "RPG32_HE_F";

// Surface Air
_SAM = "vn_sa7b";
_SAMmag = "vn_sa7b_mag";

// Heavy AT
_HAT = "launch_MRAWS_green_rail_F";
_HATmag1 = "MRAWS_HEAT_F";
_HATmag2 = "MRAWS_HE_F";

// Sniper
_SNrifle = ["vn_m40a1","vn_m40a1_camo","vn_m14","vn_m14_camo"];
_SNrifleMag = "vn_m40a1_mag";

// Engineer items
_ATmine = "vn_mine_m15_mag";
_satchel = "vn_mine_satchel_remote_02_mag";
_APmine1 = "vn_mine_m16_mag";
_APmine2 = "vn_mine_m14_mag";

// ================================

// FACE, CLOTHES AND UNIFORMS

// Define classes. This defines which gear class gets which uniform
// "medium" vests are used for all classes if they are not assigned a specific uniform
// FACE, CLOTHES AND UNIFORMS
_light = [];
_heavy =  ["eng","engm"];
_diver = ["div"];
_pilot = ["pp","pcc","pc"];
_crew = ["vc","vg","vd"];
_ghillie = ["sn","sp"];
_specOp = [];

// Basic clothing
// The outfit-piece is randomly selected from the array for each unit
_baseUniform = ["vn_b_uniform_aus_02_01","vn_b_uniform_aus_04_01","vn_b_uniform_aus_06_01","vn_b_uniform_aus_08_01","vn_b_uniform_aus_10_01"];
_baseHelmet = ["vn_b_boonie_06_01","vn_b_boonie_07_01"];
_baseGlasses = "";

// Vests
_lightRig = "vn_b_vest_anzac_03";
_mediumRig = ["vn_b_vest_anzac_01","vn_b_vest_anzac_02","vn_b_vest_anzac_04"]; 	// default for all infantry classes
_heavyRig = "vn_b_vest_anzac_09";

// Diver
_diverUniform =  "U_B_Wetsuit";
_diverHelmet = [];
_diverRig = "V_RebreatherB";
_diverGlasses = "G_Diving";

// Pilot
_pilotUniform = "vn_b_uniform_k2b_03_01";
_pilotHelmet = ["vn_b_helmet_svh4_02_04","vn_b_helmet_svh4_01_04"];
_pilotRig = "vn_b_vest_anzac_08";
_pilotGlasses = "vn_b_aviator";

// Crewman
_crewUniform = "vn_b_uniform_aus_02_01";
_crewHelmet = ["vn_b_beret_01_07","vn_b_boonie_06_01","vn_b_boonie_07_01"];
_crewRig = "vn_b_vest_anzac_09";
_crewGlasses = "";

// Ghillie
_ghillieUniform = ["vn_b_uniform_macv_02_01","vn_b_uniform_macv_03_06"];
_ghillieHelmet = ["vn_b_headband_01","vn_b_headband_02","vn_b_headband_03","vn_b_headband_04","vn_b_headband_05"];
_ghillieRig = "vn_b_vest_usarmy_08";
_ghillieGlasses = "vn_b_aviator";

// Spec Op
_sfuniform = [];
_sfhelmet = [];
_sfRig = [];
_sfGlasses = [];

// ================================

// This block needs only to be run on an infantry unit
if (_isMan) then {
	// PREPARE UNIT FOR GEAR ADDITION
	// The following code removes all existing weapons, items, magazines and backpacks
	removeBackpack _unit;
	removeAllWeapons _unit;
	removeAllItemsWithMagazines _unit;
	removeAllAssignedItems _unit;

	// HANDLE CLOTHES
	// Handle clothes and helmets and such using the include file called next.
	#include "..\..\f\assignGear\f_assignGear_clothes.sqf";

	// ADD UNIVERSAL ITEMS
	// Add items universal to all units of this faction

	_unit addItem _firstaid;		// Add a single first aid kit (FAK)
	_unit linkItem "vn_b_item_map";		// Add and equip the map
	_unit linkItem "ItemCompass";	// Add and equip a compass
	_unit linkItem "vn_b_item_radio_urc10";		// Add and equip A3's default radio
	_unit linkItem "vn_b_item_watch";		// Add and equip a watch
	_unit addItem  "vn_b_bandana_01";
};

// SETUP BACKPACKS
// Include the correct backpack file for the faction

_backpack = {
	_typeOfBackPack = _this select 0;
	_loadout = f_param_backpacks;
	if (count _this > 1) then {_loadout = _this select 1};
	switch (_typeOfBackPack) do
	{
		#include "f_backpack.sqf";
	};
};

// DEFINE UNIT TYPE LOADOUTS
// The following blocks of code define loadouts for each type of unit (the unit type
// is passed to the script in the first variable)

switch (_typeOfUnit) do
{

	// LOADOUT: COMMANDER
	case "co":
	{
		["g"] call _backpack;
		_unit addHeadGear "vn_b_boonie_08_01";
		_unit setUnitTrait ["engineer",1];
		_unit addMagazines [_glriflemag,_defMags];
		_unit addMagazines [_glriflemag_tr,_defMags_tr];
		_unit addMagazines [_glmag,4];
		[_unit, _glrifle] call f_fnc_addWeapon;
		_unit addMagazines [_grenade,2];
		_unit addMagazines [_smokegrenade,4];
		_unit addMagazines [_pistolmag,3];
		[_unit, _pistol] call f_fnc_addWeapon;
		[_unit, _binos1] call f_fnc_addWeapon;
		_attachments = _attach_co;
	};

	// LOADOUT: DEPUTY COMMANDER AND SQUAD LEADER
	case "dc":
	{
		["g"] call _backpack;
		_unit addMagazines [_glriflemag,_defMags];
		_unit addMagazines [_glriflemag_tr,_defMags_tr];
		_unit addMagazines [_glmag,4];
		[_unit, _glrifle] call f_fnc_addWeapon;
		_unit addMagazines [_grenade,2];
		_unit addMagazines [_smokegrenade,4];
		_unit addMagazines [_pistolmag,3];
		[_unit, _pistol] call f_fnc_addWeapon;
		[_unit, _binos1] call f_fnc_addWeapon;
		_attachments = _attach_dc;
	};

	// LOADOUT: MEDIC
	case "m":
	{
		[_typeOfUnit] call _backpack;
		_unit setUnitTrait ["medic",1];
		_unit addMagazines [_carbinemag,_defMags];
		_unit addMagazines [_carbinemag_tr,_defMags_tr];
		[_unit, _carbine] call f_fnc_addWeapon;
		_unit addMagazines [_smokegrenadealt,4];
		{_unit addItem _firstaid} forEach [1,2,3,4];
	};

	// LOADOUT: FIRE TEAM LEADER
	case "ftl":
	{
		["g"] call _backpack;
		_unit addMagazines [_glriflemag,_defMags];
		_unit addMagazines [_glriflemag_tr,_defMags_tr];
		_unit addMagazines [_glmag,4];
		[_unit, _glrifle] call f_fnc_addWeapon;
		_unit addMagazines [_grenade,1];
		_unit addMagazines [_pistolmag,3];
		[_unit, _pistol] call f_fnc_addWeapon;
		[_unit, _binos1] call f_fnc_addWeapon;
		_attachments = _attach_fl;
	};


	// LOADOUT: AUTOMATIC RIFLEMAN
	case "ar":
	{
		[_typeOfUnit] call _backpack;
		_unit addMagazines [_ARmag,_defMags_tr];
		_unit addMagazines [_ARmag_tr,_defMags_tr];
		[_unit, _AR] call f_fnc_addWeapon;
		_unit addMagazines [_grenade,2];
		_unit addMagazines [_smokegrenade,4];
		_unit addMagazines [_pistolmag,2];
		[_unit, _pistol] call f_fnc_addWeapon;
		_attachments = _attach_mg;
	};

	// LOADOUT: ASSISTANT AUTOMATIC RIFLEMAN
	case "aar":
	{
		[_typeOfUnit] call _backpack;
		_unit addMagazines [_riflemag,_defMags];
		_unit addMagazines [_riflemag_tr,_defMags_tr];
		[_unit, _rifle] call f_fnc_addWeapon;
		_unit addMagazines [_grenade,1];
		_unit addMagazines [_smokegrenade,4];
		[_unit, _binos1] call f_fnc_addWeapon;
	};

	// LOADOUT: RIFLEMAN (AT)
	case "rat":
	{
		[_typeOfUnit] call _backpack;
		_unit addMagazines [_carbinemag,_defMags];
		_unit addMagazines [_carbinemag_tr,_defMags_tr];
		[_unit, _carbine] call f_fnc_addWeapon;
		_unit addMagazines [_grenade,1];
		_unit addMagazines [_smokegrenade,4];
		[_unit, _RAT] call f_fnc_addWeapon;
	};

	// LOADOUT: DESIGNATED MARKSMAN
	case "dm":
	{
		[_typeOfUnit] call _backpack;
		_unit addMagazines [_DMriflemag,_defMags];
		_unit addMagazines [_DMriflemag_tr,_defMags_tr];		
		[_unit, _DMrifle] call f_fnc_addWeapon;
		_unit addMagazines [_grenade,2];
		_unit addMagazines [_smokegrenade,4];
		_unit addMagazines [_pistolmag,2];
		[_unit, _pistol] call f_fnc_addWeapon;
		_attachments = _attach_dm;
	};

	// LOADOUT: MEDIUM MG GUNNER
	case "mmgg":
	{
		[_typeOfUnit] call _backpack;
		_unit addMagazines [_MMGmag,_defMags];
		_unit addMagazines [_MMGmag_tr,_defMags_tr];
		[_unit, _MMG] call f_fnc_addWeapon;
		_unit addMagazines [_smokegrenade,4];
		_unit addMagazines [_pistolmag,3];
		[_unit, _pistol] call f_fnc_addWeapon;
		_attachments = _attach_mg;
	};

	// LOADOUT: MEDIUM MG ASSISTANT GUNNER
	case "mmgag":
	{
		[_typeOfUnit] call _backpack;
		_unit addMagazines [_riflemag,_defMags];
		_unit addMagazines [_riflemag_tr,_defMags];
		[_unit, _rifle] call f_fnc_addWeapon;
		[_unit, _binos1] call f_fnc_addWeapon;
		_unit addMagazines [_grenade,1];
		_unit addMagazines [_smokegrenade,4];
	};

	// LOADOUT: HEAVY MG GUNNER
	case "hmgg":
	{
		[_typeOfUnit] call _backpack;
		_unit addMagazines [_carbinemag,_defMags];
		_unit addMagazines [_carbinemag_tr,_defMags_tr];
		[_unit, _carbine] call f_fnc_addWeapon;
		_unit addMagazines [_grenade,1];
		_unit addMagazines [_smokegrenade,4];
	};

	// LOADOUT: HEAVY MG ASSISTANT GUNNER
	case "hmgag":
	{
		[_typeOfUnit] call _backpack;
		_unit addMagazines [_carbinemag,_defMags];
		_unit addMagazines [_carbinemag_tr,_defMags_tr];
		[_unit, _carbine] call f_fnc_addWeapon;
		[_unit, _binos1] call f_fnc_addWeapon;
		_unit addMagazines [_grenade,1];
		_unit addMagazines [_smokegrenade,4];
	};

	// LOADOUT: MEDIUM AT GUNNER
	case "matg":
	{
		[_typeOfUnit] call _backpack;
		_unit addMagazines [_carbinemag,_defMags];
		_unit addMagazines [_carbinemag_tr,_defMags_tr];
		_unit addMagazines [_smokegrenade,4];
		[_unit, _carbine] call f_fnc_addWeapon;
		[_unit, _MAT] call f_fnc_addWeapon;
		_unit addSecondaryWeaponItem "gm_feroz2x17_pzf84_blk";
	};

	// LOADOUT: MEDIUM AT ASSISTANT GUNNER
	case "matag":
	{
		[_typeOfUnit] call _backpack;
		_unit addMagazines [_carbinemag,_defMags];
		_unit addMagazines [_carbinemag_tr,_defMags_tr];
		[_unit, _carbine] call f_fnc_addWeapon;
		[_unit, _binos1] call f_fnc_addWeapon;
		_unit addMagazines [_grenade,1];
		_unit addMagazines [_smokegrenade,4];
	};

	// LOADOUT: HEAVY AT GUNNER
	case "hatg":
	{
		[_typeOfUnit] call _backpack;
		_unit addMagazines [_carbinemag,_defMags];
		_unit addMagazines [_carbinemag_tr,_defMags_tr];
		[_unit, _carbine] call f_fnc_addWeapon;
		[_unit, _HAT] call f_fnc_addWeapon;
	};

	// LOADOUT: HEAVY AT ASSISTANT GUNNER
	case "hatag":
	{
		[_typeOfUnit] call _backpack;
		_unit addMagazines [_carbinemag,_defMags];
		_unit addMagazines [_carbinemag_tr,_defMags_tr];
		[_unit, _carbine] call f_fnc_addWeapon;
		[_unit, _binos1] call f_fnc_addWeapon;
		_unit addMagazines [_grenade,1];
		_unit addMagazines [_smokegrenade,4];
	};

	// LOADOUT: MORTAR GUNNER
	case "mtrg":
	{
		[_typeOfUnit] call _backpack;
		_unit addMagazines [_carbinemag,_defMags];
		_unit addMagazines [_carbinemag_tr,_defMags_tr];
		[_unit, _carbine] call f_fnc_addWeapon;
		_unit addMagazines [_grenade,1];
		_unit addMagazines [_smokegrenade,4];
	};

	// LOADOUT: MORTAR ASSISTANT GUNNER
	case "mtrag":
	{
		[_typeOfUnit] call _backpack;
		_unit addMagazines [_carbinemag,_defMags];
		_unit addMagazines [_carbinemag_tr,_defMags_tr];
		[_unit, _carbine] call f_fnc_addWeapon;
		_unit addMagazines [_grenade,1];
		_unit addMagazines [_smokegrenade,4];
		[_unit, _binos1] call f_fnc_addWeapon;
	};

	// LOADOUT: MEDIUM SAM GUNNER
	case "msamg":
	{
		[_typeOfUnit] call _backpack;
		_unit addMagazines [_carbinemag,_defMags];
		_unit addMagazines [_carbinemag_tr,_defMags_tr];
		[_unit, _carbine] call f_fnc_addWeapon;
		_unit addMagazines [_grenade,1];
		_unit addMagazines [_smokegrenade,1];
		[_unit, _SAM] call f_fnc_addWeapon;
		
	};

	// LOADOUT: MEDIUM SAM ASSISTANT GUNNER
	case "msamag":
	{
		[_typeOfUnit] call _backpack;
		_unit addMagazines [_carbinemag,_defMags];
		_unit addMagazines [_carbinemag_tr,_defMags_tr];
		[_unit, _carbine] call f_fnc_addWeapon;
		[_unit, _binos1] call f_fnc_addWeapon;
		_unit addMagazines [_grenade,1];
		_unit addMagazines [_smokegrenade,1];
	};

	// LOADOUT: HEAVY SAM GUNNER
	case "hsamg":
	{
		[_typeOfUnit] call _backpack;
		_unit addMagazines [_carbinemag,_defMags];
		_unit addMagazines [_carbinemag_tr,_defMags_tr];
		[_unit, _carbine] call f_fnc_addWeapon;
		_unit addMagazines [_grenade,1];
		_unit addMagazines [_smokegrenade,1];
	};

	// LOADOUT: HEAVY SAM ASSISTANT GUNNER
	case "hsamag":
	{
		[_typeOfUnit] call _backpack;
		_unit addMagazines [_carbinemag,_defMags];
		_unit addMagazines [_carbinemag_tr,_defMags_tr];
		[_unit, _carbine] call f_fnc_addWeapon;
		[_unit, _binos1] call f_fnc_addWeapon;
		_unit addMagazines [_grenade,1];
		_unit addMagazines [_smokegrenade,1];
	};

	// LOADOUT: SNIPER
	case "sn":
	{
		_unit addMagazines [_SNrifleMag,_defMags_tr];
		_unit addMagazines [_SNrifleMag_tr,_defMags_tr];		
		[_unit, _SNrifle] call f_fnc_addWeapon;
		_unit addMagazines [_pistolmag,3];
		[_unit, _pistol] call f_fnc_addWeapon;
		_unit addMagazines [_smokegrenade,1];
		_attachments = _attach_sn;
	};

	// LOADOUT: SPOTTER
	case "sp":
	{
		["small"] call _backpack;
		_unit addMagazines [_glriflemag,_defMags];
		_unit addMagazines [_SNrifleMag,_defMags];
		_unit addMagazines [_glriflemag_tr,_defMags_tr];
		_unit addMagazines [_glmag,3];
		_unit addMagazines [_glsmoke,4];
		[_unit, _glrifle] call f_fnc_addWeapon;
		_unit addMagazines [_smokegrenade,1];
		[_unit, _binos1] call f_fnc_addWeapon;
	};

	// LOADOUT: VEHICLE COMMANDER
	case "vc":
	{
		["small"] call _backpack;
		_unit setUnitTrait ["engineer",1];
		_unit addMagazines [_smgmag,_defMags];
		_unit addMagazines [_smgmag_tr,_defMags];
		[_unit, _smg] call f_fnc_addWeapon;
		_unit addMagazines [_smokegrenade,4];
		[_unit, _binos1] call f_fnc_addWeapon;
	};

	// LOADOUT: VEHICLE DRIVER
	case "vd":
	{
		["small"] call _backpack;
		_unit setUnitTrait ["engineer",1];
		_unit addMagazines [_smgmag,_defMags];
		_unit addMagazines [_smgmag_tr,_defMags];
		[_unit, _smg] call f_fnc_addWeapon;
		_unit addMagazines [_smokegrenade,4];
	};

	// LOADOUT: VEHICLE GUNNER
	case "vg":
	{
		["small"] call _backpack;
		_unit setUnitTrait ["engineer",1];
		_unit addMagazines [_smgmag,_defMags];
		_unit addMagazines [_smgmag_tr,_defMags];
		[_unit, _smg] call f_fnc_addWeapon;
		_unit addMagazines [_smokegrenade,4];
	};

	// LOADOUT: AIR VEHICLE PILOTS
	case "pp":
	{
		//["cc"] call _backpack;
		_unit setUnitTrait ["engineer",1];
		_unit addMagazines [_smgmag,_defMags];
		_unit addMagazines [_smgmag_tr,_defMags];
		[_unit, _smg] call f_fnc_addWeapon;
		_unit addMagazines [_smokegrenade,4];
	};

	// LOADOUT: AIR VEHICLE CREW CHIEF
	case "pcc":
	{
		//["cc"] call _backpack;
		_unit setUnitTrait ["engineer",1];
		_unit addMagazines [_smgmag,_defMags];
		_unit addMagazines [_smgmag_tr,_defMags];
		[_unit, _smg] call f_fnc_addWeapon;
		_unit addMagazines [_smokegrenade,4];
	};

	// LOADOUT: AIR VEHICLE CREW
	case "pc":
	{
		_unit setUnitTrait ["engineer",1];
		_unit addMagazines [_smgmag,_defMags];
		_unit addMagazines [_smgmag_tr,_defMags];		
		[_unit, _smg] call f_fnc_addWeapon;
		_unit addMagazines [_smokegrenade,4];
	};

	// LOADOUT: ENGINEER (DEMO)
	case "eng":
	{
		[_typeOfUnit] call _backpack;
		_unit setUnitTrait ["engineer",1];
		_unit setUnitTrait ["explosiveSpecialist",1];
		_unit addItem "MineDetector";
		_unit addMagazines [_carbinemag,_defMags];
		_unit addMagazines [_carbinemag_tr,_defMags_tr];		
		[_unit, _carbine] call f_fnc_addWeapon;
		_unit addMagazines [_smokegrenade,4];
		_unit addMagazines [_grenade,1];
		_unit addMagazines [_satchel,2];
		_unit addMagazines [_APmine2,6];
	};

	// LOADOUT: ENGINEER (MINES)
	case "engm":
	{
		[_typeOfUnit] call _backpack;
		_unit setUnitTrait ["engineer",1];
		_unit setUnitTrait ["explosiveSpecialist",1];
		_unit addItem "MineDetector";
		_unit addMagazines [_carbinemag,_defMags];
		_unit addMagazines [_carbinemag_tr,_defMags_tr];		
		[_unit, _carbine] call f_fnc_addWeapon;
		_unit addMagazines [_smokegrenade,4];
		_unit addMagazines [_grenade,1];
		_unit addMagazines [_APmine2,10];
	};

	// LOADOUT: UAV OPERATOR
	case "uav":
	{
		[_typeOfUnit] call _backpack;
		_unit addMagazines [_smgmag,_defMags];
		_unit addMagazines [_smgmag_tr,_defMags];		
		[_unit, _smg] call f_fnc_addWeapon;
		_unit addMagazines [_smokegrenade,4];
		_unit addMagazines [_grenade,1];
		_unit linkItem _uavterminal;
		_unit addMagazines ["Laserbatteries",4];	// Batteries added for the F3 UAV Recharging component
	};

	// LOADOUT: DIVER
	case "div":
	{
		[_typeOfUnit] call _backpack;
		_unit addMagazines [_diverMag1,_defMags];
		_unit addMagazines [_diverMag2,_defMags_tr];
		[_unit, _diverWep] call f_fnc_addWeapon;
		_unit addMagazines [_smokegrenade,3];
		_unit addMagazines [_grenade,2];
	};

	// LOADOUT: RIFLEMAN
	case "r":
	{
		[_typeOfUnit] call _backpack;
		_unit addMagazines [_riflemag,_defMags];
		_unit addMagazines [_riflemag_tr,_defMags_tr];
		[_unit, _rifle] call f_fnc_addWeapon;
		_unit addMagazines [_smokegrenade,3];
		_unit addMagazines [_grenade,2];
	};

// LOADOUT: CARABINEER
	case "car":
	{
		[_typeOfUnit] call _backpack;
		_unit addMagazines [_carbinemag,_defMags];
		_unit addMagazines [_carbinemag_tr,_defMags_tr];
		[_unit, _carbine] call f_fnc_addWeapon;
		_unit addMagazines [_smokegrenade,3];
		_unit addMagazines [_grenade,2];
	};

	// LOADOUT: SUBMACHINEGUNNER
	case "smg":
	{
		[_typeOfUnit] call _backpack;
		_unit addMagazines [_smgmag,_defMags];
		_unit addMagazines [_smgmag_tr,_defMags];		
		[_unit, _smg] call f_fnc_addWeapon;
		_unit addMagazines [_smokegrenade,3];
		_unit addMagazines [_grenade,2];
	};

	// LOADOUT: GRENADIER
	case "gren":
	{
		["g"] call _backpack;
		_unit addMagazines [_glriflemag,_defMags];
		_unit addMagazines [_glriflemag_tr,_defMags_tr];
		[_unit, _glrifle] call f_fnc_addWeapon;
		_unit addMagazines [_glmag,6];
		_unit addMagazines [_glsmoke,2];
		_unit addMagazines [_glflare,2];
		_unit addMagazines [_smokegrenade,3];
		_unit addMagazines [_grenade,2];
	};

	case "empty": 
	{
		_skipCheck = true;
	};
	
	#include "f_vehicle_loadout.sqf";

	// LOADOUT: DEFAULT/UNDEFINED (use RIFLEMAN)
   default
   {
		_unit addMagazines [_riflemag,_defMags];
		[_unit, _rifle] call f_fnc_addWeapon;

		_unit selectWeapon primaryWeapon _unit;

		if (true) exitWith {diag_log text format ["[F3] DEBUG (f_loadout_sog_west_usarmy.sqf): Unit = %1. Gear template %2 does not exist!",_unit,_typeOfUnit]};
   };

// END SWITCH FOR DEFINE UNIT TYPE LOADOUTS
};

// Handle weapon attachments
#include "..\..\f\assignGear\f_assignGear_attachments.sqf";


// ENSURE UNIT HAS CORRECT WEAPON SELECTED ON SPAWNING

_unit selectWeapon primaryWeapon _unit;