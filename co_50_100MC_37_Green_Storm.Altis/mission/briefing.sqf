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
	<br/>Secure the two CSAT locations by eliminating all contacts there:
	<br/>Eliminate all enemies near <font color='#0080FF'><marker name='O_2'>Frini</marker></font color>.
	<br/>Secure the <font color='#0080FF'><marker name='O_1'>Outpost</marker></font color>.
	<br/>
	<br/>When complete <font color='#0080FF'><marker name='EX'>extract</marker></font color> and await exfil.
	<br/>
	<br/>Eliminating the mortar position is optional, but recommended.
	<br/>
	<br/>
	<br/>%1 <!--- Casualties Cap --->
	<br/><font size='18' color='#80FF00'>FRIENDLY FORCES</font>
	<br/>Your platoon begins dismounted at <font color='#0080FF'><marker name='respawn_guerrila'>Agia Triada</marker></font color>.
	<br/>
	<br/>You will need to advance to your objectives on foot.
	<br/>
	<br/><font size='18' color='#80FF00'>ENEMY FORCES</font>
	<br/>Both <font color='#0080FF'><marker name='O_2'>Frini</marker></font color> and the <font color='#0080FF'><marker name='O_1'>Outpost</marker></font color> have one squad each on guard at all times. 
	<br/>
	<br/>A number of infantry squads will be patrolling the surrounding area, supported by light vehicles. At least one armoured IFV and mobile AA are known to be operational in the area, there are likely others.
	<br/>
	<br/>The enemy also has a number of static supports; both mounted HMG positions deployed and also mortar positions. 
	<br/>
	<br/>A mortar have been identified and marked.
	<br/>
	<br/>No further CSAT reinforcements by air are expected, however other enemy forces to the South and West may respond to your attack, any QRF is not expected to be significant as CSAT is also fighting our forces at the front-line towards the South.
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
