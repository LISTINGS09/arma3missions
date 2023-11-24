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
	There's no turning back now. We've tracked down the data on CSAT's new weapon prototype to a <marker name='csathq'>building</marker> in the TAF-held town of <marker name='lijnhaven'>Lijnhaven</marker>. That data could be the key to saving thousands of lives.
	<br/><br/>
	A NATO Blackfish is moving in to provide us with close air support. Assault the <marker name='csathq'>HQ</marker>, download that data, and get back to the mainland!
	<br/><br/>
	<font size='18' color='#80FF00'>ENEMY FORCES</font>
	<br/>
	<marker name='lijnhaven'>Lijnhaven</marker> is home to a sizeable Tanoa Armed Forces garrison supported by CSAT ""advisors"".
	<br/><br/>
	<font size='18' color='#80FF00'>FRIENDLY FORCES</font>
	<br/>
	An armed V-44 has been called in to support us.
	<br/>
	1. Download the weapon data from the <marker name='csathq'>CSAT HQ</marker>.<br/>
	2. Get to the <marker name='lsvs'>stashed LSVs</marker>.<br/>
	3. <marker name='escape'>Escape</marker> to the mainland.
	<br/>
	<br/>%1 <!--- Casualties Cap --->
	<font size='18' color='#80FF00'>WEAPON DATA</font>
	<br/>
	The data should be stored somewhere on a computer in the <marker name='csathq'>HQ</marker>. Downloading the data will take a short while; make sure you're secure while the download happens.
	<br/><br/>
	<font size='18' color='#80FF00'>ESCAPE VEHICLES</font>
	<br/>
	There are several <marker name='lsvs'>Qilins</marker> stashed away near the airport. They'll have to be unlocked before we can use them; good thing we have the keys.
	<br/>
	<br/>
	<br/><font size='18' color='#80FF00'>CREDITS</font>
	<br/>Created by <font color='#FF0080'>darkChozo</font color>
	<br/>
	<br/>A custom-made mission for ArmA 3 and Zeus Community
	<br/>http://zeus-community.net
	<br/>",
	if (f_param_CasualtiesCap > 0 && f_param_CasualtiesCap < 100) then { format["Ensure casualties are kept below %1 and %1&#37; of your force is not incapacitated.<br/>", f_param_CasualtiesCap] } else { "" }]]];
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