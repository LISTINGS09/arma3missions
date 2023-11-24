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
	<br/>Locate and clear the <marker name='M2'>Three Camps</marker> somewhere in the marked zone.
	<br/>
	<br/>Once the camps have been neutralised, secure the docks to complete the mission.
	<br/>
	<br/>If you are detected by one of the FIA camps, the camp will launch a flare to try and rally reinforcements to that location.
	<br/>
	<br/>%1 <!--- Casualties Cap --->
	<br/>
	<br/><font size='18' color='#80FF00'>FRIENDLY FORCES</font>
	<br/>One platoon of up to five squads; Alpha, Bravo, Charlie, Delta and Echo.
	<br/>
	<br/>You have been transported to the <marker name='respawn_guerrila'>AAF Outpost</marker> by helicopter with orders to move into the forest to the objectives on foot.
	<br/>
	<br/><font size='18' color='#80FF00'>ENEMY FORCES</font>
	<br/>Exact numbers are not known, but this is a major hub for the FIA. The enemy typically operates in large groups of around 20-30 infantry strong. With three camps in the area we can expect at least three times that number of infantry.
	<br/>
	<br/>The combination of uneven terrain and forested area should mean motorised contacts will be kept to a minimum, but a group of this size assuredly have access to them. No intel is available to confirm if any static emplacements are in use by the enemy.
	<br/>
	<br/>The following units are known to be operational in the AO:
	<br/>%2%3
	<br/>
	<br/><font size='18' color='#FF7F00'>BACKGROUND</font>
	<br/>Relations between the FIA and Russia are at an all time low. The FIA continue to harass Russian positions around the north of Altis and have raided a number of Russian depots resulting in the loss of some valuable supplies.
	<br/>
	<br/>Little known to the FIA, we managed to capture one of their raiders during the assault. Following a friendly interrogation with the prisoner and our officers, we received intelligence suggesting that the FIA are using a old dock as a loading zone to transport their supplies out of the area.
	<br/>
	<br/>FIA presence around the docks is expected to be minimal since the majority of the FIA forces reside in three camps located located inside the woods between our Russian Outpost and the docks.
	<br/>
	<br/>The prisoner was unable to give the exact locations of the camps and unfortunately did not survive further interrogation despite extensive medical treatment.
	<br/>
	<br/>Our supplies will have already left the island, but we cannot allow the FIA to conduct another raid.
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
