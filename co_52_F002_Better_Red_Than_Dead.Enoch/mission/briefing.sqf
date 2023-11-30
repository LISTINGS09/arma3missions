// F3 - Briefing - Credits: Please see the F3 online manual http://www.ferstaberinde.com/f3/en/
// <marker name='XXX'>XXX</marker>
// Green #72E500
// Orange #80FF00
// Blue #0080FF

if (isNil "f_param_CasualtiesCap") then { f_param_CasualtiesCap = 100 }; // Set CasCap if author did not.

// The code below creates the administration sub-section of notes.
_adm = player createDiaryRecord ["Diary", ["Administration",[] call f_fnc_fillAdministration]];

// Edit the if statement for different faction briefs.

//if (side player != CIVILIAN) then {
	// The code below creates the execution sub-section of notes.
	_exe = player createDiaryRecord ["Diary", ["Mission",format["
	<br/><font size='18' color='#80FF00'>OBJECTIVES</font>
	<br/>Obtain a sample of unknown origins that the LDF is currently studying.
	<br/>
	<br/>Gather documents from the nearby LDF Camp to reveal the whereabouts of the Research Site where the sample is located.
	<br/>
	<br/>Ensure casualties are kept below %1 and %1&#37; of your force is not incapacitated.
	<br/>
	<br/><font size='18' color='#80FF00'>SPECIAL TASKS</font>
	<br/>Pockets of an unknown chemical agent have been reported across the area and are believed to be closely linked to the sample the LDF is studying. 
	<br/>
	<br/>Anyone entering these areas without sufficient CBRN protection will suffocate and eventually die.
	<br/>
	<br/><font size='18' color='#80FF00'>FRIENDLY FORCES</font>
	<br/>Up to four teams of infantry supported by one CBRN Team.
	<br/>
	<br/><font size='18' color='#80FF00'>ENEMY FORCES</font>
	<br/>LDF forces are on high alert in the area, expect to encounter infantry patrols and motorised vehicles.
	<br/>
	<br/>One IFV has been spotted patrolling around the town of Gieraltow as well as an increased infantry presence. The Research Site is likely located somewhere in this area.
	<br/>
	<br/><font size='18' color='#80FF00'>CREDITS</font>
	<br/>Created by <font color='#00FFFF'>2600K</font color>
	<br/>
	<br/>A custom-made mission for ArmA 3 and Zeus Community
	<br/>http://zeus-community.net/
	<br/>
	",f_param_CasualtiesCap]]];
//};