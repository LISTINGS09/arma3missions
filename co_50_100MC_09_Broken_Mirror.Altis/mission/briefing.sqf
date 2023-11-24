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
	<br/>Advance to the <marker name='MHVT'>Gatolia Solar Power Plant</marker> and eliminate the AAF Officer located there.
	<br/>
	<br/>%1 <!--- Casualties Cap --->
	<br/><font size='18' color='#80FF00'>SPECIAL TASKS</font>
	<br/>The AAF depot in Gatolia can be used to rearm your unit with AA and AT supplies if required.
	<br/>
	<br/>If the AAF forces observe enemy infantry within 100m of the Solar Plant they will try to evacuate the Officer.
	<br/>
	<br/><font size='18' color='#80FF00'>FRIENDLY FORCES</font>
	<br/>One platoon of up to five squads; Alpha, Bravo, Charlie, Delta and Echo.
	<br/>
	<br/>The platoon has dismounted at <marker name='respawn_west'>Sofia</marker> and must advance to the Solar Power Plant by foot.
	<br/>
	<br/><font size='18' color='#80FF00'>ENEMY FORCES</font>
	<br/>There are a number of obstacles between the Officer and ourselves, firstly the enemy is known to have set up a number of static emplacements within the Solar Power Plant itself watching over the AO. 
	<br/>
	<br/>Secondly, at least two mechanised and motorised vehicles are stationed at a munitions depot within <marker name='MHVT_1'>Gatolia</marker> itself, with others having been spotted travelling around or through the AO.
	<br/>
	<br/>A high number of infantry squads are expected to be located at the Gatolia depot or patrolling around the area. The Power Plant is expected to only contain the Officers own personal guards.
	<br/>
	<br/>The following units are known to be operational in the AO:
	<br/>%2%3
	<br/>
	<br/><font size='18' color='#80FF00'>BACKGROUND</font>
	<br/>Over the year the FIA have carried out a number of failed attempts to eliminate a senior high-ranking AAF Officer. A rare opportunity has once again presented itself to take down this Officer... Hopefully for good.
	<br/>
	<br/>The Officer is touring a number of sites around Altis and the FIA has been provided with the time and location they will be present at of one of those sites; the <marker name='MHVT'>Gatolia Solar Power Plant</marker>.
	<br/>
	<br/>Your platoon has been instructed to move out immediately and travel to Sofia, where you are to dismount and assault the Plant, eliminating the Officer.
	<br/>
	<br/>There is already an ongoing conflict in the North region between the AAF and CSAT forces, so the Officer is unlikely to flee unless the we are spotted in the immediate vicinity of the Power Plant. 
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
