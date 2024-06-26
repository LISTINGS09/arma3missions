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
	<br/>NATO forces have heavily fortified their Northern position and blocked all the roads from the South with heavy armour, anticipating our attack.
	<br/>
	<br/>CSAT HQ has been forced to adapt and has chosen to send your small platoon into the AO by boat in the hopes of avoiding any front-line casualties.
	<br/>
	<br/>You have been assigned a number of key enemy targets to disrupt enemy support and organisation for a series of infantry assaults over the coming weeks.
	<br/>
	<br/><font color='#72E500'>1.</font color> Eliminate the Officer located either at the <font color='#0080FF'><marker name='F_2'>Command Post</marker></font color> or <font color='#0080FF'><marker name='F'>Briefing Area</marker></font color>.
	<br/>
	<br/><font color='#72E500'>2.</font color> Destroy the <font color='#0080FF'><marker name='F_1'>Light Attack Helicopter</marker></font color> at the NATO Outpost.
	<br/>
	<br/><font color='#72E500'>3.</font color> Destroy the <font color='#0080FF'><marker name='F_1_1'>AA</marker></font color> vehicle somewhere South of the NATO Outpost.
	<br/>
	<br/><font color='#72E500'>4.</font color> Reach the <font color='#0080FF'><marker name='EX'>Extract</marker></font color> location.
	<br/>
	<br/>
	<br/>%1 <!--- Casualties Cap --->
	<br/><font size='18' color='#80FF00'>FRIENDLY FORCES</font>
	<br/>Your unit has been deployed by boat and begins onshore at <font color='#0080FF'><marker name='respawn_east'>Tonos Bay</marker></font color>.
	<br/>
	<br/>You will need to advance to the objectives on foot.
	<br/>
	<br/><font size='18' color='#80FF00'>ENEMY FORCES</font>
	<br/>NATO and FIA forces are present across the AO. 
	<br/>
	<br/>NATO forces are concentrated around the <font color='#0080FF'><marker name='NO'>Outpost</marker></font color>. They consist of about 15-20 infantry with motorised and mechanised supports, along with the two target objectives (<font color='#0080FF'><marker name='F_1'>Light Attack Helicopter</marker></font color> and <font color='#0080FF'><marker name='F_1_1'>AA vehicle</marker></font color>) which are likely operational.
	<br/>
	<br/>FIA forces are located around the <font color='#0080FF'><marker name='F_2'>Command Post</marker></font color>, <font color='#0080FF'><marker name='F'>Briefing Area</marker></font color> and surrounding forest. Estimated strength is between 10-15 men with HMG technical supports.
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