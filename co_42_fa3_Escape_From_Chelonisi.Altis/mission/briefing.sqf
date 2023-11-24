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
	We've finally found out where our men are being held! They're in the <marker name='prisoncenter'>old prison on Chelonisi Island</marker>, and our AAF informant tells us that they're to be handed over to NATO to face trial.
	<br/><br/>
	We're not going to let NATO get their hands on them. Last night, we managed to sneak in some pistols to the prisoners. And today, they break out.
	<br/><br/>
	<font size='18' color='#80FF00'>ENEMY FORCES</font>
	<br/>
	The prison garrison, all infantry. They're prepared for an attack from the outside, so all the heavily armed troops are near the entrance in the <marker name='admin'>administration area.</marker> Also watch out for the outward-facing HMGs in the <marker name='guardtower'>guard towers.</marker>
	<br/><br/>
	We're also expecting reinforcements once the prison goes into lockdown. If we're lucky, NATO might even show up to safeguard their prize.
	<br/>
	<br/>
	<font size='18' color='#80FF00'>COMMANDER'S INTENT</font>
	<br/>
	Aid the escape of the prison. Escape will be considered successful when all units are at least 1.5km away from the prison.
	<br/><br/>
	The mission will fail if more than 75% of the prisoners die.
	<br/>
	We've distributed up to 10 pistols among the prisoners. They're not much, but they'll be enough to take out the guards in the <marker name='cellblock'>cell block</marker> and take their weapons and armor.
	<br/><br/>
	Once the prisoners are free, they can try to escape through the <marker name='admin'>administration area</marker> to the main entrance. However, they will face heavy resistance on this route. They may want to raid the <marker name='armory'>armory</marker> for supplies first.
	<br/><br/>
	Our men on the outside have two primary goals - distract the prison garrison from the outside, and prevent any reinforcements from reaching the prison. Given their numbers, they may want to avoid direct confrontation where possible.
	<br/>
	<br/>
	<font size='18' color='#80FF00'>PRISONERS</font>
	<br/>
	Up to ten random prisoners have hidden pistols that can be equipped with a scroll wheel action. Equipping a weapon or leaving the <marker name='cellblock'>cell block</marker> will turn the guards hostile towards you.
	<br/><br/>
	All prisoners have a map during the briefing, but once the mission starts, only prisoner leaders will. Make sure you know where you're going!
	<br/><br/>
	<font size='18' color='#80FF00'>OPTIONAL RULES</font>
	<br/>
	The prisoners and the rescue team aren't allowed to talk to each other until they link up.
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