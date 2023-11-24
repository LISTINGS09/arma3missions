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
	<br/>Eliminate the four static AA positions along the <font color='#0080FF'><marker name='AA_1'>West Coast</marker></font color>, at <font color='#0080FF'><marker name='AA_2'>Mt Didymos</marker></font color>, near the <font color='#0080FF'><marker name='AA_3'>Panagia Transmitter</marker></font color> and finally to the <font color='#0080FF'><marker name='AA_4'>South of Mt Didymos</marker></font color>.
	<br/>
	<br/>Once all are destroyed/disabled you are to form up at the <font color='#0080FF'><marker name='EX'>Extract</marker></font color> marker and await pickup.
	<br/>
	<br/>%1 <!--- Casualties Cap --->
	<br/><font size='18' color='#80FF00'>FRIENDLY FORCES</font>
	<br/>Your unit begins near south of Pyrgos, at the <font color='#0080FF'><marker name='respawn_west'>Quarry</marker></font color>. You are to move out on foot.
	<br/>
	<br/><font size='18' color='#80FF00'>ENEMY FORCES</font>
	<br/>There are a number of enemy units between your platoon and your objective AA positions;
	<br/>A <font color='#0080FF'><marker name='W_2'>Checkpoint</marker></font color> is understood to be somewhere around this location, there is one squad patrolling the area with motorised support.
	<br/>
	<br/>Further to the west, there are known enemy forces holding in <font color='#0080FF'><marker name='W'>compounds</marker></font color> at this location. The enemy may have deployed mines around this area.
	<br/>
	<br/>A section if infantry is known to have recently deployed at <font color='#0080FF'><marker name='W_1'>Ekali</marker></font color> with motorised support.
	<br/>
	<br/>An enemy <font color='#0080FF'><marker name='MT'>Mortar</marker></font color> position has been identified will be utilised against your forces.
	<br/>
	<br/>Finally, the enemy is known to be using a small <font color='#0080FF'><marker name='HQ'>Village</marker></font color> to the south as a storage area to re-arm the static launchers. This has at least one squad guarding it along with mechanised and static HMG supports.
	<br/>
	<br/>There are enemy patrols present across the AO, but contact is anticipated to be light with only fire-team sized elements or smaller. Intelligence on any assisting mechanised or motorised supports in the area are not known, but are expected.
	<br/>
	<br/>Any QRF will arrive from the South from Panagia or East from Chalkeia, they are likely to be mechanised forces.
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
