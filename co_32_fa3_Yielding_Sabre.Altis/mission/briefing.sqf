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
	<br/>The tiny island nation of Altis has long since been a cause for international concern. As of three months ago a military putsch has toppled the parliament, claiming to reinstate order and democracy. Albeit not proven yet, it is obvious that NATO has been involved in funding and further encouraging this travesty. Already the new military junta has invited NATO 'peace-keepers' to Altis. If CSAT does not want a NATO outpost within their own sphere of interest this development must be stopped.<br/><br/>
	<font size='16' color='#80FF00'>SHADU CAMPAIGN</font><br/>
	The time-window for the operation is short: Barely a few weeks remain before the first NATO troops are bound to arrive on Altis. The 'Shadu' campaign aims to seize all strategical airports on Altis, topple the military regime and prevent NATO from establishing any presence on the island. While further forces are mobilized the only carrier within operational distance, the 'Mandana', is already preparing to deal the first blow.<br/><br/>
	<font size='16' color='#80FF00'>27/07/2030: OPERATION YIELDING SABRE</font><br/>
	In the first operation of the campaign, a platoon of special forces is deployed in the far north-west to assist the inbound marine regiments by disrupting enemy communications at Molos.<br/><br/>
	<br/><font size='18' color='#80FF00'>COMMANDER'S INTENT</font>
	<br/>
	Given the AAF's pre-occupation with the FIA, they are most likely going to assume us to be just another guerilla raid. Expect things to get worse once they realize who we are.
	<br/>
	<br/>
	1. Your platoon is inserted along the <marker name='mkrInsert'>western</marker> <marker name='mkrInsert_1'>coast</marker>.<br/>
	2. Proceed inwards to the town of <marker name='mkrTown'>Molos</marker> and destroy the comm-tower at the indicated location.<br/>
	3. Fall back towards the south-western forest to meet our <marker name='mkrExfil'>FIA contacts</marker>.
	<br/>
	<br/>
	Your platoon is inserted by helicopter. Move fast to destroy the AAF comm-tower in Molos. Afterwards move south-west to meet with our FIA contacts.
	<br/><br/>
	<font size='18' color='#80FF00'>ENEMY FORCES</font>
	<br/>
	A mix of infantry and light vehicles. Reinforcements are a possibility.
	<br/><br/>
	<font size='18' color='#80FF00'>FRIENDLY FORCES</font>
	<br/>
	Other platoons are being prepared to attack the AAF. Closest to you the <marker name='mkrCSAT_1'>3rd Mechanized</marker> will assault the airport from the north-east.<br/>
	FIA forces have been disrupting AAF operations all over Altis. There'll probably be smaller skirmishes to our south.
	<br/>
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