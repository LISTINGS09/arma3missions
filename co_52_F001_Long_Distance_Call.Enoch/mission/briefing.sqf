// F3 - Briefing - Credits: Please see the F3 online manual http://www.ferstaberinde.com/f3/en/
// <marker name='XXX'>XXX</marker>
// Green #72E500
// Orange #80FF00
// Blue #0080FF

if (isNil "f_param_CasualtiesCap") then { f_param_CasualtiesCap = 100 }; // Set CasCap if author did not.

// The code below creates the administration sub-section of notes.
_adm = player createDiaryRecord ["Diary", ["Administration",[] call f_fnc_fillAdministration]];

// Edit the if statement for different faction briefs.

if (side player != CIVILIAN) then {
	// The code below creates the execution sub-section of notes.
	_exe = player createDiaryRecord ["Diary", ["Mission",format["
	<br/><font size='18' color='#80FF00'>OBJECTIVES</font>
	<br/>Identify the location of a CSAT Outpost and capture the Taru Fuel Transport based there.
	<br/>
	<br/>Unfortunately we don't know where the Outpost is and the Taru hasn't landed yet.
	<br/>
	<br/>But all is not lost! HQ has identified <marker name='marker_0'>Camp Lima</marker> - As having a hackable radio which can be used to call the Taru back home.
	<br/>
	<br/>This will allow you to both locate the Outpost and capture the helicopter as it returns.
	<br/>
	<br/>Ensure casualties are kept below %1 and %1&#37; of your force is not incapacitated.
	<br/>
	<br/><font size='18' color='#80FF00'>FRIENDLY FORCES</font>
	<br/>Up to five squads of motorised infantry. If you damaged the Taru the Repair Specialist may be of some use.
	<br/>
	<br/><font size='18' color='#80FF00'>ENEMY FORCES</font>
	<br/>CSAT Infantry will be active across the area and a large <marker name='marker_3'>Training Area</marker> is known to be occupied by CSAT forces.
	<br/>
	<br/>Clearing the Training Area is entirely optional, the area has been checked by UAV and no CSAT Outpost was located nearby but the forces there are likely to respond if you're spotted in the AO.
	<br/>
	<br/>Both the Camp and the hidden Outpost are believed to be lightly defended, nothing you can't handle.
	<br/>
	<br/><font size='18' color='#80FF00'>CREDITS</font>
	<br/>Created by <font color='#00FFFF'>2600K</font color>
	<br/>
	<br/>A custom-made mission for ArmA 3 and Zeus Community
	<br/>http://zeus-community.net/
	<br/>
	",f_param_CasualtiesCap]]];
};