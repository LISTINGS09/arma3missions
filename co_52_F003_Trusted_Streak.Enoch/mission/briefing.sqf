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
	<br/>Disrupt enemy movement in the area by advancing into CSAT Territory, capturing a <marker name='marker_3'>Fuel Storage Depot</marker> and destroying a <marker name='marker_4'>Power Generator</marker> near an Outpost.
	<br/>
	<br/>After the Storage Depot has been neutralised, you are to destroy all storage tanks located there, once all objectives have been completed, return North of the river.
	<br/>
	<br/>Ensure casualties are kept below %1 and %1&#37; of your force is not incapacitated.
	<br/>
	<br/><font size='18' color='#80FF00'>FRIENDLY FORCES</font>
	<br/>Up to five squads each with one transport truck, Echo team is carrying heavy weapons.
	<br/>
	<br/><font size='18' color='#80FF00'>ENEMY FORCES</font>
	<br/>Expect to encounter patrols and vehicles across the AO, the <marker name='marker_3'>Fuel Depot</marker> contains at least two APCs both likely stationary but limited infantry. 
	<br/>
	<br/>Due to the proximity of the <marker name='marker_4'>Power Generator</marker> to a CSAT Outpost to the South, expect more active vehicles and infantry.
	<br/>
	<br/><font size='18' color='#80FF00'>CREDITS</font>
	<br/>Created by <font color='#FF0080'>2600K</font color>
	<br/>
	<br/>A custom-made mission for ArmA 3 and Zeus Community
	<br/>http://zeus-community.net/
	<br/>
	",f_param_CasualtiesCap]]];
};