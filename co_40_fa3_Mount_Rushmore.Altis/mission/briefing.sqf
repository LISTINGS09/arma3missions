// F3 - Briefing - Credits: Please see the F3 online manual http://www.ferstaberinde.com/f3/en/
// <marker name='XXX'>XXX</marker>
// Green #80FF00
// Orange #FF7F00
// Blue #00FFFF

if (isNil "f_param_CasualtiesCap") then { f_param_CasualtiesCap = 100 }; // Set CasCap if author did not.

// The code below creates the administration sub-section of notes.
_adm = player createDiaryRecord ["Diary", ["Administration",[] call f_fnc_fillAdministration]];

// Edit the if statement for different faction briefs.

if (side group player != CIVILIAN) then {
	// The code below creates the execution sub-section of notes.
	_exe = player createDiaryRecord ["Diary", ["Mission",format["
	<br/><font size='18' color='#80FF00'>OBJECTIVES</font>
	<br/>
	NATO is concentrated in three bases in the city - a <marker name='motorPool'>motor pool</marker>, a block of houses they've converted into <marker name='barracks'>barracks</marker>, and the hospital that they've been using as their <marker name='headquarters'>headquarters</marker>. Enemy resistance will be concentrated in these bases, and if we take them out the remnants should be easy enough to clean up.
	<br/><br/>
	They'll be on alert but they don't know we're coming. We don't anticipate any civilians in the AO, but try to limit collateral damage. We're trying to save Kavala, not destroy it.
	<br/>
	<br/>
	1. Clear out the <marker name='motorPool'>motor pool</marker>.<br/>
	2. Clear out the <marker name='barracks'>barracks</marker>.<br/>
	3. Clear out the <marker name='headquarters'>headquarters</marker>.
	<br/><br/>
	The order's come down. NATO's our enemy now, and it's our job to drive them out of Kavala.
	<br/><br/>
	They've got three major bases in the city. Take them out.
	<br/><br/>
	<font size='18' color='#80FF00'>ENEMY FORCES</font>
	<br/>
	A platoon or two of NATO infantry with some vehicle support. They'll mostly start in their bases but that probably won't last when the shooting starts.
	<br/><br/>
	<font size='18' color='#80FF00'>FIRE SUPPORT PLAN</font>
	<br/>
	CAS is active in the area; we may be able to divert them to support us.
	<br/>
	<br/><font size='18' color='#80FF00'>CREDITS</font>
	<br/>Created by <font color='#FF0080'>darkChozo</font color>
	<br/>
	<br/>A custom-made mission for ArmA 3 and Zeus Community
	<br/>http://zeus-community.net
	<br/>",
	if (f_param_CasualtiesCap > 0 && f_param_CasualtiesCap < 100) then { format["Ensure casualties are kept below %1 and %1&#37; of your force is not incapacitated.<br/>", f_param_CasualtiesCap] } else { "" }
	]]];
};

// Commander Endings
if (rank player in ["MAJOR","COLONEL"]) then {
	private _missionEndings = "<font size='18' color='#80FF00'>ENDINGS</font><br/><br/>These endings are available. To trigger an ending click on its link - It will take a few seconds to synchronise across all clients.<br/><br/>";

	for "_i" from 1 to 15 do {
		private _eID = format ["end%1",_i];

		if (getText (getMissionConfig "CfgDebriefing" >> _eID >> "Title") != "") then {	
			_missionEndings = _missionEndings + format [
				"%4<br/><execute expression=""['f_briefing.sqf','End%1 called by %5','INFO'] remoteExec ['f_fnc_logIssue',2]; 'End%1' remoteExec ['BIS_fnc_endMission'];"">Ending #%1</execute> - %2:<br/>%3<br/><br/>",
				_i,
				getText (getMissionConfig "CfgDebriefing" >> _eID >> "title"),
				getText (getMissionConfig "CfgDebriefing" >> _eID >> "description"),
				format["<img image='%1' height='32'/>", getText (getMissionConfig "CfgDebriefing" >> _eID >> "picture")],
				name player
			];	
		};
	};

	// Create the briefing section to display the endings
	player createDiaryRecord ["Diary", ["Endings",_missionEndings]];
};