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
	<br/>Secure the town of <font color='#0080FF'><marker name='M1'>Athanos</marker></font color> in preparation for a larger AAF group to land on the beach.
	<br/>
	<br/>When the town has been secured, hold at the <font color='#0080FF'><marker name='EX'>Exfil</marker></font color>.
	<br/>
	<br/>%1 <!--- Casualties Cap --->
	<br/><font size='18' color='#80FF00'>SPECIAL TASKS</font>
	<br/>A gunship has been reported to have landed somewhere within the AO. HQ strongly suggests that this is dealt with before you are detected or it becomes airborne, a house to the North is known to contain AA munitions.
	<br/>
	<br/><font size='18' color='#80FF00'>FRIENDLY FORCES</font>
	<br/>One platoon of up to five highly-trained squads; Alpha, Bravo, Charlie, Delta and Echo.
	<br/>
	<br/>Your platoon has discarded their underwater breathing equipment and is wearing body armor due to the CQB threat inside the town.
	<br/>
	<br/>The main attack group will not move inland until your objectives have been accomplished - They will not be able to provide any support for the duration of your mission.
	<br/>
	<br/><font size='18' color='#80FF00'>ENEMY FORCES</font>
	<br/>AAF HQ has identified key areas within the AO that will need captured in order to complete the objective. These are marked as <font color='#0080FF'><marker name='Z_1'>Shaded Grids</marker></font color>.
	<br/>
	<br/>An urgent communication from JTAC was received just prior to your landing. They report a gunship having recently landed at an unknown location within the AO. Finding and eliminating this asset before it can become airborne should be a priority.
	<br/>
	<br/>Within Athanos itself, the town is lightly defended - It is known to be home to only three squads. The majority of enemy forces have been consolidating in Kavala giving us an easy run.
	<br/>
	<br/>Motorised vehicles have been observed heading North through the town, their exact numbers are unknown, but expect a small number to remain at the town to support the remaining infantry.
	<br/>
	<br/>Do not expect CSAT to let the south fall easily, you should expect enemy QRF reinforcements to arrive from the North when the enemy learn of our attack.
	<br/>
	<br/>The following units are known to be operational or form part of the QRF in the AO:
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
