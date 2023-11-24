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
	<br/>Destroy the <font color='#0080FF'><marker name='AA_1'>3x Mobile AA units</marker></font color> then fly out from the city to the NATO HQ at Altis Airfield.
	<br/>
	<br/>Plan for an advance to the <font color='#0080FF'><marker name='MC'>CSAT Northern Military Base</marker></font color> - The AA assets are likely located inside or close to it. It is unlikely they can be engaged from Pyrgos.
	<br/>
	<br/>Transport vehicles are located around the <font color='#0080FF'><marker name='respawn_west'>NATO Camp</marker></font color> and may be used, but it is advised they are only used within the city borders.
	<br/>
	<br/>%1 <!--- Casualties Cap --->
	<br/><font size='18' color='#80FF00'>FRIENDLY FORCES</font>
	<br/>Located at a former <font color='#0080FF'><marker name='respawn_west'>NATO Camp</marker></font color> in Pyrgos, you are one platoon of up to five squads; Alpha, Bravo, Charlie, Delta and Echo.
	<br/>
	<br/>Over the days you have moved what supplies you could find to a <font color='#0080FF'><marker name='S'>Road Block</marker></font color> on each MSR into the city. A limited number of infantry transport vehicles are also available in the camp itself.
	<br/>
	<br/>
	<br/><font size='18' color='#80FF00'>ENEMY FORCES</font>
	<br/>One CSAT infantry section occupies the <font color='#0080FF'><marker name='MC'>Northern Military Base</marker></font color> a number of supports have been deployed there including HMG and mortar emplacements.
	<br/>
	<br/>Two <font color='#0080FF'><marker name='V'>Infantry Squads</marker></font color> have been spotted South, heading towards Pyrgos. They will arrive at the city in around 10 minutes. 
	<br/>
	<br/>A <font color='#0080FF'><marker name='V_1'>Mechanised Section</marker></font color> has been spotted moving into the AO by NATO HQ, they are approaching from the North-East. Forces consist of at least two APCs and supporting infantry, arrival time is 20 minutes.
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
	(((vehicles select { side _x getFriend side group player < 0.6 && !(_x isKindOf "staticWeapon" || _x isKindOf "static") && count crew _x > 0}) apply { "Motorised/Mechanised Vehicles" }) call BIS_fnc_consolidateArray) apply { format["%2x <font color='#00FFFF'>%1</font><br/>", _x#0, _x#1] } joinString "",
	format["%1x <font color='#00FFFF'>Infantry Groups</font><br/>", { side _x getFriend side group player < 0.6 && count units _x >= 3 && vehicle leader _x == leader _x} count allGroups]
	]]];
};
