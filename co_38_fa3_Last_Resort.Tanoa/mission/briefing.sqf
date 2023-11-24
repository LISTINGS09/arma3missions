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
	Syndikat is about to sell a significant amount of weapons and ammunition to FIA rebels on <marker name='island'>Ravi-ta Island</marker>. If completed, the <marker name='weapons'>arms deal</marker> would significantly complicate our operations in the Mediterranean.
	<br/><br/>
	Your mission is to disrupt the deal and destroy the <marker name='weapons'>arms</marker>. We've been tracking this for months; don't let us down.
	<br/><br/>
	<font size='18' color='#80FF00'>ENEMY FORCES</font>
	<br/>
	<marker name='island'>Ravi-ta Island</marker> is a Syndikat stronghold, and you can expect them to come out in full force for such an important operation.
	<br/>
	1. Find and destroy the <marker name='weapons'>arms caches</marker>. (Riflemen are carrying explosive charges)<br/>
	2. Extract off the island.
	<br/>
	<br/>
	<font size='18' color='#80FF00'>COMMANDER'S INTENT</font>
	<br/>
	We'll be inserting via boat. The bulk of Syndikat forces are going to be overseeing the meeting itself; we expect only patrols on the coast. We've got a drone in the air and a sub in the sea that can be used to identify viable landing sites.
	<br/><br/>
	Try not to beach the boats - they'll be useful when we want to extract. If we need additional transport, we may need to requisition it. Remember your training; as special forces we're qualified on rotary and fixed wing aircraft.
	<br/>
	<br/>%1 <!--- Casualties Cap --->
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