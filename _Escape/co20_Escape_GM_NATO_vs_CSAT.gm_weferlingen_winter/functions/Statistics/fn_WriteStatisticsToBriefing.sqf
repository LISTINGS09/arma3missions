params [["_statistics","Error - No params received"]];
if(!isDedicated) then {
	waitUntil{!isNull player};
	player createDiaryRecord ["Diary", ["Statistics", _statistics]];
};