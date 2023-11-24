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
	<br/><font color='#72E500'>1.</font color> Eliminate the NATO and FIA HVTs located at the <font color='#0080FF'><marker name='NATO_MEET'>Meeting Place</marker></font color>.
	<br/><font color='#72E500'>2.</font color> Locate the briefcase somewhere near the <font color='#0080FF'><marker name='BC'>Meeting Place</marker></font color>.
	<br/><font color='#72E500'>3.</font color> <font color='#FF7F00'>Commander</font color> to carry the briefcase to the <font color='#0080FF'><marker name='EX'>Extraction Point</marker></font color>.
	<br/>
	<br/>The targets are expeted to flee when detected.
	<br/>
	<br/>%1 <!--- Casualties Cap --->
	<br/><font size='18' color='#80FF00'>INTELLIGENCE</font>
	<br/><font size='18'>TARGET: SR. KOSTAS STAVROU</font>
	<br/>
	<br/><img image='mission\HVT2.jpg' width='200' height='200'/>
	<br/>
	<br/>FIA Leader of the North West region, armed and extremely dangerous.
	<br/>
	<br/><font size='18'>TARGET: CPT. BERNARD HAMPTON</font>
	<br/>
	<br/><img image='mission\HVT1.jpg' width='200' height='200'/>
	<br/>
	<br/>A high-ranking NATO Officer, we cannot miss the opportunity to eliminate this target.
	<br/>
	<br/><font size='18'>SATELLITE: MEETING ZONE</font>
	<br/>
	<br/><img image='mission\SAT.jpg' width='320' height='200'/>
	<br/>
	<br/>Satellite images of the area show patrols moving around the zone and static vehicles (photo is of actual objective).
	<br/>
	<br/>
	<br/><font size='18' color='#80FF00'>FRIENDLY FORCES</font>
	<br/>One platoon of up to five squads; Alpha, Bravo, Charlie, Delta and Echo. 
	<br/>
	<br/>You begin <font color='#0080FF'><marker name='respawn_east'>here</marker></font color>.
	<br/>
	<br/>A civilian transport will pick you up at the extraction point, there are no other friendly forces in the AO.
	<br/>
	<br/><font size='18' color='#80FF00'>ENEMY FORCES</font>
	<br/>One squad is present at the meeting zone itself, other NATO patrols have been spotted across the entire AO.
	<br/>
	<br/>Expect the full force of NATO when they realise you're in their territory - You are deep behind enemy lines, expect to be hunted relentlessly by NATO and FIA forces when you are detected.
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
