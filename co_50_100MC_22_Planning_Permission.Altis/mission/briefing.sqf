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
	<br/>Move out and eliminate all units at the <font color='#0080FF'><marker name='FOB'>F.O.B</marker></font color>.
	<br/>
	<br/>%1 <!--- Casualties Cap --->
	<br/><font size='18' color='#80FF00'>FRIENDLY FORCES</font>
	<br/>One platoon of infantry with up to five squads; Alpha, Bravo, Charlie, Delta and Echo. 
	<br/>
	<br/>You have been transported from Kavala to a location approximately 1KM out from the CSAT base, <font color='#0080FF'><marker name='respawn_guerrila'>here</marker></font color>.
	<br/>
	<br/><font size='18' color='#80FF00'>ENEMY FORCES</font>
	<br/>A number of infantry patrols are known to be operating in the surrounding area. Armor contacts are expected to be minimal given the steep terrain. 
	<br/>
	<br/>CSAT has been utilising air transports to bring in construction materials, tools and workers. Air traffic is expected to be high, but not a direct threat. 
	<br/>
	<br/>Since your unit currently has no AA capability you are to avoid attracting the attention of any air unit at all costs. The enemy should however have plenty of munitions in their base to deal with any AA threats, if they appear.
	<br/>
	<br/>Since CSAT has not finished fully constructing the base, HMG/Mortar supports are expected to be minimal, if any. 
	<br/>
	<br/>Any contact should only include any mechanised or motorised supports currently in the area, any QRF will be too far to respond.
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
