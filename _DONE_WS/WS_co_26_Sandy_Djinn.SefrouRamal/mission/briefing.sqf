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
	<br/>Your ION Unit has been tasked to locate and recover containers around M'Semrir. 
	<br/>
	<br/>There are six containers in total. Three are located at the <marker name='marker_6'>IDAP Site</marker>. The remaining three containers are believed to be located at the <marker name='marker_7'>Fuel Depot</marker>. 
	<br/>
	<br/>Securing the IDAP Site is an immediate priority to stop any further Tura incursions into the nearby cities.
	<br/>
	<br/>There are two ZU23-2 AA Trucks active at the site. These will need to be destroyed to allow the URA helicopters to sling-load the containers back to the airport. 
	<br/>%1 <!--- Casualties Cap --->
	<br/>
	<br/><font size='18' color='#80FF00'>FRIENDLY FORCES</font>
	<br/>NATO has assigned Eagle on standby to provide CAS for your team and the recovery process.
	<br/>
	<br/>Civilians will be present in the area - Do not engage them!
	<br/>
	<br/><font size='18' color='#80FF00'>ENEMY FORCES</font>
	<br/>All enemy forces are all located at the <marker name='marker_6'>IDAP Site</marker>, all cities remain under URA control. 
	<br/>
	<br/>The following units are known to be operational in the AO:
	<br/>%2%3
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