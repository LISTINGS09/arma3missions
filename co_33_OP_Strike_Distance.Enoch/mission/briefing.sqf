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
	<br/>Operation Silent Dawn is a critical mission aimed at rescuing a NATO prisoner currently held by CSAT forces. The captive is believed to possess vital intelligence that could jeopardize the security of NATO forces in the region if it falls into the wrong hands. Your CTRG (Covert Tactical Response Group) team has been selected for this high-stakes operation due to your exceptional skills in covert operations and unconventional warfare.
	<br/>
    <br/><font color='#FF7F00'>Locate the NATO Prisoner</font>
    <br/>Intel suggests that the NATO prisoner is being held at a CSAT black site located in the region of Lipina. Your primary objective is to infiltrate the area and locate the captive.
	<br/>
    <br/><font color='#FF7F00'>Neutralize Opposition</font>
    <br/>If confronted, engage hostiles with discretion. Lethal force is authorized, but prioritize silent takedowns to maintain the element of surprise. Minimize collateral damage.
	<br/>
    <br/><font color='#FF7F00'>Extract the NATO Prisoner</font>
    <br/>Once the prisoner has been located, secure them and escort to the extraction point. A Hunter vehicle has been provided for your use. Ensure the prisoner's safety during transport.
	<br/>
    <br/><font color='#FF7F00'>Avoid Escalation</font>
	<br/>It is imperative that this operation remains covert. Avoid engaging in large-scale firefights that could draw unwanted attention. If compromised, prioritize extraction over confrontation.
	<br/>
    <br/><font color='#FF7F00'>Exfiltration</font>
	<br/>Once the prisoner is secured, exfiltrate the area using the Hunter. Be vigilant for enemy patrols and respond swiftly to any threats.
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