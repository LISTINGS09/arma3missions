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
	The assault on Georgetown has begun! Our target is <marker name='hills'>Georgetown Hills</marker>, the very same district where our so-called leaders lounged while the rest of the world burned.
	<br/><br/>
	We have two primary objectives; the <marker name='radio'>radio tower</marker> that overlooks the area, and the offices that government forces have converted into an <marker name='fob'>FOB</marker>. Onwards to glory!
	<br/>
	Capture the <marker name='radio'>radio tower</marker> and <marker name='fob'>FOB</marker>.
	<br/><br/>
	Our AO is marked on the map with red lines. Stay within the AO to avoid interfering with other attacks on the city.
	<br/><br/>
	<font size='18' color='#80FF00'>COMMANDER'S INTENT</font>
	<br/>
	The enemy have fortified Georgetown in preparation for our assault. Keep to cover, and watch out for static emplacements. We may want to avoid long-range engagements altogether; their Mk-14s will generally outperform our AKs at range anyway.
	<br/><br/>
	<font size='18' color='#80FF00'>FIRE SUPPORT PLAN</font>
	<br/>
	We may have access to mortar support. Our mortar batteries are supporting multiple assaults on the city, so the amount we'll be able to call at any one time will be limited.
	<br/>
	<br/>
	<font size='18' color='#80FF00'>ENEMY FORCES</font>
	<br/>
	Horizon Islands Army infantry.
	<br/><br/>
	<font size='18' color='#80FF00'>FRIENDLY FORCES</font>
	<br/>
	We're not the only ones attacking the city. Stay inside the marked area to avoid interfering with other units.
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