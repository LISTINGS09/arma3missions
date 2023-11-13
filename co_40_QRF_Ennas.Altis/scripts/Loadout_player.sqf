//playerLoadout.sqf
//
//Originally made by Highmatic for classes with realistic gear
//modified by Dmitry Yuri for Zeus Modified Invade and Annex

waitUntil {!isNull player && isPlayer player};

removeAllItems player;
removeAllAssignedItems player;
removeAllWeapons player;
removeBackpack player;
removeHeadgear player;
removeVest player;

switch (typeOf player) do
{
	//---West side loadouts
		
	case "C_journalist_F": // Press
	{
		player addUniform "U_C_Journalist";
		player addVest "V_Press_F";
		player addHeadgear "H_Cap_press";
		player addBackpack "B_Kitbag_base";
		
		player addItem "ItemGPS";
		player assignItem "ItemGPS";
		player addItem "itemMap";
		player assignItem "itemMap";
		player addItem "itemRadio";
		player assignItem "itemRadio";
		player addItem "itemCompass";
		player assignItem "itemCompass";
		player addItem "itemWatch";
		player assignItem "itemWatch";
			
		(unitBackpack player) additemCargo ["acc_flashlight",1];
		(unitBackpack player) additemCargoGlobal ["FirstAidKit",4];
	};
	
	//---Main platoon loadout
	case "B_officer_F":  // Platoon Officer
	{
		player addUniform "U_B_CombatUniform_mcam_vest";
		player addVest "V_PlateCarrier1_blk";
		player addHeadgear "H_HelmetB_camo";
		player addBackpack "B_Kitbag_base";
		player addGoggles "G_Tactical_Clear";
		
		player addItem "FirstAidKit";
		player addItem "FirstAidKit";
		player addItem "ItemGPS";
		player assignItem "ItemGPS";
		player addItem "itemMap";
		player assignItem "itemMap";
		player addItem "itemRadio";
		player assignItem "itemRadio";
		player addItem "itemCompass";
		player assignItem "itemCompass";
		player addItem "itemWatch";
		player assignItem "itemWatch";
		
		player addMagazines ["30Rnd_556x45_Stanag",13];
		player addMagazines ["30Rnd_556x45_Stanag_Tracer_Red",3];
		player addMagazines ["16Rnd_9x21_Mag",3];
		player addMagazines ["Chemlight_green",2];
		player addMagazines ["Chemlight_red",2];
		player addMagazines ["SmokeShellGreen",2];
		player addMagazines ["SmokeShellRed",2];
		player addMagazines ["SmokeShell",4];
		player addMagazines ["HandGrenade",2];

		player addMagazines ["HandGrenade",2];
		
		(unitBackpack player) additemCargo ["acc_flashlight",1];
		// (unitBackpack player) additemCargoGlobal ["ACRE_PRC148",1];
		// (unitBackpack player) additemCargo ["NVGoggles",1];
		(unitBackpack player) additemCargoGlobal ["optic_Nightstalker",1];
		
		player addWeapon "Rangefinder";
		player addWeapon "arifle_Mk20C_plain_F";
		player addWeapon "hgun_P07_F";
		
		player addPrimaryWeaponItem "acc_pointer_IR";
		player addPrimaryWeaponItem "optic_MRCO";
	};
	
	case "B_Soldier_SL_F":  // Squad Leader
	{
		player addUniform "U_B_CombatUniform_mcam_vest";
		player addVest "V_PlateCarrierGL_rgr";
		player addHeadgear "H_HelmetB_camo";
		player addBackpack "B_Kitbag_base";
		player addGoggles "G_Tactical_Clear";
		
		player addItem "FirstAidKit";
		player addItem "FirstAidKit";
		player addItem "ItemGPS";
		player assignItem "ItemGPS";
		player addItem "itemMap";
		player assignItem "itemMap";
		player addItem "itemRadio";
		player assignItem "itemRadio";
		player addItem "itemCompass";
		player assignItem "itemCompass";
		player addItem "itemWatch";
		player assignItem "itemWatch";
		
		player addMagazines ["30Rnd_556x45_Stanag",13];
		player addMagazines ["30Rnd_556x45_Stanag_Tracer_Red",3];
		player addMagazines ["16Rnd_9x21_Mag",3];
		player addMagazines ["Chemlight_green",3];
		player addMagazines ["Chemlight_red",3];
		player addMagazines ["1Rnd_HE_Grenade_shell",5];
		player addMagazines ["1Rnd_Smoke_Grenade_shell",2];
		player addMagazines ["1Rnd_SmokeRed_Grenade_shell",1];
		player addMagazines ["1Rnd_SmokeGreen_Grenade_shell",1];
		player addMagazines ["UGL_FlareWhite_F",2];
		player addMagazines ["Laserbatteries",3];
		player addMagazines ["HandGrenade",3];
		player addMagazines ["SmokeShellGreen",2];
		player addMagazines ["SmokeShellRed",2];

		
		(unitBackpack player) additemCargo ["acc_flashlight",1];
		// (unitBackpack player) additemCargo ["ACRE_PRC148",1];
		// (unitBackpack player) additemCargo ["NVGoggles",1];
		// (unitBackpack player) additemCargoGlobal ["optic_Nightstalker",1];
		
		player addWeapon "Laserdesignator";
		player addWeapon "arifle_Mk20_GL_plain_F";
		player addWeapon "hgun_P07_F";
		
		player addPrimaryWeaponItem "acc_pointer_IR";
		player addPrimaryWeaponItem "optic_MRCO";
		
	};
	
	case "B_Soldier_TL_F":  // Team Leader
	{
		player addUniform "U_B_CombatUniform_mcam";
		player addVest "V_PlateCarrierGL_rgr";
		player addHeadgear "H_HelmetB_camo";
		player addBackpack "B_Kitbag_base";
		player addGoggles "G_Tactical_Clear";
		
		player addItem "FirstAidKit";
		player addItem "FirstAidKit";
		player addItem "ItemGPS";
		player assignItem "ItemGPS";
		player addItem "itemMap";
		player assignItem "itemMap";
		player addItem "itemRadio";
		player assignItem "itemRadio";
		player addItem "itemCompass";
		player assignItem "itemCompass";
		player addItem "itemWatch";
		player assignItem "itemWatch";
		
		player addMagazines ["30Rnd_556x45_Stanag",13];
		player addMagazines ["30Rnd_556x45_Stanag_Tracer_Red",3];
		player addMagazines ["16Rnd_9x21_Mag",3];
		player addMagazines ["Chemlight_green",1];
		player addMagazines ["Chemlight_red",1];
		player addMagazines ["1Rnd_HE_Grenade_shell",9];
		player addMagazines ["1Rnd_Smoke_Grenade_shell",3];
		player addMagazines ["1Rnd_SmokeRed_Grenade_shell",2];
		player addMagazines ["1Rnd_SmokeGreen_Grenade_shell",2];
		player addMagazines ["UGL_FlareWhite_F",2];
		player addMagazines ["Laserbatteries",3];

		
		(unitBackpack player) additemCargo ["acc_flashlight",1];
		// (unitBackpack player) additemCargo ["NVGoggles",1];
		
		player addWeapon "Laserdesignator";
		player addWeapon "arifle_Mk20_GL_plain_F";
		player addWeapon "hgun_P07_F";
		
		// player addPrimaryWeaponItem "acc_pointer_IR";
		player addPrimaryWeaponItem "optic_MRCO";
		
	};
	
	case "B_Soldier_GL_F":  // Grenadier
	{
		player addUniform "U_B_CombatUniform_mcam";
		player addVest "V_PlateCarrierGL_rgr";
		player addHeadgear "H_HelmetB_camo";
		player addBackpack "B_Kitbag_base";
		player addGoggles "G_Lowprofile";
		
		player addItem "FirstAidKit";
		player addItem "FirstAidKit";
		player addItem "itemMap";
		player assignItem "itemMap";
		player addItem "itemRadio";
		player assignItem "itemRadio";
		player addItem "itemCompass";
		player assignItem "itemCompass";
		player addItem "itemWatch";
		player assignItem "itemWatch";
		
		player addMagazines ["30Rnd_556x45_Stanag",13];
		player addMagazines ["16Rnd_9x21_Mag",3];
		player addMagazines ["Chemlight_green",1];
		player addMagazines ["Chemlight_red",1];
		player addMagazines ["1Rnd_HE_Grenade_shell",9];
		player addMagazines ["1Rnd_Smoke_Grenade_shell",3];
		player addMagazines ["1Rnd_SmokeRed_Grenade_shell",2];
		player addMagazines ["1Rnd_SmokeGreen_Grenade_shell",2];
		player addMagazines ["UGL_FlareWhite_F",2];
		player addMagazines ["HandGrenade",3]; 

		
		(unitBackpack player) additemCargo ["acc_flashlight",1];
		// (unitBackpack player) additemCargo ["NVGoggles",1];
		
		player addWeapon "arifle_Mk20_GL_plain_F";
		player addWeapon "hgun_P07_F";	
		
		// player addPrimaryWeaponItem "acc_pointer_IR";
		player addPrimaryWeaponItem "optic_MRCO";
		
	};
	
	case "B_Soldier_F":  // Rifleman
	{
		player addUniform "U_B_CombatUniform_mcam";
		player addVest "V_PlateCarrier2_rgr";
		player addHeadgear "H_HelmetB_camo";
		player addBackpack "B_Kitbag_base";
		player addGoggles "G_Lowprofile";
		
		player addItem "FirstAidKit";
		player addItem "FirstAidKit";
		player addItem "itemMap";
		player assignItem "itemMap";
		player addItem "itemRadio";
		player assignItem "itemRadio";
		player addItem "itemCompass";
		player assignItem "itemCompass";
		player addItem "itemWatch";
		player assignItem "itemWatch";
		
		player addMagazines ["30Rnd_556x45_Stanag",13];
		player addMagazines ["16Rnd_9x21_Mag",3];
		player addMagazines ["Chemlight_green",1];
		player addMagazines ["Chemlight_red",1];
		player addMagazines ["SmokeShellGreen",1];
		player addMagazines ["SmokeShellRed",1];
		player addMagazines ["SmokeShell",3];
		player addMagazines ["HandGrenade",4];

		
		(unitBackpack player) additemCargo ["acc_flashlight",1];
		// (unitBackpack player) additemCargo ["NVGoggles",1];
		
		player addWeapon "arifle_Mk20C_plain_F";
		player addWeapon "hgun_P07_F";
		
		// player addPrimaryWeaponItem "acc_pointer_IR";
		player addPrimaryWeaponItem "optic_Hamr";
		
	};
	
	case "B_soldier_M_F":  // Marksman
	{
		player addUniform "U_B_CombatUniform_mcam";
		player addVest "V_PlateCarrier2_rgr";
		player addBackpack "B_Kitbag_base";
		player addHeadgear "H_HelmetB_camo";
		player addGoggles "G_Lowprofile";
		
		player addItem "FirstAidKit";
		player addItem "FirstAidKit";
		player addItem "itemMap";
		player assignItem "itemMap";
		player addItem "itemRadio";
		player assignItem "itemRadio";
		player addItem "itemCompass";
		player assignItem "itemCompass";
		player addItem "itemWatch";
		player assignItem "itemWatch";
		
		player addMagazines ["20Rnd_762x51_Mag",11];
		player addMagazines ["16Rnd_9x21_Mag",2];
		player addMagazines ["SmokeShellGreen",1];
		player addMagazines ["SmokeShellRed",1];
		player addMagazines ["SmokeShell",2];
		player addMagazines ["HandGrenade",3];

		
		(unitBackpack player) additemCargo ["acc_flashlight",1];
		// (unitBackpack player) additemCargo ["NVGoggles",1];
		
		player addWeapon "srifle_EBR_F";
		player addWeapon "hgun_P07_F";
		player addWeapon "Rangefinder";
		
		// player addPrimaryWeaponItem "acc_pointer_IR";
		player addPrimaryWeaponItem "optic_SOS";
		player addItem "optic_NVS";
		player addItem "muzzle_snds_B";
	};
	
	case "B_soldier_AR_F":  // Autorifleman
	{
		player addUniform "U_B_CombatUniform_mcam";
		player addVest "V_PlateCarrierGL_rgr";
		player addBackpack "B_Carryall_khk";
		player addHeadgear "H_HelmetB_camo";
		player addGoggles "G_Lowprofile";
		
		player addItem "FirstAidKit";
		player addItem "FirstAidKit";
		player addItem "itemMap";
		player assignItem "itemMap";
		player addItem "itemRadio";
		player assignItem "itemRadio";
		player addItem "itemCompass";
		player assignItem "itemCompass";
		player addItem "itemWatch";
		player assignItem "itemWatch";
		
		player addMagazines ["16Rnd_9x21_Mag",3];
		player addMagazines ["Chemlight_green",1];
		player addMagazines ["Chemlight_red",1];
		player addMagazines ["SmokeShellGreen",1];
		player addMagazines ["SmokeShellRed",1];
		player addMagazines ["SmokeShell",3];
		player addMagazines ["HandGrenade",4];
		player addMagazines ["200Rnd_65x39_cased_Box",7];

		
		(unitBackpack player) additemCargo ["acc_flashlight",1];
		// (unitBackpack player) additemCargo ["NVGoggles",1];
		
		player addWeapon "LMG_Mk200_F";
		player addWeapon "hgun_P07_F";
		
		// player addPrimaryWeaponItem "acc_pointer_IR";
		player addPrimaryWeaponItem "optic_MRCO";
	};
	
	case "B_soldier_LAT_F":  // Rifleman (AT)
	{
		player addUniform "U_B_CombatUniform_mcam";
		player addVest "V_PlateCarrier2_rgr";
		player addHeadgear "H_HelmetB_camo";
		player addBackpack "B_Kitbag_base";
		player addGoggles "G_Lowprofile";
		
		player addItem "FirstAidKit"; player addItem "FirstAidKit";
		player addItem "itemMap";
		player assignItem "itemMap";
		player addItem "itemRadio";
		player assignItem "itemRadio";
		player addItem "itemCompass";
		player assignItem "itemCompass";
		player addItem "itemWatch";
		player assignItem "itemWatch";
		
		player addMagazines ["30Rnd_556x45_Stanag",13];
		player addMagazines ["16Rnd_9x21_Mag",3];
		player addMagazines ["Chemlight_green",1];
		player addMagazines ["Chemlight_red",1];
		player addMagazines ["SmokeShellGreen",1];
		player addMagazines ["SmokeShellRed",1];
		player addMagazines ["SmokeShell",3];
		player addMagazines ["HandGrenade",4];
		player addMagazines ["NLAW_F",1];

		
		(unitBackpack player) addMagazineCargo ["NLAW_F",3];
		(unitBackpack player) additemCargo ["acc_flashlight",1];
		// (unitBackpack player) additemCargo ["NVGoggles",1];
		
		player addWeapon "arifle_Mk20C_plain_F";
		player addWeapon "launch_NLAW_F";
		player addWeapon "hgun_P07_F";
		
		// player addPrimaryWeaponItem "acc_pointer_IR";
		player addPrimaryWeaponItem "optic_Aco";
		
	};
	
	case "B_soldier_AAR_F":  // Asst. Automatic Rifleman
	{
		player addUniform "U_B_CombatUniform_mcam";
		player addVest "V_PlateCarrier2_rgr";
		player addHeadgear "H_HelmetB_camo";
		player addBackpack "B_Carryall_khk";
		player addGoggles "G_Lowprofile";
		
		player addItem "FirstAidKit"; player addItem "FirstAidKit";
		player addItem "itemMap";
		player assignItem "itemMap";
		player addItem "itemRadio";
		player assignItem "itemRadio";
		player addItem "itemCompass";
		player assignItem "itemCompass";
		player addItem "itemWatch";
		player assignItem "itemWatch";
		
		player addMagazines ["30Rnd_556x45_Stanag",13];
		player addMagazines ["16Rnd_9x21_Mag",3];
		player addMagazines ["Chemlight_green",1];
		player addMagazines ["Chemlight_red",1];
		player addMagazines ["SmokeShellGreen",1];
		player addMagazines ["SmokeShellRed",1];
		player addMagazines ["SmokeShell",3];
		player addMagazines ["HandGrenade",4];

		
		(unitBackpack player) addMagazineCargo ["30Rnd_556x45_Stanag_Tracer_Red",4];
		(unitBackpack player) addMagazineCargo ["200Rnd_65x39_cased_Box",4];
		(unitBackpack player) addMagazineCargo ["200Rnd_65x39_cased_Box_Tracer",1];
		(unitBackpack player) addMagazineCargo ["HandGrenade",4];
		(unitBackpack player) addMagazineCargo ["SmokeShell",4];
		
		(unitBackpack player) additemCargo ["acc_flashlight",1];
		// (unitBackpack player) additemCargo ["NVGoggles",1];
		
		player addWeapon "arifle_Mk20C_plain_F";
		player addWeapon "hgun_P07_F";
		
		// player addPrimaryWeaponItem "acc_pointer_IR";
		player addPrimaryWeaponItem "optic_MRCO";
		
	};
	
	case "B_Soldier_A_F":  // Ammo Bearer
	{
		player addUniform "U_B_CombatUniform_mcam";
		player addVest "V_PlateCarrier2_rgr";
		player addHeadgear "H_HelmetB_camo";
		player addBackpack "B_Carryall_khk";
		player addGoggles "G_Lowprofile";
		
		player addItem "FirstAidKit"; player addItem "FirstAidKit";
		player addItem "itemMap";
		player assignItem "itemMap";
		player addItem "itemRadio";
		player assignItem "itemRadio";
		player addItem "itemCompass";
		player assignItem "itemCompass";
		player addItem "itemWatch";
		player assignItem "itemWatch";
		
		player addMagazines ["30Rnd_556x45_Stanag",11];
		player addMagazines ["16Rnd_9x21_Mag",3];
		player addMagazines ["Chemlight_green",1];
		player addMagazines ["Chemlight_red",1];
		player addMagazines ["SmokeShellGreen",1];
		player addMagazines ["SmokeShellRed",1];
		player addMagazines ["SmokeShell",3];
		player addMagazines ["HandGrenade",4];
		player addMagazines ["B_IR_Grenade",3];
		
		(unitBackpack player) addMagazineCargo ["30Rnd_556x45_Stanag",10];
		(unitBackpack player) addMagazineCargo ["30Rnd_556x45_Stanag_Tracer_Red",3];
		(unitBackpack player) addMagazineCargo ["200Rnd_65x39_cased_Box",2];
		(unitBackpack player) addMagazineCargo ["200Rnd_65x39_cased_Box_Tracer",1];
		(unitBackpack player) addMagazineCargo ["NLAW_F",2];
		(unitBackpack player) additemCargo ["acc_flashlight",1];
		// (unitBackpack player) additemCargo ["NVGoggles",1];
		
		player addWeapon "arifle_Mk20C_plain_F";
		player addWeapon "hgun_P07_F";
		
		// player addPrimaryWeaponItem "acc_pointer_IR";
		player addPrimaryWeaponItem "optic_Aco";
		
	};
	
	case "B_medic_F":  // Combat Life Saver
	{
		player addUniform "U_B_CombatUniform_mcam";
		player addVest "V_PlateCarrier2_rgr";
		player addHeadgear "H_Cap_khaki_specops_UK";
		player addBackpack "B_Kitbag_base";
		player addGoggles "G_Tactical_Clear";
		
		player addItem "FirstAidKit"; player addItem "FirstAidKit";
		player addItem "itemMap";
		player assignItem "itemMap";
		player addItem "itemRadio";
		player assignItem "itemRadio";
		player addItem "itemCompass";
		player assignItem "itemCompass";
		player addItem "itemWatch";
		player assignItem "itemWatch";
		
		player addMagazines ["30Rnd_556x45_Stanag",13];
		player addMagazines ["16Rnd_9x21_Mag",3];
		player addMagazines ["Chemlight_green",4];
		player addMagazines ["Chemlight_red",4];
		player addMagazines ["SmokeShellGreen",4];
		player addMagazines ["SmokeShellRed",4];
		player addMagazines ["SmokeShell",2];
		player addMagazines ["SmokeShellYellow",4];
		player addMagazines ["HandGrenade",2];

		
		(unitBackpack player) additemCargo ["FirstAidKit",14];
		(unitBackpack player) additemCargoGlobal ["Medikit",1];
		// (unitBackpack player) additemCargo ["acc_pointer_IR",1];
		// (unitBackpack player) additemCargo ["NVGoggles",1];
		
		player addWeapon "arifle_Mk20_plain_F";
		player addWeapon "hgun_P07_F";
		
		player addPrimaryWeaponItem "acc_flashlight";
		player addPrimaryWeaponItem "optic_Aco";
		
	};
	
	case "B_soldier_exp_F":  // Explosive Specialist
	{
		player addUniform "U_B_CombatUniform_mcam";
		player addVest "V_PlateCarrier2_rgr";
		Player addHeadgear "H_HelmetB_camo";
		player addBackpack "B_Kitbag_base";
		player addGoggles "G_Lowprofile";
		
		player addItem "FirstAidKit"; player addItem "FirstAidKit";
		player addItem "itemMap";
		player assignItem "itemMap";
		player addItem "itemRadio";
		player assignItem "itemRadio";
		player addItem "itemCompass";
		player assignItem "itemCompass";
		player addItem "itemWatch";
		player assignItem "itemWatch";
		
		player addMagazines ["30Rnd_556x45_Stanag",13];
		player addMagazines ["16Rnd_9x21_Mag",3];
		player addMagazines ["Chemlight_green",2];
		player addMagazines ["Chemlight_red",2];
		player addMagazines ["SmokeShellGreen",2];
		player addMagazines ["SmokeShellRed",2];
		player addMagazines ["SmokeShell",6];
		player addMagazines ["HandGrenade",2];
		player addMagazines ["SatchelCharge_Remote_Mag",4];

		
		// (unitBackpack player) additemCargo ["NVGoggles",1];
		
		player addWeapon "arifle_Mk20_plain_F";
		player addWeapon "hgun_P07_F";
		
		// player addPrimaryWeaponItem "acc_pointer_IR";
		player addPrimaryWeaponItem "optic_Aco";
		
	};
	
	case "B_soldier_repair_F":  // Repair Specialist
	{
		player addUniform "U_B_CombatUniform_mcam";
		player addVest "V_PlateCarrier2_rgr";
		Player addHeadgear "H_HelmetB_camo";
		player addBackpack "B_Kitbag_base";
		player addGoggles "G_Lowprofile";
		
		player addItem "FirstAidKit"; player addItem "FirstAidKit";
		player addItem "itemMap";
		player assignItem "itemMap";
		player addItem "itemRadio";
		player assignItem "itemRadio";
		player addItem "itemCompass";
		player assignItem "itemCompass";
		player addItem "itemWatch";
		player assignItem "itemWatch";
		
		player addMagazines ["30Rnd_556x45_Stanag",13];
		player addMagazines ["16Rnd_9x21_Mag",3];
		player addMagazines ["Chemlight_green",2];
		player addMagazines ["Chemlight_red",2];
		player addMagazines ["SmokeShellGreen",2];
		player addMagazines ["SmokeShellRed",2];
		player addMagazines ["SmokeShell",6];
		player addMagazines ["HandGrenade",2];

		
		(unitBackpack player) additemCargo ["ToolKit",1];
		// (unitBackpack player) additemCargo ["NVGoggles",1];
		
		player addWeapon "arifle_Mk20_plain_F";
		player addWeapon "hgun_P07_F";
		
		// player addPrimaryWeaponItem "acc_pointer_IR";
		player addPrimaryWeaponItem "optic_Aco";
		
	};
	
	//---Support Element loadouts
	
	case "B_support_MG_F":  // Gunner (Mk30)
	{
		player addUniform "U_B_CombatUniform_mcam";
		player addVest "V_PlateCarrier2_rgr";
		player addHeadgear "H_HelmetB_camo";
		player addBackpack "B_HMG_01_weapon_F";
		player addGoggles "G_Lowprofile";
		
		player addItem "FirstAidKit"; player addItem "FirstAidKit";
		player addItem "itemMap";
		player assignItem "itemMap";
		player addItem "itemRadio";
		player assignItem "itemRadio";
		player addItem "itemCompass";
		player assignItem "itemCompass";
		player addItem "itemWatch";
		player assignItem "itemWatch";
		
		player addMagazines ["30Rnd_556x45_Stanag",13];
		player addMagazines ["16Rnd_9x21_Mag",3];
		player addMagazines ["Chemlight_green",1];
		player addMagazines ["Chemlight_red",1];
		player addMagazines ["SmokeShellGreen",1];
		player addMagazines ["SmokeShellRed",1];
		player addMagazines ["SmokeShell",3];
		player addMagazines ["HandGrenade",4];

		
		// (unitBackpack player) additemCargo ["NVGoggles",1];
		
		player addWeapon "arifle_Mk20C_plain_F";
		player addWeapon "hgun_P07_F";
		
		// player addPrimaryWeaponItem "acc_pointer_IR";
		player addPrimaryWeaponItem "optic_Hamr";
		
	};
	
	case "B_support_AMG_F":  // Asst. Gunner (Mk30/GMG)
	{
		player addUniform "U_B_CombatUniform_mcam";
		player addVest "V_PlateCarrier2_rgr";
		player addHeadgear "H_HelmetB_camo";
		player addBackpack "B_HMG_01_support_F";
		player addGoggles "G_Lowprofile";
		
		player addItem "FirstAidKit"; player addItem "FirstAidKit";
		player addItem "itemMap";
		player assignItem "itemMap";
		player addItem "itemRadio";
		player assignItem "itemRadio";
		player addItem "itemCompass";
		player assignItem "itemCompass";
		player addItem "itemWatch";
		player assignItem "itemWatch";
		
		player addMagazines ["30Rnd_556x45_Stanag",13];
		player addMagazines ["16Rnd_9x21_Mag",3];
		player addMagazines ["Chemlight_green",1];
		player addMagazines ["Chemlight_red",1];
		player addMagazines ["SmokeShellGreen",1];
		player addMagazines ["SmokeShellRed",1];
		player addMagazines ["SmokeShell",3];
		player addMagazines ["HandGrenade",4];

		
		player addWeapon "arifle_Mk20C_plain_F";
		player addWeapon "hgun_P07_F";
		player addweapon "Rangefinder";
		
		// (unitBackpack player) additemCargo ["NVGoggles",1];
		
		// player addPrimaryWeaponItem "acc_pointer_IR";
		player addPrimaryWeaponItem "optic_Aco";
		
	};
	
	case "B_soldier_UAV_F":  // UAV Operator
	{
		player addUniform "U_B_CombatUniform_mcam";
		player addVest "V_PlateCarrier2_rgr";
		Player addHeadgear "H_HelmetB_camo";
		player addBackpack "B_UAV_01_backpack_F";
		player addGoggles "G_Lowprofile";
		
		player addItem "FirstAidKit"; player addItem "FirstAidKit";
		player addItem "itemMap";
		player assignItem "itemMap";
		player addItem "itemRadio";
		player assignItem "itemRadio";
		player addItem "itemCompass";
		player assignItem "itemCompass";
		player addItem "itemWatch";
		player assignItem "itemWatch";
		player addItem "B_UavTerminal";
		player assignItem "B_UavTerminal";
		
		player addMagazines ["30Rnd_556x45_Stanag",13];
		player addMagazines ["16Rnd_9x21_Mag",3];
		player addMagazines ["Chemlight_green",2];
		player addMagazines ["Chemlight_red",2];
		player addMagazines ["SmokeShellGreen",2];
		player addMagazines ["SmokeShellRed",2];
		player addMagazines ["SmokeShell",6];
		player addMagazines ["HandGrenade",2];

		
		player addWeapon "arifle_Mk20_plain_F";
		player addWeapon "hgun_P07_F";
		
		// (unitBackpack player) additemCargo ["NVGoggles",1];
		
		// player addPrimaryWeaponItem "acc_pointer_IR";
		player addPrimaryWeaponItem "optic_Aco";
		
	};
	
	case "B_engineer_F":  // Engineer
	{
		player addUniform "U_B_CombatUniform_mcam";
		player addVest "V_PlateCarrier2_rgr";
		player addHeadgear "H_Booniehat_tan";
		player addBackpack "B_Carryall_mcamo";
		player addGoggles "G_Lowprofile";
		
		player addItem "FirstAidKit"; player addItem "FirstAidKit";
		player addItem "itemMap";
		player assignItem "itemMap";
		player addItem "itemRadio";
		player assignItem "itemRadio";
		player addItem "itemCompass";
		player assignItem "itemCompass";
		player addItem "itemWatch";
		player assignItem "itemWatch";
		
		player addMagazines ["30Rnd_556x45_Stanag",13];
		player addMagazines ["16Rnd_9x21_Mag",3];
		player addMagazines ["Chemlight_green",2];
		player addMagazines ["Chemlight_red",2];
		player addMagazines ["SmokeShellGreen",2];
		player addMagazines ["SmokeShellRed",2];
		player addMagazines ["SmokeShell",6];
		player addMagazines ["HandGrenade",2];

		
		(unitBackpack player) addMagazineCargo ["ClaymoreDirectionalMine_Remote_Mag",3];
		(unitBackpack player) addMagazineCargo ["APERSMine_Range_Mag",4];
		(unitBackpack player) addMagazineCargo ["SatchelCharge_Remote_Mag",1];
		(unitBackpack player) addMagazineCargo ["ATMine_Range_Mag",1];
		(unitBackpack player) additemCargo ["ToolKit",1];
		(unitBackpack player) additemCargo ["MineDetector",1];
		
		player addWeapon "arifle_Mk20C_plain_F";
		player addWeapon "hgun_P07_F";
		
		// (unitBackpack player) additemCargo ["NVGoggles",1];
		
		// player addPrimaryWeaponItem "acc_pointer_IR";
		player addPrimaryWeaponItem "optic_Hamr";
		
	};
	
	case "B_soldier_AT_F":  // Missile Specialist (AT)
	{
		player addUniform "U_B_CombatUniform_mcam";
		player addVest "V_PlateCarrier2_rgr";
		Player addHeadgear "H_HelmetB_camo";
		player addBackpack "B_Kitbag_base";
		player addGoggles "G_Lowprofile";
		
		player addItem "FirstAidKit"; player addItem "FirstAidKit";
		player addItem "itemMap";
		player assignItem "itemMap";
		player addItem "itemRadio";
		player assignItem "itemRadio";
		player addItem "itemCompass";
		player assignItem "itemCompass";
		player addItem "itemWatch";
		player assignItem "itemWatch";
		
		player addMagazines ["30Rnd_556x45_Stanag",13];
		player addMagazines ["16Rnd_9x21_Mag",3];
		player addMagazines ["Chemlight_green",2];
		player addMagazines ["Chemlight_red",2];
		player addMagazines ["SmokeShellGreen",2];
		player addMagazines ["SmokeShellRed",2];
		player addMagazines ["SmokeShell",6];
		player addMagazines ["HandGrenade",2];
		player addMagazines ["Titan_AT",1];

		
		(unitBackpack player) addMagazineCargo ["Titan_AT",2];
		(unitBackpack player) addMagazineCargo ["Titan_AP",2];
		// (unitBackpack player) additemCargo ["NVGoggles",1];
		
		player addWeapon "launch_Titan_short_F";
		player addWeapon "arifle_Mk20_plain_F";
		player addWeapon "hgun_P07_F";
		
		// player addPrimaryWeaponItem "acc_pointer_IR";
		player addPrimaryWeaponItem "optic_Aco";
		
	};
	
	case "B_soldier_AA_F":  // Missile Specialist (AA)
	{
		player addUniform "U_B_CombatUniform_mcam";
		player addVest "V_PlateCarrier2_rgr";
		Player addHeadgear "H_HelmetB_camo";
		player addBackpack "B_Kitbag_base";
		player addGoggles "G_Lowprofile";
		
		player addItem "FirstAidKit"; player addItem "FirstAidKit";
		player addItem "itemMap";
		player assignItem "itemMap";
		player addItem "itemRadio";
		player assignItem "itemRadio";
		player addItem "itemCompass";
		player assignItem "itemCompass";
		player addItem "itemWatch";
		player assignItem "itemWatch";
		
		player addMagazines ["30Rnd_556x45_Stanag",13];
		player addMagazines ["16Rnd_9x21_Mag",3];
		player addMagazines ["Chemlight_green",2];
		player addMagazines ["Chemlight_red",2];
		player addMagazines ["SmokeShellGreen",2];
		player addMagazines ["SmokeShellRed",2];
		player addMagazines ["SmokeShell",6];
		player addMagazines ["HandGrenade",2];
		player addMagazines ["Titan_AA",1];

		
		(unitBackpack player) addMagazineCargo ["Titan_AA",2];
		// (unitBackpack player) additemCargo ["NVGoggles",1];
		
		player addWeapon "launch_Titan_F";
		player addWeapon "arifle_Mk20_plain_F";
		player addWeapon "hgun_P07_F";
		
		// player addPrimaryWeaponItem "acc_pointer_IR";
		player addPrimaryWeaponItem "optic_Aco";
		
	};
	
	case "B_soldier_AAT_F":  // Asst. Missile Specialist (AT)
	{
		player addUniform "U_B_CombatUniform_mcam";
		player addVest "V_PlateCarrier2_rgr";
		Player addHeadgear "H_HelmetB_camo";
		player addBackpack "B_Kitbag_base";
		player addGoggles "G_Lowprofile";
		
		player addItem "FirstAidKit"; player addItem "FirstAidKit";
		player addItem "itemMap";
		player assignItem "itemMap";
		player addItem "itemRadio";
		player assignItem "itemRadio";
		player addItem "itemCompass";
		player assignItem "itemCompass";
		player addItem "itemWatch";
		player assignItem "itemWatch";
		
		player addMagazines ["30Rnd_556x45_Stanag",9];
		player addMagazines ["16Rnd_9x21_Mag",3];
		player addMagazines ["Chemlight_green",1];
		player addMagazines ["Chemlight_red",1];
		player addMagazines ["SmokeShellGreen",1];
		player addMagazines ["SmokeShellRed",1];
		player addMagazines ["SmokeShell",3];
		player addMagazines ["HandGrenade",4];

		
		(unitBackpack player) addMagazineCargo ["Titan_AT",2];
		(unitBackpack player) addMagazineCargo ["Titan_AP",1];
		(unitBackpack player) addMagazineCargo ["30Rnd_556x45_Stanag",4];
		// (unitBackpack player) additemCargo ["NVGoggles",1];
		
		player addWeapon "arifle_Mk20C_plain_F";
		player addWeapon "hgun_P07_F";
		
		// player addPrimaryWeaponItem "acc_pointer_IR";
		player addPrimaryWeaponItem "optic_Hamr";
		
	};
	
	case "B_soldier_AAA_F":  // Asst. Missile Specialist (AA)
	{
		player addUniform "U_B_CombatUniform_mcam";
		player addVest "V_PlateCarrier2_rgr";
		Player addHeadgear "H_HelmetB_camo";
		player addBackpack "B_Kitbag_base";
		player addGoggles "G_Lowprofile";
		
		player addItem "FirstAidKit"; player addItem "FirstAidKit";
		player addItem "itemMap";
		player assignItem "itemMap";
		player addItem "itemRadio";
		player assignItem "itemRadio";
		player addItem "itemCompass";
		player assignItem "itemCompass";
		player addItem "itemWatch";
		player assignItem "itemWatch";
		
		player addMagazines ["30Rnd_556x45_Stanag",11];
		player addMagazines ["16Rnd_9x21_Mag",3];
		player addMagazines ["Chemlight_green",1];
		player addMagazines ["Chemlight_red",1];
		player addMagazines ["SmokeShellGreen",1];
		player addMagazines ["SmokeShellRed",1];
		player addMagazines ["SmokeShell",3];
		player addMagazines ["HandGrenade",4];

		
		(unitBackpack player) addMagazineCargo ["Titan_AA",2];
		(unitBackpack player) addMagazineCargo ["30Rnd_556x45_Stanag",4];
		// (unitBackpack player) additemCargo ["NVGoggles",1];
		
		player addWeapon "arifle_Mk20C_plain_F";
		player addWeapon "hgun_P07_F";
		
		// player addPrimaryWeaponItem "acc_pointer_IR";
		player addPrimaryWeaponItem "optic_Hamr";
		
	};
	
	case "B_spotter_F":  // Spotter
	{
		player addUniform "U_B_GhillieSuit";
		player addVest "V_PlateCarrier1_blk";
		player addBackpack "B_Kitbag_base";
		
		player addItem "FirstAidKit"; player addItem "FirstAidKit";
		player addItem "B_UavTerminal";
		player assignItem "B_UavTerminal";
		player addItem "itemMap";
		player assignItem "itemMap";
		player addItem "itemRadio";
		player assignItem "itemRadio";
		player addItem "itemCompass";
		player assignItem "itemCompass";
		player addItem "itemWatch";
		player assignItem "itemWatch";
		
		player addMagazines ["30Rnd_556x45_Stanag",13];
		player addMagazines ["30Rnd_556x45_Stanag_Tracer_Red",3];
		player addMagazines ["16Rnd_9x21_Mag",3];
		player addMagazines ["Chemlight_green",2];
		player addMagazines ["Chemlight_blue",2];
		player addMagazines ["SmokeShellGreen",2];
		player addMagazines ["SmokeShell",3];
		player addMagazines ["ClaymoreDirectionalMine_Remote_Mag",1];
		player addMagazines ["Laserbatteries",3];

		
		player addWeapon "Laserdesignator";
		player addWeapon "arifle_MXM_F";
		player addWeapon "hgun_P07_F";
		
		// player addPrimaryWeaponItem "acc_pointer_IR";
		player addPrimaryWeaponItem "optic_Nightstalker";
		
		// (unitBackpack player) additemCargo ["NVGoggles",1];
		
		player addItem "optic_Hamr";
		player addHandgunItem "muzzle_snds_L";
	};
	
	case "B_sniper_F":  // Sniper
	{
		player addUniform "U_B_GhillieSuit";
		player addVest "V_PlateCarrier1_blk";
		
		player addItem "FirstAidKit"; player addItem "FirstAidKit";
		player addItem "ItemGPS";
		player assignItem "ItemGPS";
		player addItem "itemMap";
		player assignItem "itemMap";
		player addItem "itemRadio";
		player assignItem "itemRadio";
		player addItem "itemCompass";
		player assignItem "itemCompass";
		player addItem "itemWatch";
		player assignItem "itemWatch";
		
		player addMagazines ["16Rnd_9x21_Mag",3];
		player addMagazines ["Chemlight_green",2];
		player addMagazines ["Chemlight_blue",2];
		player addMagazines ["SmokeShellGreen",2];
		player addMagazines ["SmokeShell",4];
		player addMagazines ["ClaymoreDirectionalMine_Remote_Mag",1];
		player addMagazines ["5Rnd_127x108_Mag",8];

		
		player addWeapon "Rangefinder";
		player addWeapon "srifle_GM6_F";
		player addWeapon "hgun_P07_F";
		
		// (unitBackpack player) additemCargo ["NVGoggles",1];
		
		player addPrimaryWeaponItem "optic_SOS";
		player addItem "optic_tws";
		player addHandgunItem "muzzle_snds_L";
	};
	
	case "B_Helipilot_F":  // Helicopter Pilot
	{
		player addUniform "U_B_HeliPilotCoveralls";
		player addVest "V_TacVest_blk";
		Player addHeadgear "H_PilotHelmetHeli_B";
		
		player addItem "NVGoggles";
		player assignItem "NVGoggles";
		player addItem "FirstAidKit"; player addItem "FirstAidKit";
		player addItem "ItemGPS";
		player assignItem "ItemGPS";
		player addItem "itemMap";
		player assignItem "itemMap";
		player addItem "itemRadio";
		player assignItem "itemRadio";
		player addItem "itemCompass";
		player assignItem "itemCompass";
		player addItem "itemWatch";
		player assignItem "itemWatch";
		
		player addMagazines ["SmokeShell",2];
		player addMagazines ["SmokeShellGreen",3];
		player addMagazines ["Chemlight_green",3];
		player addMagazines ["16Rnd_9x21_Mag",3];
		player addMagazines ["30Rnd_45ACP_Mag_SMG_01",5];

		
		player addWeapon "SMG_01_F";
		player addWeapon "hgun_P07_F";
		
		player addPrimaryWeaponItem "optic_aco_smg";
	};
	
	case "B_helicrew_F":  // Helicopter Crewman
	{
		player addUniform "U_B_HeliPilotCoveralls";
		player addVest "V_TacVest_blk";
		Player addHeadgear "H_PilotHelmetHeli_B";
		
		player addItem "NVGoggles";
		player assignItem "NVGoggles";
		player addItem "FirstAidKit"; player addItem "FirstAidKit";
		player addItem "ItemGPS";
		player assignItem "ItemGPS";
		player addItem "itemMap";
		player assignItem "itemMap";
		player addItem "itemRadio";
		player assignItem "itemRadio";
		player addItem "itemCompass";
		player assignItem "itemCompass";
		player addItem "itemWatch";
		player assignItem "itemWatch";
		
		player addMagazines ["SmokeShell",2];
		player addMagazines ["SmokeShellGreen",3];
		player addMagazines ["Chemlight_green",3];
		player addMagazines ["16Rnd_9x21_Mag",3];
		player addMagazines ["30Rnd_45ACP_Mag_SMG_01",5];

				
		player addWeapon "SMG_01_F";
		player addWeapon "hgun_P07_F";
		
		player addPrimaryWeaponItem "optic_aco_smg";
	};
	
	case "B_Pilot_F":  // Pilot
	{
		player addUniform "U_B_PilotCoveralls";
		Player addHeadgear "H_PilotHelmetFighter_B";
		player addbackpack "B_Parachute";
		
		player addItem "NVGoggles";
		player assignItem "NVGoggles";
		player addItem "FirstAidKit"; player addItem "FirstAidKit";
		player addItem "ItemGPS";
		player assignItem "ItemGPS";
		player addItem "itemMap";
		player assignItem "itemMap";
		player addItem "itemRadio";
		player assignItem "itemRadio";
		player addItem "itemCompass";
		player assignItem "itemCompass";
		player addItem "itemWatch";
		player assignItem "itemWatch";
		
		player addMagazines ["SmokeShellGreen",2];
		player addMagazines ["Chemlight_green",2];
		player addMagazines ["30Rnd_9x21_Mag",3];

		
		player addWeapon "hgun_PDW2000_F";
	};
	
	case "B_crew_F":  // Crewman
	{
		player addUniform "U_B_CombatUniform_mcam";
		player addVest "V_PlateCarrier1_blk";
		Player addHeadgear "H_HelmetCrew_B";
		
		player addItem "NVGoggles";
		player assignItem "NVGoggles";
		player addItem "FirstAidKit"; player addItem "FirstAidKit";
		player addItem "ItemGPS";
		player assignItem "ItemGPS";
		player addItem "itemMap";
		player assignItem "itemMap";
		player addItem "itemRadio";
		player assignItem "itemRadio";
		player addItem "itemCompass";
		player assignItem "itemCompass";
		player addItem "itemWatch";
		player assignItem "itemWatch";
		
		player addMagazines ["SmokeShell",4];
		player addMagazines ["SmokeShellGreen",3];
		player addMagazines ["Chemlight_green",3];
		player addMagazines ["16Rnd_9x21_Mag",3];
		player addMagazines ["30Rnd_45ACP_Mag_SMG_01",8];

		
		player addWeapon "SMG_01_F";
		player addWeapon "hgun_P07_F";
		
		player addPrimaryWeaponItem "optic_aco_smg";
	};
	
	//---Special Element loadouts
	case "B_recon_TL_F":  // Recon Team Leader
	{
		player addUniform "U_B_GhillieSuit";
		player addVest "V_PlateCarrierSpec_rgr";
		player addHeadgear "H_HelmetB_camo_light";
		player addGoggles "G_Tactical_Clear";
		player addBackpack "B_UAV_01_backpack_F";
		
		player addItem "FirstAidKit"; player addItem "FirstAidKit";
		player addItem "B_UavTerminal";
		player assignItem "B_UavTerminal";
		player addItem "itemMap";
		player assignItem "itemMap";
		player addItem "itemRadio";
		player assignItem "itemRadio";
		player addItem "itemCompass";
		player assignItem "itemCompass";
		player addItem "itemWatch";
		player assignItem "itemWatch";
		
		player addMagazines ["30Rnd_556x45_Stanag",13];
		player addMagazines ["30Rnd_556x45_Stanag_Tracer_Red",3];
		player addMagazines ["16Rnd_9x21_Mag",3];
		player addMagazines ["Chemlight_green",1];
		player addMagazines ["Chemlight_red",1];
		player addMagazines ["1Rnd_HE_Grenade_shell",7];
		player addMagazines ["1Rnd_Smoke_Grenade_shell",3];
		player addMagazines ["1Rnd_SmokeRed_Grenade_shell",2];
		player addMagazines ["1Rnd_SmokeGreen_Grenade_shell",2];
		player addMagazines ["UGL_FlareWhite_F",2];
		player addMagazines ["UGL_FlareCIR_F",2];
		player addMagazines ["Laserbatteries",3];

		
		// (unitBackpack player) additemCargo ["NVGoggles",1];
		
		player addWeapon "Laserdesignator";
		player addWeapon "arifle_Mk20_GL_F";
		player addWeapon "hgun_P07_F";
		
		// player addPrimaryWeaponItem "acc_pointer_IR";
		player addPrimaryWeaponItem "optic_Nightstalker";
		
		player addHandgunItem "muzzle_snds_L";
	};
	
	case "B_recon_F":  // Recon Scout
	{
		player addUniform "U_B_CombatUniform_mcam_vest";
		player addVest "V_PlateCarrierSpec_rgr";
		player addHeadgear "H_HelmetB_camo_light";
		player addBackpack "B_Kitbag_base";
		player addGoggles "G_Lowprofile";
		
		player addItem "FirstAidKit"; player addItem "FirstAidKit";
		player addItem "ItemGPS";
		player assignItem "ItemGPS";
		player addItem "itemMap";
		player assignItem "itemMap";
		player addItem "itemRadio";
		player assignItem "itemRadio";
		player addItem "itemCompass";
		player assignItem "itemCompass";
		player addItem "itemWatch";
		player assignItem "itemWatch";
		
		player addMagazines ["30Rnd_556x45_Stanag",13];
		player addMagazines ["16Rnd_9x21_Mag",3];
		player addMagazines ["Chemlight_green",1];
		player addMagazines ["Chemlight_red",1];
		player addMagazines ["SmokeShellGreen",1];
		player addMagazines ["SmokeShellRed",1];
		player addMagazines ["SmokeShell",3];
		player addMagazines ["HandGrenade",4];

			
		player addWeapon "Binocular";
		player addWeapon "arifle_Mk20C_plain_F";
		player addWeapon "hgun_P07_F";
		
		// (unitBackpack player) additemCargo ["NVGoggles",1];
		
		// player addPrimaryWeaponItem "acc_pointer_IR";
		player addPrimaryWeaponItem "optic_Hamr";
		
		player addHandgunItem "muzzle_snds_L";
	};
	
	case "B_recon_M_F":  // Recon Marksman
	{
		player addUniform "U_B_CombatUniform_mcam_vest";
		player addVest "V_PlateCarrierSpec_rgr";
		player addHeadgear "H_HelmetB_camo_light";
		player addBackpack "B_Kitbag_base";
		player addGoggles "G_Lowprofile";
		
		player addItem "FirstAidKit"; player addItem "FirstAidKit";
		player addItem "ItemGPS";
		player assignItem "ItemGPS";
		player addItem "itemMap";
		player assignItem "itemMap";
		player addItem "itemRadio";
		player assignItem "itemRadio";
		player addItem "itemCompass";
		player assignItem "itemCompass";
		player addItem "itemWatch";
		player assignItem "itemWatch";
		
		player addMagazines ["30Rnd_556x45_Stanag",13];
		player addMagazines ["16Rnd_9x21_Mag",3];
		player addMagazines ["Chemlight_green",1];
		player addMagazines ["Chemlight_red",1];
		player addMagazines ["SmokeShellGreen",1];
		player addMagazines ["SmokeShellRed",1];
		player addMagazines ["SmokeShell",3];
		player addMagazines ["HandGrenade",4];

			
		player addWeapon "Binocular";
		player addWeapon "arifle_MXM_F";
		player addWeapon "hgun_P07_F";
		
		// (unitBackpack player) additemCargo ["NVGoggles",1];
		
		// player addPrimaryWeaponItem "acc_pointer_IR";
		player addPrimaryWeaponItem "optic_Hamr";
		
		player addHandgunItem "muzzle_snds_L";
	};
	
	case "B_recon_LAT_F":  // Recon Scout (AT)
	{
		player addUniform "U_B_CombatUniform_mcam_vest";
		player addVest "V_PlateCarrierSpec_rgr";
		player addHeadgear "H_HelmetB_camo_light";
		player addBackpack "B_Kitbag_base";
		player addGoggles "G_Lowprofile";
		
		player addItem "FirstAidKit"; player addItem "FirstAidKit";
		player addItem "ItemGPS";
		player assignItem "ItemGPS";
		player addItem "itemMap";
		player assignItem "itemMap";
		player addItem "itemRadio";
		player assignItem "itemRadio";
		player addItem "itemCompass";
		player assignItem "itemCompass";
		player addItem "itemWatch";
		player assignItem "itemWatch";
		
		player addMagazines ["30Rnd_556x45_Stanag",13];
		player addMagazines ["16Rnd_9x21_Mag",3];
		player addMagazines ["Chemlight_green",1];
		player addMagazines ["Chemlight_red",1];
		player addMagazines ["SmokeShellGreen",1];
		player addMagazines ["SmokeShellRed",1];
		player addMagazines ["SmokeShell",3];
		player addMagazines ["HandGrenade",4];
		player addMagazines ["NLAW_F",1];

		
		(unitBackpack player) addMagazineCargo ["NLAW_F",4];
		// (unitBackpack player) additemCargo ["NVGoggles",1];
		
		player addWeapon "launch_NLAW_F";
		player addWeapon "Binocular";
		player addWeapon "arifle_Mk20C_plain_F";
		player addWeapon "hgun_P07_F";
		
		// player addPrimaryWeaponItem "acc_pointer_IR";
		player addPrimaryWeaponItem "optic_Hamr";
		
		player addHandgunItem "muzzle_snds_L";
	};
	
	case "B_recon_medic_F":  // Recon Paramedic
	{
		player addUniform "U_B_GhillieSuit";
		player addVest "V_PlateCarrierSpec_rgr";
		player addHeadgear "H_HelmetB_camo_light";
		player addBackpack "B_AssaultPack_mcamo";
		player addGoggles "G_Tactical_Clear";
		
		player addItem "FirstAidKit"; player addItem "FirstAidKit";
		player addItem "ItemGPS";
		player assignItem "ItemGPS";
		player addItem "itemMap";
		player assignItem "itemMap";
		player addItem "itemRadio";
		player assignItem "itemRadio";
		player addItem "itemCompass";
		player assignItem "itemCompass";
		player addItem "itemWatch";
		player assignItem "itemWatch";
		
		player addMagazines ["HandGrenade",2];
		player addMagazines ["SmokeShell",4];
		player addMagazines ["SmokeShellGreen",2];
		player addMagazines ["SmokeShellRed",2];
		player addMagazines ["SmokeShellBlue",2];
		player addMagazines ["Chemlight_green",2];
		player addMagazines ["Chemlight_red",2];
		player addMagazines ["16Rnd_9x21_Mag",3];
		player addMagazines ["30Rnd_556x45_Stanag",13];

		
		(unitBackpack player) additemCargo ["FirstAidKit",14];
		(unitBackpack player) additemCargoGlobal ["Medikit",1];
		// (unitBackpack player) additemCargo ["NVGoggles",1];
			
		player addWeapon "Rangefinder";
		player addWeapon "arifle_Mk20C_plain_F";
		player addWeapon "hgun_P07_F";
		
		// player addPrimaryWeaponItem "acc_pointer_IR";
		player addPrimaryWeaponItem "optic_Nightstalker";
		
		player addHandgunItem "muzzle_snds_L";
	};
	
	case "B_recon_exp_F":  // Recon Demo Specialist
	{
		player addUniform "U_B_CombatUniform_mcam_vest";
		player addVest "V_PlateCarrierSpec_rgr";
		player addHeadgear "H_HelmetB_camo_light";
		player addBackpack "B_Kitbag_base";
		player addGoggles "G_Lowprofile";
		
		player addItem "FirstAidKit"; player addItem "FirstAidKit";
		player addItem "ItemGPS";
		player assignItem "ItemGPS";
		player addItem "itemMap";
		player assignItem "itemMap";
		player addItem "itemRadio";
		player assignItem "itemRadio";
		player addItem "itemCompass";
		player assignItem "itemCompass";
		player addItem "itemWatch";
		player assignItem "itemWatch";
		
		player addMagazines ["HandGrenade",2];
		player addMagazines ["SmokeShell",4];
		player addMagazines ["SmokeShellGreen",2];
		player addMagazines ["SmokeShellRed",2];
		player addMagazines ["SmokeShellBlue",2];
		player addMagazines ["Chemlight_green",2];
		player addMagazines ["Chemlight_red",2];
		player addMagazines ["16Rnd_9x21_Mag",3];
		player addMagazines ["30Rnd_556x45_Stanag",13];

		
		(unitBackpack player) addMagazineCargo ["SLAMDirectionalMine_Wire_Mag",2];
		(unitBackpack player) addMagazineCargo ["DemoCharge_Remote_Mag",1];
		(unitBackpack player) additemCargo ["ToolKit",1];
		(unitBackpack player) additemCargo ["MineDetector",1];
		// (unitBackpack player) additemCargo ["NVGoggles",1];
			
		player addWeapon "Binocular";
		player addWeapon "arifle_Mk20C_plain_F";
		player addWeapon "hgun_P07_F";
		
		// player addPrimaryWeaponItem "acc_pointer_IR";
		player addPrimaryWeaponItem "optic_Hamr";
		
		player addHandgunItem "muzzle_snds_L";
	};
	
	case "B_recon_JTAC_F":  // Recon JTAC
	{
		player addUniform "U_B_CombatUniform_mcam_vest";
		player addVest "V_PlateCarrierSpec_rgr";
		player addHeadgear "H_HelmetB_camo_light";
		player addBackpack "B_Kitbag_base";
		player addGoggles "G_Lowprofile";
		
		player addItem "FirstAidKit"; player addItem "FirstAidKit";
		player addItem "ItemGPS";
		player assignItem "ItemGPS";
		player addItem "itemMap";
		player assignItem "itemMap";
		player addItem "itemRadio";
		player assignItem "itemRadio";
		player addItem "itemCompass";
		player assignItem "itemCompass";
		player addItem "itemWatch";
		player assignItem "itemWatch";
		
		player addMagazines ["HandGrenade",2];
		player addMagazines ["SmokeShell",4];
		player addMagazines ["SmokeShellGreen",2];
		player addMagazines ["SmokeShellRed",2];
		player addMagazines ["SmokeShellBlue",2];
		player addMagazines ["Chemlight_green",2];
		player addMagazines ["Chemlight_red",2];
		player addMagazines ["16Rnd_9x21_Mag",3];

		
		(unitBackpack player) addMagazineCargo ["Chemlight_yellow",2];
		(unitBackpack player) addMagazineCargo ["Chemlight_green",2];
		(unitBackpack player) addMagazineCargo ["Chemlight_red",2];
		(unitBackpack player) addMagazineCargo ["Chemlight_blue",2];
		(unitBackpack player) addMagazineCargo ["SmokeShellGreen",2];
		(unitBackpack player) addMagazineCargo ["SmokeShellRed",2];
		(unitBackpack player) addMagazineCargo ["SmokeShellBlue",2];
		(unitBackpack player) addMagazineCargo ["SmokeShellOrange",2];
		(unitBackpack player) addMagazineCargo ["30Rnd_556x45_Stanag",6];
		(unitBackpack player) addMagazineCargo ["NLAW_F",1];
		(unitBackpack player) addMagazineCargo ["UGL_FlareGreen_F",3];
		(unitBackpack player) addMagazineCargo ["UGL_FlareRed_F",3];
		(unitBackpack player) addMagazineCargo ["UGL_FlareCIR_F",4];
		// (unitBackpack player) additemCargo ["NVGoggles",1];
		
		player addWeapon "Rangefinder";
		player addWeapon "arifle_Mk20C_plain_F";
		player addWeapon "hgun_P07_F";
		
		// player addPrimaryWeaponItem "acc_pointer_IR";
		player addPrimaryWeaponItem "optic_Hamr";
		
		player addHandgunItem "muzzle_snds_L";
	};
	
	case "B_diver_TL_F":  // Diver Team Leader
	{
		player addUniform "U_B_Wetsuit";
		player addVest "V_RebreatherB";
		player addBackpack "B_Kitbag_base";
		player addGoggles "G_Diving";
		
		player addItem "FirstAidKit"; player addItem "FirstAidKit";
		player addItem "ItemGPS";
		player assignItem "ItemGPS";
		player addItem "itemMap";
		player assignItem "itemMap";
		player addItem "itemRadio";
		player assignItem "itemRadio";
		player addItem "itemCompass";
		player assignItem "itemCompass";
		player addItem "itemWatch";
		player assignItem "itemWatch";
		
		player addMagazines ["HandGrenade",2];
		player addMagazines ["SmokeShell",4];
		player addMagazines ["SmokeShellGreen",2];
		player addMagazines ["SmokeShellRed",2];
		player addMagazines ["SmokeShellBlue",2];
		player addMagazines ["Chemlight_green",2];
		player addMagazines ["Chemlight_red",2];
		player addMagazines ["16Rnd_9x21_Mag",3];
		player addMagazines ["20Rnd_556x45_UW_mag",9];

		
		(unitBackpack player) addMagazineCargo ["20Rnd_556x45_UW_mag",2];
		(unitBackpack player) addMagazineCargo ["SmokeShell",6];
		(unitBackpack player) addMagazineCargo ["HandGrenade",6];
		// (unitBackpack player) additemCargo ["NVGoggles",1];
		
		player addWeapon "Binocular";
		player addWeapon "arifle_SDAR_F";
		player addWeapon "hgun_P07_F";
		
		player addHandgunItem "muzzle_snds_L";
	};
	
	case "B_diver_F":  // Assault Diver
	{
		player addUniform "U_B_Wetsuit";
		player addVest "V_RebreatherB";
		player addGoggles "G_Diving";
		player addBackpack "B_Kitbag_base";
		
		player addItem "FirstAidKit"; player addItem "FirstAidKit";
		player addItem "ItemGPS";
		player assignItem "ItemGPS";
		player addItem "itemMap";
		player assignItem "itemMap";
		player addItem "itemRadio";
		player assignItem "itemRadio";
		player addItem "itemCompass";
		player assignItem "itemCompass";
		player addItem "itemWatch";
		player assignItem "itemWatch";
		
		player addMagazines ["16Rnd_9x21_Mag",3];
		player addMagazines ["20Rnd_556x45_UW_mag",9];

		
		player addWeapon "arifle_SDAR_F";
		player addWeapon "hgun_P07_F";
		
		// (unitBackpack player) additemCargo ["NVGoggles",1];
		
		player addHandgunItem "muzzle_snds_L";
	};
	
	case "B_diver_exp_F":  // Diver Explosive Specialist
	{
		player addUniform "U_B_Wetsuit";
		player addVest "V_RebreatherB";
		player addBackpack "B_AssaultPack_blk";
		player addGoggles "G_Diving";
		
		player addItem "FirstAidKit"; player addItem "FirstAidKit";
		player addItem "ItemGPS";
		player assignItem "ItemGPS";
		player addItem "itemMap";
		player assignItem "itemMap";
		player addItem "itemRadio";
		player assignItem "itemRadio";
		player addItem "itemCompass";
		player assignItem "itemCompass";
		player addItem "itemWatch";
		player assignItem "itemWatch";
		
		player addMagazines ["HandGrenade",2];
		player addMagazines ["SmokeShell",4];
		player addMagazines ["SmokeShellGreen",2];
		player addMagazines ["SmokeShellRed",2];
		player addMagazines ["Chemlight_green",1];
		player addMagazines ["Chemlight_red",1];
		player addMagazines ["16Rnd_9x21_Mag",3];
		player addMagazines ["20Rnd_556x45_UW_mag",9];

		
		(unitBackpack player) addMagazineCargo ["SLAMDirectionalMine_Wire_Mag",2];
		(unitBackpack player) addMagazineCargo ["DemoCharge_Remote_Mag",2];
		// (unitBackpack player) additemCargo ["NVGoggles",1];
		
		player addWeapon "arifle_SDAR_F";
		player addWeapon "hgun_P07_F";
		
		player addHandgunItem "muzzle_snds_L";
	};
	
	//---Unique loadouts
	case "B_Soldier_lite_F":  // Rifleman (Light)
	{
		player addUniform "U_B_CombatUniform_mcam_vest";
		player addVest "V_Rangemaster_belt";
		player addBackpack "B_Kitbag_base";
		player addGoggles "G_Tactical_Clear";
		
		player addItem "FirstAidKit"; player addItem "FirstAidKit";
		player addItem "itemMap";
		player assignItem "itemMap";
		player addItem "itemRadio";
		player assignItem "itemRadio";
		player addItem "itemCompass";
		player assignItem "itemCompass";
		player addItem "itemWatch";
		player assignItem "itemWatch";
		
		player addMagazines ["30Rnd_556x45_Stanag",5];
		player addMagazines ["16Rnd_9x21_Mag",2];

		
		player addWeapon "arifle_Mk20_plain_F";
		player addWeapon "hgun_P07_F";
		
		// (unitBackpack player) additemCargo ["NVGoggles",1];
		
		player addPrimaryWeaponItem "optic_Aco";
	};
	
	case "B_RangeMaster_F":  // Range Master
	{
		player addUniform "U_Rangemaster";
		player addVest "V_Rangemaster_belt";
		player addHeadgear "H_Cap_headphones";
		player addBackpack "B_Kitbag_base";
		player addGoggles "G_Tactical_Clear";
		
		player addItem "itemMap";
		player assignItem "itemMap";
		player addItem "itemRadio";
		player assignItem "itemRadio";
		player addItem "itemWatch";
		player assignItem "itemWatch";
		player addItem "FirstAidKit";
		
		// (unitBackpack player) additemCargo ["NVGoggles",1];
	};
	
	case "B_Competitor_F":  // Competitor
	{
		player addUniform "	U_Competitor";
		player addVest "V_Rangemaster_belt";
		player addHeadgear "H_Cap_headphones";
		player addBackpack "B_Kitbag_base";
		player addGoggles "G_Tactical_Clear";
		
		player addItem "itemMap";
		player assignItem "itemMap";
		player addItem "itemRadio";
		player assignItem "itemRadio";
		player addItem "itemWatch";
		player assignItem "itemWatch";
		player addItem "FirstAidKit";
		

		
		// (unitBackpack player) additemCargo ["NVGoggles",1];
	};
	
	
};

