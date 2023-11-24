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
	<br/><font color='#72E500'>1.</font color> Find and capture the FIA Command Compound somewhere within the town.
	<br/><font color='#72E500'>2.</font color> <marker name='EX'>Extract South</marker> when the compound has been cleared.
	<br/>
	<br/>The Command Compound can be identified as the only structure in Sofia with a camo net.
	<br/>
	<br/>%1 <!--- Casualties Cap --->
	<br/><font size='18' color='#80FF00'>FRIENDLY FORCES</font>
	<br/>One platoon of up to five infantry squads; Alpha, Bravo, Charlie, Delta and Echo. 
	<br/>
	<br/>Your unit begins near <marker name='respawn_east'>Skiptro Mountain</marker>, having dismounted from your vehicles. Your objective lies East.
	<br/>
	<br/>HQ has ordered you go on foot from your current location, you are not permitted to use the vehicles.
	<br/>
	<br/><font size='18' color='#80FF00'>ENEMY FORCES</font>
	<br/>The Command Compound forms the base of operations for FIA within the area and is guarded heavily on all sides. Infantry strength within Sofia is estimated to be of platoon size.
	<br/>
	<br/>FIA are known to have a mortar deployed somewhere within the town.
	<br/>
	<br/>The following units are known to be operational in the AO:
	<br/>%2%3
	<br/>
	<br/><font size='18' color='#80FF00'>BACKGROUND</font>
	<br/>Ongoing is the battle of Altis between FIA, NATO and CSAT forces. CSAT forces have been slowly gaining ground on FIA forces, pushing them back to the North.
	<br/>
	<br/>The town of Sofia has been known to contain active FIA groups for a number of weeks, however only now does lie directly in the path of the CSAT advance towards Molos in the North-East. 
	<br/>
	<br/>Due to friendly forces focusing their attention elsewhere, the FIA forces within Sofia have had ample time to fortify the town which will now prevent a quick CSAT advance Northwards if not dealt with.
	<br/>
	<br/>All main routes into the town have been barricaded along with several AT minefields having been deployed in the area. Finding the Command Compound within the town should give us intel on the exact minefield locations and allow our Engineer teams to move in.
	<br/>
	<br/>Your CSAT platoon is currently travelling toward Sofia, to capture the Command Compound so the advance down the MSR to Molos can continue without any delay.
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
