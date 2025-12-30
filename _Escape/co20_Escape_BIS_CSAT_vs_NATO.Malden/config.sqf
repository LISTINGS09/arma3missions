//SearchLeader
a3e_var_knownPositionHelperObject = "Land_HelipadEmpty_F";
a3e_var_knownPositionMinDistance = 100;

//Patrols
a3e_var_maxSearchRange = 1000;
a3e_var_investigationChance = 60;

//Debug
a3e_debug_overwrite = false;
a3e_debug_artillery = false;

A3E_SystemLog = true;

//Artillery
a3e_var_artillery_units = []; //Filled by Mortar Site
a3e_var_artilleryTimeThreshold = 120;
a3e_var_artillery_cooldown = 600;
a3e_var_artillery_rounds = 6;
a3e_var_artillery_dispersion = 80;
a3e_var_artillery_chance = 10;
a3e_var_artillery_chance_cooldown = 60;
a3e_var_artillery_fleeingDistance = 400;

//Default mission values
missionNameSpace setVariable["MinSpawnDistance",1500];
missionNameSpace setVariable["MaxSpawnDistance",2000];

//Roadblocks
missionNameSpace setVariable["MinRoadblockSpawnDistance",1500];
missionNameSpace setVariable["MaxRoadblockSpawnDistance",2000];
missionNameSpace setVariable["MinRoadblockDistance",750];
missionNameSpace setVariable["MaxNumberOfRoadblocks",10];

//Crashsites
missionNameSpace setVariable["CrashSiteCountMax",3];