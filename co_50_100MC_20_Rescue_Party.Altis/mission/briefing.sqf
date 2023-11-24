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
	<br/><font color='#72E500'>1.</font color> Secure the area around the <marker name='CV'>Transport</marker>.
	<br/><font color='#72E500'>2.</font color> Repair and <marker name='FM'>refuel</marker> the transport.
	<br/><font color='#72E500'>3.</font color> Escort the transport through the town of Agios Dionysios <marker name='MEND'>towards Altis airport</marker>.
	<br/>
	<br/>Destruction of the transport will result in the failure of the mission.
	<br/>
	<br/>%1 <!--- Casualties Cap --->
	<br/><font size='18' color='#80FF00'>FRIENDLY FORCES</font>
	<br/>One infantry platoon of up to five squads; Alpha, Bravo, Charlie, Delta and Echo. 
	<br/>
	<br/>You begin to the <marker name='respawn_west'>South</marker> of the ambush location.
	<br/>
	<br/><font size='18' color='#80FF00'>ENEMY FORCES</font>
	<br/>The enemy are using the local factory as a temporary <marker name='BMK'>F.O.B</marker>, attacking that will likely lead to heavy reinforcements from outside the AO.
	<br/>
	<br/>The Mi-48 Kajman was last reported to be heading further East, provided you keep the transport along the MSR it will not return. Should you encounter any air contacts your only options are to either retreat or raid the depot at the enemy F.O.B for munitions.
	<br/>
	<br/>Around the transport itself contact should be light - Zulu should had dealt with most of the contacts and those remaining will have retreated back towards the town.
	<br/>
	<br/>Once CSAT realise your squads are still active inside the AO they will likely send reinforcements from either the F.O.B or town of Agios Dionysios. 
	<br/>
	<br/>Strength is estimated to be two or three squads each; inside the town and at the F.O.B. Expect light vehicles and mechanised supports the longer you remain inside the AO.
	<br/>
	<br/><font size='18' color='#80FF00'>BACKGROUND</font>
	<br/>A NATO convoy transporting an urgent cargo to Altis airport was engaged by a CSAT Mi-48 and ground forces hours ago just <marker name='CV'>outside Agios Dionysios</marker>. 
	<br/>
	<br/>Zulu squad whom were tasked escorting the convoy, fought bravely and reported to have pushed the CSAT forces back, taking heavy casualties. All contact has since been lost with Zulu, they are presumed KIA.
	<br/>
	<br/>This appears to have been a opportunistic engagement on behalf of CSAT, we are lucky they were not aware of the true significance of the cargo being delivered. 
	<br/>
	<br/>Readings from the cargo transport indicate it is still functional on the road but has a fuel leak.
	<br/>
	<br/>Your platoon is to move out and secure the cargo and get it to the airport by any means necessary.
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
