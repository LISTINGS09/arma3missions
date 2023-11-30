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
	<br/>Rebel forces have recently come into possession of two IFVs and used them to gain control of a <marker name='marker_8'>Military Site</marker> north of Grabin.
	<br/>
	<br/>The enemy appear to have originated from a <marker name='marker_7'>Small Camp</marker> which is supported by a nearby <marker name='marker_10'>Mortar Site</marker>.
	<br/>
	<br/>All three locations are to be neutralised and the Military Site to be retaken with minimal damage to the building infrastructure.
	<br/>
	<br/>Ensure casualties are kept below %1 and %1&#37; of your force is not incapacitated.
	<br/>
	<br/><font size='18' color='#80FF00'>FRIENDLY FORCES</font>
	<br/>Up to five teams of infantry have light transport, but due to the terrain and armoured threats travel may be limited.
	<br/>
	<br/><font size='18' color='#80FF00'>ENEMY FORCES</font>
	<br/>The town of Grabin is lightly defended, however a bunker outside the <marker name='marker_8'>Military Site</marker> may prevent ingress from the South.
	<br/>
	<br/>The <marker name='marker_10'>Mortar Site</marker> is known to be located somewhere around the lake, but its exact position is not known. It will have minimal protection.
	<br/>
	<br/>Lastly, the <marker name='marker_7'>Camp</marker> can be expected to have an increased number of patrols but due to its location has no armoured support, at least one HMG vehicle is present at the Camp and it has been fortified.
	<br/>
	<br/><font size='18' color='#80FF00'>CREDITS</font>
	<br/>Created by <font color='#FF0080'>2600K</font color>
	<br/>
	<br/>A custom-made mission for ArmA 3 and Zeus Community
	<br/>http://zeus-community.net/
	<br/>
	",f_param_CasualtiesCap]]];
};