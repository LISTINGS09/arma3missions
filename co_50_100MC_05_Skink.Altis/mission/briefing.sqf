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
	<br/>Secure the <marker name='M1'>Lookout Point</marker> and capture <marker name='M1_1'>Kalithea</marker>.
	<br/>
	<br/>The Lookout Point should be your first destination, capturing this will prevent reinforcements from flanking your advance to the town. You can then approach the town directly.
	<br/>
	<br/>When complete, regroup on the <marker name='EX'>extract point</marker>.
	<br/>
	<br/>%1 <!--- Casualties Cap --->
	<br/><font size='18' color='#80FF00'>FRIENDLY FORCES</font>
	<br/>One platoon of up to five infantry squads; Alpha, Bravo, Charlie, Delta and Echo.
	<br/>
	<br/>You begin at an abandoned <marker name='respawn_east'>lookout post</marker> and must advance on foot, no vehicles are provided.
	<br/>
	<br/>Civilians are likely to be present in the area.
	<br/>
	<br/><font size='18' color='#80FF00'>ENEMY FORCES</font>
	<br/>NATO forces have been known to use Kalithea Bay to conduct naval training operations - Watch out for divers or boats when approaching the town. 
	<br/>
	<br/>At least one mechanised squad has been spotted at the <marker name='M1'>Lookout Point</marker>.
	<br/>
	<br/>The town of Kalithea has at least one IFV and motorised vehicle defending it, along with two infantry squads.
	<br/>
	<br/>The following units are known to be operational in the AO:
	<br/>%2%3
	<br/>
	<br/><font size='18' color='#FF7F00'>BACKGROUND</font>
	<br/>Paramilitary forces, having captured the west of the island, they have been advancing onwards to the East with minimal contact.
	<br/>
	<br/>Your platoon, part of the 22nd Altis Liberation Company is positioned on the front lines of advance and has been tasked with securing the port of <marker name='M1_1'>Kalithea</marker>.
	<br/>
	<br/>A NATO lookout post is the only significant threat, eliminating this will prevent any reinforcements from flanking you on the approach to Kalithea.
	<br/>
	<br/><font size='18' color='#80FF00'>CREDITS</font>
	<br/>Created by <font color='#FF0080'>2600K</font color>
	<br/>
	<br/>A custom-made mission for ArmA 3 and Zeus Community
	<br/>http://zeus-community.net
	<br/>",
	if (f_param_CasualtiesCap > 0 && f_param_CasualtiesCap < 100) then { format["Ensure casualties are kept below %1 and %1&#37; of your force is not incapacitated.<br/>", f_param_CasualtiesCap] } else { "" },
	(((vehicles select { side _x getFriend side group player < 0.6 && !(_x isKindOf "staticWeapon" || _x isKindOf "static") && count crew _x > 0}) apply {  getText (configFile >> "CfgVehicles" >> typeOf _x >> "displayName") }) call BIS_fnc_consolidateArray) apply { format["%2x <font color='#00FFFF'>%1</font><br/>", _x#0, _x#1] } joinString "",
	format["%1x <font color='#00FFFF'>Infantry Groups</font><br/>", { side _x getFriend side group player < 0.6 && count units _x >= 3 && vehicle leader _x == leader _x} count allGroups]
	]]];
};
