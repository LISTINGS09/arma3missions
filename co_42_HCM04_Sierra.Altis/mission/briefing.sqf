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
	<br/>The FIAs presence on Altis is about to come to an end. The AAF has recently focused all military efforts in eliminating FIA and your forces have lost almost all support, men and territory in the region. 
	<br/>
	<br/>Your platoon and glorious Commander is all that still remains of FIA on the island. 
	<br/>
	<br/>Formerly based at Pyrgos, you have been forced to abandon the area due to your scouts reporting a of heavily armed AAF force moving in from the East. It's time to leave the island and fast! 
	<br/>
	<br/>The scout also spotted a suitable means of transport landing somewhere to the east. Unfortunately, it looks to be over 3km away inside AAF territory.
	<br/>
	<br/>With the AAF armoured column due to arrive in Pyrgos within the hour, your unit does not have any other option but to attempt to reach it and leave the island for good.
	<br/>
	<br/>Use the <font color='#0080FF'><marker name='OR'>Off-road</marker></font color> to mine the MSR into Prygos to slow the advance of the armoured platoon.
	<br/>
	<br/>Leave Pyrgos and head east to locate a transport helicopter somewhere near the <font color='#0080FF'><marker name='CP'>Command Post</marker></font color> allowing your Commander to leave the island.
	<br/>
	<br/>%1 <!--- Casualties Cap --->
	<br/><font size='18' color='#80FF00'>FRIENDLY FORCES</font>
	<br/>Your unit begins <font color='#0080FF'><marker name='respawn_west'>Outside Pyrgos</marker></font color>, you have loaded all you could into trucks and off-roads which may be used to travel across the AO.
	<br/>
	<br/>You also managed to salvage two HMG technicals which may be utilised by squads.
	<br/>
	<br/>
	<br/><font size='18' color='#80FF00'>ENEMY FORCES</font>
	<br/>A heavily armoured platoon is due to arrive at Pyrgos with orders to eliminate your platoon, they are currently passing <font color='#0080FF'><marker name='A'>Chalkeia</marker></font color> and will be heading to <font color='#0080FF'><marker name='A_1_6_2'>Pyrgos</marker></font color>. If this platoon is engaged directly they will likely call in mortar or air support - They are best avoided.
	<br/>
	<br/>Light infantry patrols can be expected across the AO, with increased guards around each of the AAF installations towards the east. Motorised and mechanised supports will be available to the AAF, expect to encounter these within the AO.
	<br/>
	<br/>Standard AAF AT infantry have lock-on capability - Travel with caution in vehicles.
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
	(((vehicles select { side _x getFriend side group player < 0.6 && !(_x isKindOf "staticWeapon" || _x isKindOf "static") && count crew _x > 0}) apply {  getText (configFile >> "CfgVehicles" >> typeOf _x >> "displayName") }) call BIS_fnc_consolidateArray) apply { format["%2x <font color='#00FFFF'>%1</font><br/>", _x#0, _x#1] } joinString "",
	format["%1x <font color='#00FFFF'>Infantry Groups</font><br/>", { side _x getFriend side group player < 0.6 && count units _x >= 3 && vehicle leader _x == leader _x} count allGroups]
	]]];
};


// Commander Endings
if (rank player in ["MAJOR","COLONEL"]) then {
	private _missionEndings = "<font size='18' color='#80FF00'>ENDINGS</font><br/><br/>These endings are available. To trigger an ending click on its link - It will take a few seconds to synchronise across all clients.<br/><br/>";

	for "_i" from 1 to 15 do {
		private _eID = format ["end%1",_i];

		if (getText (getMissionConfig "CfgDebriefing" >> _eID >> "Title") != "") then {	
			_missionEndings = _missionEndings + format [
				"%4<br/><execute expression=""['f_briefing.sqf','End%1 called by %5','INFO'] remoteExec ['f_fnc_logIssue',2]; 'End%1' remoteExec ['BIS_fnc_endMission'];"">Ending #%1</execute> - %2:<br/>%3<br/><br/>",
				_i,
				getText (getMissionConfig "CfgDebriefing" >> _eID >> "title"),
				getText (getMissionConfig "CfgDebriefing" >> _eID >> "description"),
				format["<img image='%1' height='32'/>", getText (getMissionConfig "CfgDebriefing" >> _eID >> "picture")],
				name player
			];	
		};
	};

	// Create the briefing section to display the endings
	player createDiaryRecord ["Diary", ["Endings",_missionEndings]];
};