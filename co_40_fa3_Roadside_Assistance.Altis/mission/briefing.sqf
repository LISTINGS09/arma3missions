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
	Two days ago, FIA rebels captured a squad of NATO peacekeepers operating in southwestern Altis. Our mission is to rescue them from the rebel-held village of <marker name='therisa'>Therisa</marker>.
	<br/><br/>
	Unfortunately, our <marker name='convoy'>convoy</marker> was ambushed en route to the AO. We drove off the initial attackers, but we lost Alpha and our vehicles were all disabled. We've radioed in for chopper support so we can finish what we'd started.
	<br/>
	1. Find and free all twelve hostages in <marker name='therisa'>Therisa</marker>.<br/>
	2. Escort them to the <marker name='extract'>extract</marker>.<br/>
	<br/>
	When you free a group of hostages, they'll make a beeline to the extract. Make sure their route is clear before you free them!
	<br/><br/>
	<font size='18' color='#80FF00'>ENEMY FORCES</font>
	<br/>
	We're expecting a second wave of FIA attackers any minute now, so get ready to defend. Numbers in Therisa are unknown but expect heavy resistance.
	<br/><br/>
	<font size='18' color='#80FF00'>FRIENDLY FORCES</font>
	<br/>
	Therisa is still a functioning village, so watch out for civilians. Between them and the hostages, be very careful about stray fire.
	<br/><br/>
	Also, one of our recon teams has set up shop <marker name='extract'>near Therisa</marker> and will be handling the extract.
	<br/>
	<br/>
	<font size='18' color='#80FF00'>HOSTAGES</font>
	<br/>
	We don't know where the hostages are but it's likely that the enemy has split them up into smaller groups. They can be freed with a scrollwheel action, at which point they'll head straight for the <marker name='extract'>extract</marker>. Watch out, the enemy may try to kill them on the way there!
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