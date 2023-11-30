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
	<br/>A criminal gang recently attacked a warehouse and made off with a number of special weapons crates.
	<br/>
	<br/>Your task is to locate and recover the crates. Initial intelligence points to the crates being stored in a remote camp in the woods near Borek. 
	<br/>
	<br/>The gang may have already moved the cargo so be prepared to relocate elsewhere.
	<br/>
	<br/>Ensure casualties are kept below %1 and %1&#37; of your force is not incapacitated.
	<br/>
	<br/><font size='18' color='#80FF00'>FRIENDLY FORCES</font>
	<br/>Up to five squads supported by light CAS and two heavy transports.
	<br/>
	<br/><font size='18' color='#80FF00'>ENEMY FORCES</font>
	<br/>A criminal gang controls the majority of the region - The gang are poorly armed, with SMGs, pistols and shotguns with possible support from light motorised vehicles.
	<br/>
	<br/>The camp near Borek is located on the outer edges of the Gangs territory and as such will have minimal protection; a few light patrols and 3-5 guards at the camp.
	<br/>
	<br/>Nearby towns can be expected to be garrisoned with support vehicles and additional infantry, but no significant QRF is expected.
	<br/>
	<br/>Reports indicate that armoured vehicles and AA teams are present to the South of the territories, it would be wise to avoid these areas.
	<br/>
	<br/><font size='18' color='#80FF00'>CREDITS</font>
	<br/>Created by <font color='#FF0080'>2600K</font color>
	<br/>
	<br/>A custom-made mission for ArmA 3 and Zeus Community
	<br/>http://zeus-community.net/
	<br/>
	",f_param_CasualtiesCap]]];
};