params [["_settings","Error - No params received"]];
if(!isDedicated) then {
	waitUntil{!isNull player};
	player createDiaryRecord ["Diary", ["Settings", _settings]];
};