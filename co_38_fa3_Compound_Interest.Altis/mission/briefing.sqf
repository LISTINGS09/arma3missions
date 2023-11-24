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
	FIA guerillas have established a presence in the Skopos Peninsula. Intel has identified a series of compounds around <marker name='obj4'>Sfaka</marker> which have been occupied by the FIA and are being used for training and storage.
	<br/>
	<br/>
	Investigate compounds <marker name='obj1'>1</marker>, <marker name='obj2'>2</marker>, <marker name='obj3'>3</marker>, <marker name='obj4'>4</marker> and <marker name='obj5'>5</marker> and eliminate any FIA forces present.
	<br/><br/>
	<font size='18' color='#80FF00'>ENEMY FORCES</font>
	<br/>
	Around 50 FIA infantry plus a small number of technicals, possibly supported by NATO special forces. The FIA do not have MANPADS, but NATO special forces may be carrying them.
	<br/><br/>
	<font size='18' color='#80FF00'>FRIENDLY FORCES</font>
	<br/>
	A friendly mechanised platoon has established a blocking position to the <marker name='block'>north</marker>
	<br/>
	<br/>
	<font size='18' color='#80FF00'>COMMANDER'S INTENT</font>
	<br/>
	Clear the 5 compounds at <marker name='obj1'>1</marker>, <marker name='obj2'>2</marker>, <marker name='obj3'>3</marker>, <marker name='obj4'>4</marker> and <marker name='obj5'>5</marker>
	<br/><br/>
	<font size='18' color='#80FF00'>MOVEMENT PLAN</font>
	<br/>
	no specific instructions at this time
	<br/><br/>
	<font size='18' color='#80FF00'>FIRE SUPPORT PLAN</font>
	<br/>
	1 K-40 Ababil-3 UAV armed with 2 laser guided bombs. 
	<br/><br/>
	<font size='18' color='#80FF00'>SPECIAL TASKS</font>
	<br/>
	1. The UAV is a valuable asset: make sure it is not exposed to enemy fire. 
	<br/>
	2. Permission has been granted to use high explosives against enemy occupied buildings.
	<br/>
	<br/>%1 <!--- Casualties Cap --->
	<br/><font size='18' color='#80FF00'>CREDITS</font>
	<br/>Created by <font color='#FF0080'>Peasant</font color>
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