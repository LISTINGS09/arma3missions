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
	<br/><font color='#72E500'>1.</font color> Eliminate all resistance at the <marker name='OBJ1'>Outpost</marker> to allow the scientists to be extracted.
	<br/><font color='#72E500'>2.</font color> Ensure none of the three scientists get killed.
	<br/>
	<br/>%1 <!--- Casualties Cap --->
	<br/><font size='18' color='#80FF00'>FRIENDLY FORCES</font>
	<br/>One platoon of up to five squads; Alpha, Bravo, Charlie, Delta and Echo have been dropped into enemy territory via helicopter.
	<br/>
	<br/>You begin <marker name='respawn_guerrila'>South</marker> of the objective and now must advance on foot to avoid detection.
	<br/>
	<br/>
	<br/><font size='18' color='#80FF00'>ENEMY FORCES</font>
	<br/>The enemy have a number of fortified emplacements around the <marker name='OBJ1'>Outpost</marker>, these have been indicated on the map. 
	<br/>
	<br/>Expect to encounter patrols and HMG technical supports within the AO. At least one armed helicopter is present at the Outpost.
	<br/>
	<br/>The AAF were not aware this enemy compound even existed until now, so we have no idea as to the layout of the facility or what lies inside.
	<br/>
	<br/><font size='18' color='#80FF00'>BACKGROUND</font>
	<br/>AAF HQ has intercepted an FIA communication indicating in the last hour their forces have recently smuggled three key scientists into Altis by helicopter. 
	<br/>
	<br/>They are currently being held in a secure <marker name='OBJ1'>Outpost</marker> north of Frini, near the coast. They will only be there for a few hours before being moved on to another location.
	<br/>
	<br/>What the FIA intends to do with these recent arrivals remains unknown, however AAF HQ has ordered your unit to ensure their immediate safety before anything more can happen to them!
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
