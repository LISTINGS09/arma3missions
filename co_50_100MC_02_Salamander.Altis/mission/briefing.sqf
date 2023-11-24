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
	<br/>Approach the town as seen fit, then begin clearing the city. Proceed into <font color='#0080FF'><marker name='M1_1'>Panagia</marker></font color> and clear each shaded grid sector within.
	<br/>
	<br/>Use each squads E.O.D unit if necessary. 
	<br/>
	<br/>When Panagia is secured, all units are to <font color='#0080FF'><marker name='EX'>extract to the South-West</marker></font color> outside the town.
	<br/>
	<br/>%1 <!--- Casualties Cap --->
	<br/><font size='18' color='#80FF00'>SPECIAL TASKS</font>
	<br/>Using the intel from the UAV likely CSAT occupation zones have been marked as <font color='#0080FF'><marker name='Z_1'>shaded grids</marker></font color> on your map. 
	<br/>
	<br/>Once a grid has been secured, it will change color. The majority of grids within Panagia should be clear in order to complete the mission.
	<br/>
	<br/><font size='18' color='#80FF00'>FRIENDLY FORCES</font>
	<br/>One platoon of up to five squads; Alpha, Bravo, Charlie, Delta and Echo with attached E.O.D units.
	<br/>
	<br/>You <font color='#0080FF'><marker name='respawn_guerrila'>begin here</marker></font color> and must advance to your objective on foot.
	<br/>
	<br/><font size='18' color='#80FF00'>ENEMY FORCES</font>
	<br/>UAV intel indicates at least four squad elements within the town and at least two motorised supporting assets. Locations of interest have been identified as <font color='#0080FF'><marker name='Z_1'>shaded grids</marker></font color> on your map.
	<br/>
	<br/>All minefields have been marked; there appears to be a safe corridor of approach to the North-West side of the town, no mines were also detected towards the South-East of the town.
	<br/>
	<br/>CSAT forces appear to be highly active within this region. It is likely that reinforcements will to move into the town from the South in a prolonged engagement.
	<br/>
	<br/>The following units are known to be operational in the AO:
	<br/>%2%3
	<br/>
	<br/><font size='18' color='#80FF00'>BACKGROUND</font>
	<br/>Your platoon has been drafted into Altis to assist in pushing invading CSAT forces from the island. You are part of the 4th AAF Standby Reaction Corps, stationed at Chalkeia.
	<br/>
	<br/>A recent patrol heading south down the MSR to the village of Feres reported a hostile minefield around the town of <font color='#0080FF'><marker name='M1_1'>Panagia</marker></font color> before retreating back to the F.O.B.
	<br/>
	<br/>A UAV flyover has indeed confirmed both mines and significant CSAT infantry around the town. HQ has mandated that the CSAT garrison in this town must be eliminated before the AAF can continue with any further operations around the area. 
	<br/>
	<br/>Your unit was immediately dispatched and having arrived, has just <font color='#0080FF'><marker name='respawn_guerrila'>dismounted</marker></font color> to the North of Panagia ready to move into the town.
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