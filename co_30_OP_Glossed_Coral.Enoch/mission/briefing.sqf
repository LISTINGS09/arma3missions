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
	<br/>The region of Karlin has strategic importance due to its proximity to key communication routes and valuable resources. Recently, local defence forces (LDF) have taken control of the village, posing a threat to our regional stability and interests. CSAT forces have been deployed to reclaim Karlin and re-establish control.
	<br/>
	<br/>The LDF is well-equipped and highly motivated. Intelligence reports suggest they have established defensive positions throughout the village, including fortified structures and potential sniper nests.
	<br/>
	<br/><font color='#FF7F00'>Secure Karlin</font>
	<br/>Clear all enemy forces from Karlin and establish control over key structures.
	<br/>
	<br/><font color='#FF7F00'>Neutralize Resistance</font>
	<br/>Engage and eliminate any hostile forces encountered. Pay special attention to armoured targets and be prepared for counterattacks as LDF patrols are active in the area.
	<br/>
	<br/><font color='#FF7F00'>Minimize Civilian Casualties</font>
	<br/>The village may still have civilian inhabitants. Exercise caution to minimize collateral damage and civilian casualties.
	<br/>
	<br/><font color='#FF7F00'>Destroy Enemy Reinforcements</font>
	<br/>Intel suggests that the LDF may have reinforcements stationed in the region. Neutralize these forces to prevent them from reinforcing the enemy in Karlin.
	<br/>
	<br/>%1 <!--- Casualties Cap --->
	<br/><font size='18' color='#80FF00'>CREDITS</font>
	<br/>Created by <font color='#FF0080'>2600K</font color>
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