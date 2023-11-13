//allUnitsSkillSet.sqf

private "_unit";

_unit = _this select 0;

if (_unit in playableUnits) then { _unit setSkill 1; } else
{
	_unit setSkill 0.65;

	switch (rank _unit) do 
	{
		case "PRIVATE": 
		{
			_unit setSkill ["aimingAccuracy",0.6];
			_unit setSkill ["aimingShake",0.5];
			_unit setSkill ["aimingSpeed",0.6];
			_unit setSkill ["endurance",0.5];
			_unit setSkill ["spotDistance",0.7];
			_unit setSkill ["spotTime",0.6];
			_unit setSkill ["courage",0.7];
			_unit setSkill ["reloadSpeed",0.7];
			_unit setSkill ["commanding",0.7];
			_unit setSkill ["general",0.7]
		};
	
		case "CORPORAL": 
		{
			_unit setSkill ["aimingAccuracy",0.6];
			_unit setSkill ["aimingShake",0.5];
			_unit setSkill ["aimingSpeed",0.6];
			_unit setSkill ["endurance",0.5];
			_unit setSkill ["spotDistance",0.7];
			_unit setSkill ["spotTime",0.6];
			_unit setSkill ["courage",0.7];
			_unit setSkill ["reloadSpeed",0.7];
			_unit setSkill ["commanding",0.7];
			_unit setSkill ["general",0.7]
		};
		
		case "SERGEANT": 
		{
			_unit setSkill ["aimingAccuracy",0.6];
			_unit setSkill ["aimingShake",0.5];
			_unit setSkill ["aimingSpeed",0.6];
			_unit setSkill ["endurance",0.5];
			_unit setSkill ["spotDistance",0.7];
			_unit setSkill ["spotTime",0.6];
			_unit setSkill ["courage",0.7];
			_unit setSkill ["reloadSpeed",0.8];
			_unit setSkill ["commanding",0.7];
			_unit setSkill ["general",0.7];
		};
		
		case "LIEUTENANT": 
		{
			_unit setSkill ["aimingAccuracy",0.8];
			_unit setSkill ["aimingShake",0.8];
			_unit setSkill ["aimingSpeed",0.8];
			_unit setSkill ["endurance",0.7];
			_unit setSkill ["spotDistance",0.8];
			_unit setSkill ["spotTime",0.7];
			_unit setSkill ["courage",0.7];
			_unit setSkill ["reloadSpeed",0.8];
			_unit setSkill ["commanding",0.8];
			_unit setSkill ["general",0.8];
		};
		
		case "COLONEL": 
		{
			_unit setSkill ["aimingAccuracy",0.9];
			_unit setSkill ["aimingShake",0.9];
			_unit setSkill ["aimingSpeed",0.9];
			_unit setSkill ["endurance",0.8];
			_unit setSkill ["spotDistance",0.8];
			_unit setSkill ["spotTime",0.8];
			_unit setSkill ["courage",0.8];
			_unit setSkill ["reloadSpeed",0.8];
			_unit setSkill ["commanding",0.9];
			_unit setSkill ["general",0.9];
		};
		
		default 
		{
			_unit setSkill ["aimingAccuracy",0.6];
			_unit setSkill ["aimingShake",0.5];
			_unit setSkill ["aimingSpeed",0.6];
			_unit setSkill ["endurance",0.5];
			_unit setSkill ["spotDistance",0.7];
			_unit setSkill ["spotTime",0.6];
			_unit setSkill ["courage",0.7];
			_unit setSkill ["reloadSpeed",0.6];
			_unit setSkill ["commanding",0.7];
			_unit setSkill ["general",0.7];
		};
	};
}; 