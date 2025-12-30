//skill settings:
/*
//call with 
[_mygroupname, skill] spawn call EGG_EVO_skill;
e.g. [_guard,3] spawn call EGG_EVO_skill;
0 = Cadet
1 = Easy
2 = Normal
3 = Hard
4 = Extreme
5 = Manual Settings (below)
6 = Use this setting for AI mods such as Zeus AI
*/

EGG_EVO_skill =
{
    private ["_unit", "_skill", "_aiSkillBase"];

    _unit =  _this select 0;
    _skill = _this select 1;
    
    if(_skill < 5) then {
        _aiSkillBase = 1.0;

        switch (_skill) do
        {
            case 0: //conscript very low skill
            {
                _aiSkillBase = 0.2;
            };
            case 1: //rebels low skill
            {
                _aiSkillBase = 0.5;
            };
            case 2: //regular fair skill
            {
                _aiSkillBase = 1.0;
            };
            case 3: //elite soldiers medium skill
            {
                _aiSkillBase = 1.4;
            };
            case 4: // specops good skill
            {
                _aiSkillBase = 1.8;
            };
        };
        
        _unit setSkill _aiSkillBase;
        _unit setSkill ["general", _aiSkillBase];
        _unit setSkill ["aimingAccuracy", (_aiSkillBase * 0.2)];
        _unit setSkill ["aimingShake", (_aiSkillBase * 0.2)];
        _unit setSkill ["aimingSpeed", (_aiSkillBase * 0.40)];
        _unit setSkill ["endurance", _aiSkillBase];
        _unit setSkill ["spotDistance", (_aiSkillBase * 0.15)];
        _unit setSkill ["spotTime", (_aiSkillBase * 0.3)];
        _unit setSkill ["courage", _aiSkillBase];
        _unit setSkill ["reloadSpeed", (_aiSkillBase * 0.80)];
        _unit setSkill ["commanding", (_aiSkillBase * 0.75)];
    }
    else {
        if(_skill == 5) then {
            _unit setSkill (paramsArray select 17);
            _unit setSkill ["general", (paramsArray select 17)];
            _unit setSkill ["aimingAccuracy", (paramsArray select 8)];
            _unit setSkill ["aimingShake", (paramsArray select 9)];
            _unit setSkill ["aimingSpeed", (paramsArray select 10)];
            _unit setSkill ["endurance", (paramsArray select 11)];
            _unit setSkill ["spotDistance", (paramsArray select 12)];
            _unit setSkill ["spotTime", (paramsArray select 13)];
            _unit setSkill ["courage", (paramsArray select 14)];
            _unit setSkill ["reloadSpeed", (paramsArray select 15)];
            _unit setSkill ["commanding", (paramsArray select 16)];
        };
    };

};
