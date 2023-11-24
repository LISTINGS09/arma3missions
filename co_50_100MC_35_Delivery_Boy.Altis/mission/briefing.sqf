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
	<br/>Search the marked depots. Locate and steal an IDAP Supply Truck, bring it to the South RV.
	<br/>
	<br/>There is more the one IDAP Truck in the area, you only need to steal one.
	<br/>
	<br/>%1 <!--- Casualties Cap --->
	<br/><font size='18' color='#80FF00'>FRIENDLY FORCES</font>
	<br/>One platoon of up to five squads; Alpha, Bravo, Charlie, Delta and Echo begin on foot at <font color='#0080FF'><marker name='respawn_east'>Kavala Beach</marker></font color> having been deployed by boat.
	<br/>
	<br/>Due to the presence of mines deployed within in the AO, each squad has an assigned E.O.D specialist.
	<br/>
	<br/><font size='18' color='#80FF00'>ENEMY FORCES</font>
	<br/>The majority of enemy NATO/FIA forces can be expected to be located outside Kavala itself, to the south. Expect no contacts in Kavala. 
	<br/>
	<br/>The NATO 2nd Infantry Platoon is known to be deployed on patrol around the <font color='#0080FF'><marker name='FD'>Main NATO Depot</marker></font color>, while the depot itself remains relatively empty.
	<br/>
	<br/>Expect NATO forces to have a number of mechanised and motorised supports, static emplacements are also likely although there have been no confirmed reports of any deployed in the AO.
	<br/>
	<br/>The FIA forces have a very limited presence in this region. While their depots should only have light guards, the FIA are known to often deploy mines around the depots to keep civilians out.
	<br/>
	<br/>Minefields are known to exist along the East LOA - Markers indicate their rough positions. The possibility that other locations across the AO have also been mined cannot be ruled out.
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
	(((vehicles select { side _x getFriend side group player < 0.6 && !(_x isKindOf "staticWeapon" || _x isKindOf "static") && count crew _x > 0}) apply { "Motorised/Mechanised Vehicles" }) call BIS_fnc_consolidateArray) apply { format["%2x <font color='#00FFFF'>%1</font><br/>", _x#0, _x#1] } joinString "",
	format["%1x <font color='#00FFFF'>Infantry Groups</font><br/>", { side _x getFriend side group player < 0.6 && count units _x >= 3 && vehicle leader _x == leader _x} count allGroups]
	]]];
};
