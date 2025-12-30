params [["_modifier", 1, [0]]];
private _minEnemies = 8;
private _maxEnemies = 12;

switch A3E_Param_EnemyFrequency do {
	case 1: // 1-2 players
	{
		_minEnemies = 2;
		_maxEnemies = 4;
	};
	case 2: // 3-5 players
	{
		_minEnemies = 4;
		_maxEnemies = 6;
	};
	default // 6-8 players
	{
		_minEnemies = 6;
		_maxEnemies = 8;
	};
};
_minEnemies = _minEnemies * _modifier;
_maxEnemies = _maxEnemies * _modifier;
[_minEnemies,_maxEnemies];