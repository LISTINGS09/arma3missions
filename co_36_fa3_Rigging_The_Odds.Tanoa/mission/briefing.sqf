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
	We've had enough of NATO's ""assistance"". The <marker name='rig'>Blue Pearl Oil Rig</marker> (no relation) was built by Tanoan hands, and the Tanoan people should be the ones who benefit from it.
	<br/><br/>
	They've trained the TAF up into a top fighting force; now it's time to turn that training against them. Take that oil rig for Tanoa!
	<br/><br/>
	<font size='18' color='#80FF00'>ENEMY FORCES</font>
	<br/>
	Private security, plus a NATO ""anti-piracy"" force.
	<br/><br/>
	<font size='18' color='#80FF00'>FRIENDLY FORCES</font>
	<br/>
	There are civilian workers keeping the rig functional. We can figure out which ones are traitors later; for now, watch your fire.
	<br/>
	<br/>
	<font size='18' color='#80FF00'>COMMANDER'S INTENT</font>
	<br/>
	Capture the <marker name='rig'>Blue Pearl Oil Rig</marker>
	<br/>
	A surface approach would be disastrous, we'd be spotted from kilometers out and get chewed up. We'll approach from under the surface instead - hopefully you remember your dive training.
	<br/><br/>
	The only way up to the main platform is one of three staircases from the base of the rig. These are natural chokepoints; expect a tough fight getting to the top.
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