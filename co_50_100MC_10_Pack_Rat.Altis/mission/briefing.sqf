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
	<br/>Capture the <marker name='OBJ'>Fuel Truck</marker> and return it to <marker name='REC'>Pyrgos</marker>.
	<br/>
	<br/>The destruction of the Fuel Truck from any source will result in the failure of the mission.
	<br/>
	<br/>%1 <!--- Casualties Cap --->
	<br/><font size='18' color='#80FF00'>FRIENDLY FORCES</font>
	<br/>One platoon of up to five squads; Alpha, Bravo, Charlie, Delta and Echo. 
	<br/>
	<br/>You begin <marker name='respawn_guerrila'>Outside Pyrgos</marker> and must advance to the truck on foot.
	<br/>
	<br/><font size='18' color='#80FF00'>ENEMY FORCES</font>
	<br/>The enemy has already been weakened having lost a number of squads in their last attack. It is estimated that one group of platoon strength still remains out there.
	<br/>
	<br/>CSAT has held back so far on using their mechanised or motorised supports, two IFVs and two HMG Ifrits have been spotted on patrol around the objective. Expect to encounter these as you near the quarry.
	<br/>
	<br/>Expect additional CSAT reinforcements to be moving in from the South.
	<br/>
	<br/><font size='18' color='#80FF00'>BACKGROUND</font>
	<br/>The situation is dire for the AAF. Multiple enemy assaults across Altis have left a number of infantry units stranded without communication with the main AAF force. 
	<br/>
	<br/>Your platoon is one such unit; your F.O.B at Pyrgos was attacked by CSAT forces causing heavy damage to the supply depot before you were able to gain the upper hand and regain control of the situation, eliminating the attackers.
	<br/>
	<br/>You are now left with no means of either communicating with HQ and have lost your fuel and ammunition supplies. 
	<br/>
	<br/>Without fuel you will never make it back to the main AAF base to the North. The only ammunition you have is that which you have on you already.
	<br/>
	<br/>As luck would have it, old intel indicates the enemy have a <marker name='OBJ'>Fuel Truck</marker> to the South of Pyrgos, in a disused quarry.
	<br/>
	<br/>Your only hope of escaping is to capture this fuel truck and then using it to refuel the transport vehicles back at base.
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
