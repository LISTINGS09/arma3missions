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
	<br/><font color='#72E500'>1.</font color> Secure the <marker name='natofob'>F.O.B</marker> by eliminating all infantry there.
	<br/><font color='#72E500'>2.</font color> Reach the <marker name='RV'>Extraction Marker</marker> for exfil.
	<br/>
	<br/>%1 <!--- Casualties Cap --->
	<br/><font size='18' color='#80FF00'>FRIENDLY FORCES</font>
	<br/>One platoon of up to five squads; Alpha, Bravo, Charlie, Delta and Echo. 
	<br/>
	<br/>You begin <marker name='respawn_east'>West of Abdera</marker> and must advance onwards by foot.
	<br/>
	<br/><font size='18' color='#80FF00'>ENEMY FORCES</font>
	<br/>Enemy contact can be expected across the AO - Patrols will have occupied any nearby compounds and set up static defences to protect the airstrip.
	<br/>
	<br/>The NATO <marker name='natofob'>F.O.B</marker> itself is still under construction. At most infantry totalling three squads are expected within and around the airstrip. A number of assets are currently stationed there but NATO supplies are limited due to their recent arrival and so most assets are unlikely to be put into action.
	<br/>
	<br/>The enemy is unlikely to have any access to direct QRF supports given their recent arrival on the island, but may call in any patrols or air support around the area if the area comes under attack.
	<br/>
	<br/>The following units are known to be operational in the AO:
	<br/>%2%3
	<br/>
	<br/><font size='18' color='#80FF00'>BACKGROUND</font>
	<br/>NATO forces have recently landed at Krya Nera and occupied the nearby airstrip. 
	<br/>
	<br/>This isn't good for our Russian forces and HQ have mandated that they be removed immediately before further NATO troops can arrive to reinforce the region.
	<br/>
	<br/>NATO forces are anticipating an attack as they know we have to make a move before their main forces arrive on the island. 
	<br/>
	<br/>Unfortunately this is the only chance Russia may get, so HQ have given the order to send your platoon in.
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
