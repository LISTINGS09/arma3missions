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
	<br/><font color='#72E500'>1.</font color> Eliminate the two CSAT AA assets confirmed to be in the area, exact locations unknown.<br/>
	<br/><font color='#72E500'>2.</font color> Confirm the status and coordinates of the downed UAV somewhere in this <marker name='UAV_L'>Region</marker>, in preparation for an urgent NATO CAS run.<br/>
	<br/><font color='#72E500'>3.</font color> Exifl near Syrta.
	<br/>
	<br/>You will need to be close to the UAV to relay the GPS coordinates to NATO - Don't hang around when CAS comes in!
	<br/>
	<br/>%1 <!--- Casualties Cap --->
	<br/>
	<br/><font size='18' color='#80FF00'>FRIENDLY FORCES</font>
	<br/>One platoon of up to five squads; Alpha, Bravo, Charlie, Delta and Echo. 
	<br/>
	<br/>You begin <marker name='respawn_west'>South</marker> of your objective.
	<br/>
	<br/><font size='18' color='#80FF00'>ENEMY FORCES</font>
	<br/>Around four CSAT squads have reportedly entered the area. They are trying to secure it before they can get their engineers transported in.
	<br/>
	<br/>The enemy has set up a number of small fortifications as they are anticipating our forces trying to secure the downed UAV, NATO has not been able to confirm their locations as of yet.
	<br/>
	<br/>Along with the two enemy armoured AA assets, CSAT infantry will have IFV or APC supports.
	<br/>
	<br/>Locations of hostile forces were lost with the UAV, so NATO has been unable to provide specific locations on any threats.
	<br/>
	<br/>The following units are known to be operational in the AO:
	<br/>%2%3
	<br/>
	<br/><font size='18' color='#80FF00'>BACKGROUND</font>
	<br/>A NATO UAV recently came under fire while on a recon operation near Syrta. 
	<br/>
	<br/>The unit sustained critical damage and was seen by locals to crash land somewhere in the valley area near Amfissa somewhere within this <marker name='UAV_L'>Area</marker>.
	<br/>
	<br/>CSAT is unsurprisingly very interested in trying to acquire the data from the UAV and have quickly moved into the region.
	<br/>
	<br/>Your unit has been contacted by NATO to assist while their forces prepare for launching an urgent air strike on the UAV to destroy it. 
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
