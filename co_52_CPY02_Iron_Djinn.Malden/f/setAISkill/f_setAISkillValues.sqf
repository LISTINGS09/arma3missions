// F3 - Set AI Skill Values
// Credits: Please see the F3 online manual http://www.ferstaberinde.com/f3/en/
// ====================================================================================

// CHECK ACTIVATED PARAMETERS
// Depending on enabled parameters, the skill level for each side are set up

if (isNil "f_param_AISkill" || f_param_AISkill == 0) exitWith {};

// SELECT BLUFOR AI SKILLS
// Using the value of f_param_AISkill, a value for _skillSideBLUFOR is set.

if (isNil "f_var_skillBlu") then
{
f_var_skillBlu =
	switch (f_param_AISkill) do
	{
	// Super
		case 1:
		{
			_superSkill;
		};
	// High
		case 2:
		{
			_highSkill;
		};
	// Medium
		case 3:
		{
			_mediumSkill;
		};
	// Low
		case 4:
		{
			_lowSkill;
		};
	// Default
	    default {
	    	99;
		};
	};
	publicVariable "f_var_skillBlu";
};

// SELECT OPFOR AI SKILLS
// Using the value of f_param_AISkill, a value for _skillSideOPFOR is set.

if (isNil "f_var_skillOpf") then
{
	f_var_skillOpf =
	switch (f_param_AISkill) do
	{
	// Super
		case 1:
		{
			_superSkill;
		};
	// High
		case 2:
		{
			_highSkill;
		};
	// Medium
		case 3:
		{
			_mediumSkill;
		};
	// Low
		case 4:
		{
			_lowSkill;
		};
	// Default
	    default {
	    	99;
		};
	};
	publicVariable "f_var_skillOpf";
};

// SELECT INDEPENDENT AI SKILLS
// Using the value of f_param_AISkill_INDP, a value for _skillSideOPFOR is set.

if (isNil "f_var_skillRes") then
{
	f_var_skillRes =
	switch (f_param_AISkill) do
	{
	// Super
		case 1:
		{
			 _superSkill;
		};
	// High
		case 2:
		{
			 _highSkill;
		};
	// Medium
		case 3:
		{
			_mediumSkill;
		};
	// Low
		case 4:
		{
			_lowSkill;
		};
	// Default
	    default {
	    	99;
		};
	};
	publicVariable "f_var_skillRes";
};

// SELECT CIVILIAN AI SKILLS
// If the civilian side variable is enabled, their level will be set accordingly

f_var_skillCiv = 99;
if (!isNil "f_var_civAI") then {
	f_var_skillCiv =
	switch (f_var_civAI) do {
		case west: {f_var_skillBlu};
		case blufor: {f_var_skillBlu};
		case east: {f_var_skillOpfor};
		case opfor: {f_var_skillOpfor};
		case independent: {f_var_skillRes};
		case resistance: {f_var_skillRes};
		default {99};
	};
};
publicVariable "f_var_skillCiv";

// DEBUG
if (missionNamespace getVariable["f_param_debugMode",0] == 1) then
{
	diag_log text format ["[F3] DEBUG (f\setAISkill\f_setAISkillAD.sqf): f_skillBLU = %1",f_var_skillBlu];
	diag_log text format ["[F3] DEBUG (f\setAISkill\f_setAISkillAD.sqf): f_skillRES = %1",f_var_skillOpf];
	diag_log text format ["[F3] DEBUG (f\setAISkill\f_setAISkillAD.sqf): f_skillOPF = %1",f_var_skillRes];
	diag_log text format ["[F3] DEBUG (f\setAISkill\f_setAISkillAD.sqf): f_skillCIV = %1",f_var_skillCiv];
};