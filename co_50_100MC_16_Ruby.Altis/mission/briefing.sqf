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
	<br/><font color='#72E500'>1.</font color> Locate and destroy two CSAT artillery assets somewhere around <marker name='A1'>here</marker> and <marker name='A1_1'>here</marker>.
	<br/><font color='#72E500'>2.</font color> Exfil the area by reaching the <marker name='EX'>Extraction Point</marker>.
	<br/>
	<br/>%1 <!--- Casualties Cap --->
	<br/><font size='18' color='#80FF00'>FRIENDLY FORCES</font>
	<br/>One platoon of up to five squads; Alpha, Bravo, Charlie, Delta and Echo. 
	<br/>
	<br/>You begin <marker name='respawn_guerrila'>West of Paros</marker> having dismounted. You are to approach the city on foot.
	<br/>
	<br/>
	<br/><font size='18' color='#80FF00'>ENEMY FORCES</font>
	<br/>The city of Paros was not deemed much of a threat until the recent artillery strikes, so intel on the area is limited, the town is not anticipated to be heavily garrisoned.
	<br/>
	<br/>A platoon sized force can be expected to be located within the AO with guards posted around each artillery asset.
	<br/>
	<br/>Friendly locals have reported two mechanised sections passing through the town heading North, they are unlikely to be far away.
	<br/>
	<br/>The following units are known to be operational in the AO:
	<br/>%2%3
	<br/>
	<br/><font size='18' color='#80FF00'>BACKGROUND</font>
	<br/>An urgent communication from AAF HQ indicates there are two artillery units operating around the vicinity of Paros. 
	<br/>
	<br/>Unfortunately HQ doesn't know their exact location and has no solid information on what enemy forces may be located there.
	<br/>
	<br/>But that is not not going to stop them ordering your platoon to move in, good luck!
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
