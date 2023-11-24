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
	<br/>Two transports with armed gunship escort will shortly be heading to Altis Airport along the <font color='#0080FF'><marker name='WP_6'>designated path</marker></font color>.
	<br/>
	<br/>Bring down the AAF Transports travelling along the <font color='#0080FF'><marker name='WP_6'>Flight Path</marker></font color>.
	<br/>
	<br/>Move to the <font color='#0080FF'><marker name='EX'>extraction</marker></font color> point when both transports have been destroyed.
	<br/>
	<br/>%1 <!--- Casualties Cap --->
	<br/><font size='18' color='#80FF00'>FRIENDLY FORCES</font>
	<br/>One platoon of up to five squads; Alpha, Bravo, Charlie, Delta and Echo.
	<br/>
	<br/>Each squad arrived into the village in their own Truck. This is unlocked and may be used in the mission.
	<br/>
	<br/><font size='18' color='#80FF00'>ENEMY FORCES</font>
	<br/>In addition to the two AAF transports inbound, each is flying with an armed escort (four helicopters total). Due to fuel restrictions, neither the transports or the escorts are carrying additional passengers.
	<br/>
	<br/>The <font color='#0080FF'><marker name='Z_1'>AAF Outpost</marker></font color> is likely your largest threat, home to at least three squads and one IFV supported by at least one mortar team - Most of these forces are likely to be patrolling around the area local to the Outpost. Other motorised and mechanised assets may be operational in the area.
	<br/>
	<br/>The transports flight path terminates at Altis Airfield 4km to the West of the Ambush Point - The AAF will certainly dispatch a QRF to assist from the Airfield. You should consider this a threat, if you cannot execute your objectives quickly.
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
