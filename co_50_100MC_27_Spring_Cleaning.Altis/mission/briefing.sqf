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
	<br/>Clear Therisa of enemy presence by clearing the <font color='#E5E500'><marker name='A2_2'>Yellow</marker></font color>, <font color='#EE0000'><marker name='A3_3'>Red</marker></font color>, <font color='#009900'><marker name='A1_2'>Green</marker></font color> and <font color='#4CA6FF'><marker name='A4_2'>Blue</marker></font color> Zones.
	<br/>
	<br/>When complete, reach the <font color='#0080FF'><marker name='EX'>Form Up Point</marker></font color> and return to the vehicles.
	<br/>
	<br/>%1 <!--- Casualties Cap --->
	<br/><font size='18' color='#80FF00'>FRIENDLY FORCES</font>
	<br/>Your infantry platoon is made of up to five squads and you begin <font color='#0080FF'><marker name='respawn_west'>here</marker></font color>.
	<br/>
	<br/><font size='18' color='#80FF00'>ENEMY FORCES</font>
	<br/>At least one CSAT infantry squad was occupying the town previously, they have set up checkpoints along routes into Therisa defended by HMG emplacements, but little else. 
	<br/>
	<br/>At least three sections of infantry are known to have been arrived into the town in the recent days. The majority of infantry arrived in transports or on foot, however both motorised and mechanised vehicles have been seen going to and from the town. 
	<br/>
	<br/>Given the distance of Therisa from all known CSAT outposts, it is highly unlikely that any responding force will reach the town before you have completed your objective.
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