//---West ATCC Airbase Commander
if !(isNil "b_player_0") then 
{
	if (player == b_player_0) then 
	{
		removeAllItems player;
		removeAllAssignedItems player;
		removeAllWeapons player;
		removeBackpack player;
		removeHeadgear player;
		removeVest player;
		
		player addUniform "U_B_CombatUniform_mcam_vest";
		player addVest "V_Rangemaster_belt";
		player addHeadgear "H_HelmetB_camo_camo";
		player addBackpack "B_Kitbag_base";
		player addGoggles "G_Tactical_Clear";
		
		player addItem "FirstAidKit";
		
		player addItem "itemMap";
		player assignItem "itemMap";
		player addItem "itemRadio";
		player assignItem "itemRadio";
		player addItem "itemCompass";
		player assignItem "itemCompass";
		player addItem "itemWatch";
		player assignItem "itemWatch";
		player addItem "B_UavTerminal";
		player assignItem "B_UavTerminal";
		player addItem "FirstAidKit";
		
		player addMagazines ["30Rnd_556x45_Stanag",7];
		player addMagazines ["16Rnd_9x21_Mag",3];

		
		player addWeapon "Rangefinder";
		player addWeapon "arifle_Mk20_plain_F";
		player addWeapon "hgun_P07_F";
		
		// player addPrimaryWeaponItem "acc_pointer_IR";
		player addPrimaryWeaponItem "optic_Aco";
		
		// (unitBackpack player) additemCargo ["NVGoggles",1];
		
	};
};

