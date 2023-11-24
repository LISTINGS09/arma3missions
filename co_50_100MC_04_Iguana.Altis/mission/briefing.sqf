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
	<br/>Clear the factory of CSAT forces then head east to meet up with our informant at the <font color='#0080FF'><marker name='EX'>Extract Marker</marker></font color>. They will then smuggle you through the CSAT border.
	<br/>
	<br/>Approach the factory with caution - A number of patrols may be moving around the factory perimeter. 
	<br/>
	<br/>%1 <!--- Casualties Cap --->
	<br/><font size='18' color='#80FF00'>FRIENDLY FORCES</font>
	<br/>One platoon of up to five squads; Alpha, Bravo, Charlie, Delta and Echo. 
	<br/>
	<br/>You start <font color='#0080FF'><marker name='respawn_guerrila'>North of the Factory</marker></font color> and must advance to your objective on foot.
	<br/>
	<br/>FIA will not be supporting directly within the mission. AAF HQ has agreed that in return for clearing the factory they have agreed to facilitate our escape out of the area and will also ensure the factory is destroyed. The CSAT equipment and resources at the factory will aid the FIA efforts in the field.
	<br/>
	<br/><font size='18' color='#80FF00'>ENEMY FORCES</font>
	<br/>The weapons plant is responsible for producing a large percentage CSATs current munitions, expect infantry patrols around the factory and at least two squads of guards within it.
	<br/>
	<br/>The informant has warned of a motor pool located to the west side of the factory and a bunker reported somewhere to the east, exact locations were not provided.
	<br/>
	<br/>The following units are known to be operational in the AO:
	<br/>%2%3
	<br/>
	<br/><font size='18' color='#80FF00'>BACKGROUND</font>
	<br/>The AAF have long suspected that CSAT forces have re-purposed one of the factories to the west of Altis and began using it to start mass producing munitions for use in their offensive across the island.
	<br/>
	<br/>Until recently, it was not known which factory was being used. Luckily, due a FIA informant inside the local town of Kore, the <font color='#0080FF'><marker name='M1_1'>Weapons Factory</marker></font color> has been confirmed to be the one immediately to the west of Kore. 
	<br/>
	<br/>As part of the 3rd Battalion 7th AAF Rangers known as 'The Cutting Edge', you have been dropped into hostile CSAT territory and have made your way into the forest, heading south towards the factory's location. 
	<br/>
	<br/>As you near your objective, you regroup <font color='#0080FF'><marker name='respawn_guerrila'>to the North</marker></font color> and run through the plan of action.
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
