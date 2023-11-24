/*
 * Randomly select an item from a weighted array. Array should be in the following format:
 * [[weight0,item0],[weight1,item1]...]. Items with a higher weight are more likely to be
 * chosen; for the array [[1,item0],[2,item1]], there is a 1/3 chance of choosing item0
 * and a 2/3 chance of choosing item1.
 *
 * Example usage: [[1,item0],[1,item1],[2,item2]] call weightedSelectRandom;
 */
 
_sum = 0;
{ _sum = _sum + (_x select 0); } forEach _this;

_roll = random _sum;

_sum = 0;
{
    _sum = _sum + (_x select 0);
    if (_roll < _sum) exitWith {_x select 1};
} forEach _this;