//---West Officer XO
if !(isNil "b_player_1_2") then 
{
	if (player == b_player_1_2) then 
	{
		player addHeadgear "H_HelmetB_camo";
	};
};

//---West Recon Team Leader
if !(isNil "b_player_6_1") then 
{
	if (player == b_player_6_1) then 
	{
		removeAllItems player;
		removeAllAssignedItems player;
		removeAllWeapons player;
		removeBackpack player;
		removeHeadgear player;
		removeVest player;
		
		player addUniform "U_B_GhillieSuit";
		player addVest "V_PlateCarrier2_rgr";
		player addGoggles "G_Tactical_Clear";
		player addBackpack "B_UAV_01_backpack_F";
		
		player addItem "FirstAidKit";  player addItem "FirstAidKit";
		player addItem "B_UavTerminal";
		player assignItem "B_UavTerminal";
		player addItem "itemMap";
		player assignItem "itemMap";
		player addItem "itemRadio";
		player assignItem "itemRadio";
		player addItem "itemCompass";
		player assignItem "itemCompass";
		player addItem "itemWatch";
		player assignItem "itemWatch";
		
		player addMagazines ["30Rnd_556x45_Stanag",9];
		player addMagazines ["16Rnd_9x21_Mag",3];
		player addMagazines ["Chemlight_green",1];
		player addMagazines ["Chemlight_red",1];
		player addMagazines ["1Rnd_HE_Grenade_shell",4];
		player addMagazines ["1Rnd_Smoke_Grenade_shell",3];
		player addMagazines ["1Rnd_SmokeRed_Grenade_shell",2];
		player addMagazines ["1Rnd_SmokeGreen_Grenade_shell",2];
		player addMagazines ["UGL_FlareWhite_F",2];
		player addMagazines ["UGL_FlareCIR_F",2];

					
		player addWeapon "Rangefinder";
		player addWeapon "arifle_Mk20_GL_F";
		player addWeapon "hgun_P07_F";
		
		// player addPrimaryWeaponItem "acc_pointer_IR";
		player addPrimaryWeaponItem "optic_Hamr";
		player addPrimaryWeaponItem "muzzle_snds_H";
		player addHandgunItem "muzzle_snds_L";
		
		// (unitBackpack player) additemCargo ["NVGoggles",1];
	};
};

