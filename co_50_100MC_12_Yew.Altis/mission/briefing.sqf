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
	<br/>Capture the CSAT <marker name='OBJ'>Lookout Post</marker>.
	<br/>
	<br/>%1 <!--- Casualties Cap --->
	<br/><font size='18' color='#80FF00'>FRIENDLY FORCES</font>
	<br/>One platoon of up to five squads; Alpha, Bravo, Charlie, Delta and Echo. 
	<br/>
	<br/>You begin <marker name='respawn_guerrila'>West of Mazi</marker> having been deployed by boat and must advance on foot.
	<br/>
	<br/>An engineer team has already been in and cleared the mines on your approach to the Outpost, but an E.O.D unit is present in each squad, in case any were missed.
	<br/>
	<br/><font size='18' color='#80FF00'>ENEMY FORCES</font>
	<br/>A enemy minefield has already been cleared allowing your insertion from the coast, there are two known minefield locations to your <marker name='MINESM_1'>North</marker> and <marker name='MINESM_1_1'>South</marker>, there may be more in the AO.
	<br/>
	<br/>The <marker name='OBJ'>Lookout Post</marker> is expected to contain about 2 squads of infantry, they will be on patrol around the area. Static supports are likely, but not confirmed.
	<br/>
	<br/>The town of <marker name='OBJ_1'>Selakano</marker> can be expected to have additional troops stationed there.
	<br/>
	<br/>A mechanised squad is known to be deployed around this area, expect them to respond when the outpost comes under attack.
	<br/>
	<br/><font size='18' color='#80FF00'>BACKGROUND</font>
	<br/>Paramilitary forces are preparing to launch a major assault on the Southern CSAT-controlled region of Altis. 
	<br/>
	<br/>The initial phase of this assault will involve the capture of the key CSAT lookout posts.
	<br/>
	<br/>Your platoon will be deployed by sea and is to assault the lookout post after the beach has been cleared by an engineer squad.
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
