// F3 - Briefing - Credits: Please see the F3 online manual http://www.ferstaberinde.com/f3/en/
// <marker name='XXX'>XXX</marker>
// Green #80FF00
// Orange #FF7F00
// Blue #00FFFF

if (isNil "f_param_CasualtiesCap") then { f_param_CasualtiesCap = 100 }; // Set CasCap if author did not.

// The code below creates the administration sub-section of notes.
_adm = player createDiaryRecord ["Diary", ["Administration",[] call f_fnc_fillAdministration]];

// Edit the if statement for different faction briefs.

if (side player != CIVILIAN) then {
	// The code below creates the execution sub-section of notes.
	_exe = player createDiaryRecord ["Diary", ["Mission",format["
	<br/><font size='18' color='#80FF00'>OBJECTIVES</font>
	<br/>We're short some artillery, so its time for a shopping trip.
	<br/>
	<br/>Attack the <marker name='marker_6'>LDF Outpost</marker> and bring back two Zamak MRL Trucks.
	<br/>
	<br/>Ensure casualties are kept below %1 and %1&#37; of your force is not incapacitated. Not destroying the Zamak MRL trucks is highly recommended.
	<br/>
	<br/><font size='18' color='#80FF00'>FRIENDLY FORCES</font>
	<br/>Up to five teams of infantry have unarmed transports and are supported by two light tanks and two heavy APCs.
	<br/>
	<br/>No other friendly forces are present in the area.
	<br/>
	<br/><font size='18' color='#80FF00'>ENEMY FORCES</font>
	<br/>The LDF have a number of APCs deployed in the area, most are static on or near the marked bunker positions, the town of <marker name='marker_7'>Lipina</marker> and the <marker name='marker_6'>LDF Outpost</marker> itself. 
	<br/>
	<br/>While the APCs aren't equipped with AT Missiles, expect all infantry patrols throughout the area armed with LAT at the minimum. A dedicated AT squad is known to be present in the area.
	<br/>
	<br/><font size='18' color='#80FF00'>CREDITS</font>
	<br/>Created by <font color='#FF0080'>2600K</font color>
	<br/>
	<br/>A custom-made mission for ArmA 3 and Zeus Community
	<br/>http://zeus-community.net/
	<br/>
	",f_param_CasualtiesCap]]];
};