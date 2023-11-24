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
	<br/>Eliminate the <marker name='M1'>Drug Kingpin</marker> in his mansion.
	<br/>
	<br/>%1 <!--- Casualties Cap --->
	<br/><font size='18' color='#80FF00'>FRIENDLY FORCES</font>
	<br/>One platoon of up to five squads; Alpha, Bravo, Charlie, Delta and Echo.
	<br/>
	<br/>You start <marker name='respawn_guerrila'>East of the Mansion</marker> and must proceed to your objective on foot.
	<br/>
	<br/><font size='18' color='#80FF00'>ENEMY FORCES</font>
	<br/>At least three FIA squads are known to reside around the Mansion, in addition to this a number of smaller sentry patrols regularly patrol the land around Iraklia.
	<br/>
	<br/>The enemy will have access to HMG technicals, expect them to be put into use when you are detected by the enemy.
	<br/>
	<br/>The following units are known to be operational in the AO:
	<br/>%2%3
	<br/>
	<br/><font size='18' color='#80FF00'>BACKGROUND</font>
	<br/>The FIA is known to have been financing a number of their recent attacks on AAF with laundered money. This money has been tracked back to its source and we understand that the FIA are collaborating with a local drug kingpin known as Stavrou.
	<br/>
	<br/>Stavrou has ignored our requests to break all connections with the FIA. All the while the FIA continue to gain increased control of Altis. 
	<br/>
	<br/>With no sign of his alliance with the FIA breaking, the time has come to retire Stavrou, who resides at his <marker name='M1'>Mansion</marker> near Iraklia.
	<br/>
	<br/>Due to Stavrou's connections to the FIA, a number of their squads are stationed in or around his mansion making a full-on battle inevitable.
	<br/>
	<br/>Your unit must push through to the mansion and eliminate Stavrou to severely weaken FIA operations on Altis.
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