//---West Recon Paramedic
if !(isNil "b_player_6_2") then 
{
	if (player == b_player_6_2) then 
	{
		removeAllItems player;
		removeAllAssignedItems player;
		removeAllWeapons player;
		removeBackpack player;
		removeHeadgear player;
		removeVest player;
		
		player addUniform "U_B_GhillieSuit";
		player addVest "V_PlateCarrier2_rgr";
		player addGoggles "G_Tactical_Clear";
		player addBackpack "B_AssaultPack_mcamo";
		
		player addItem "FirstAidKit"; player addItem "FirstAidKit";
		player addItem "ItemGPS";
		player assignItem "ItemGPS";
		player addItem "itemMap";
		player assignItem "itemMap";
		player addItem "itemRadio";
		player assignItem "itemRadio";
		player addItem "itemCompass";
		player assignItem "itemCompass";
		player addItem "itemWatch";
		player assignItem "itemWatch";
		
		player addMagazines ["HandGrenade",2];
		player addMagazines ["SmokeShell",4];
		player addMagazines ["SmokeShellGreen",2];
		player addMagazines ["SmokeShellRed",2];
		player addMagazines ["SmokeShellBlue",2];
		player addMagazines ["Chemlight_green",2];
		player addMagazines ["Chemlight_red",2];
		player addMagazines ["16Rnd_9x21_Mag",3];
		player addMagazines ["30Rnd_556x45_Stanag",9];
		player addMagazines ["30Rnd_556x45_Stanag_Tracer_Red",3];

		
		(unitBackpack player) additemCargo ["FirstAidKit",14];
		(unitBackpack player) additemCargoGlobal ["Medikit",1];
		// (unitBackpack player) additemCargo ["NVGoggles",1];
			
		player addWeapon "Rangefinder";
		player addWeapon "arifle_Mk20C_plain_F";
		player addWeapon "hgun_P07_F";
		
		// player addPrimaryWeaponItem "acc_pointer_IR";
		player addPrimaryWeaponItem "optic_Hamr";
		player addPrimaryWeaponItem "muzzle_snds_H";
		player addHandgunItem "muzzle_snds_L";

	};
};