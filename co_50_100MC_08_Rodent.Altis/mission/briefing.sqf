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
	<br/>Hunt down the last remaining MBT located somewhere inside <marker name='O'>Ionannia</marker>, clearing all enemy contact as you progress.
	<br/>
	<br/>The approach to Ionannia is a difficult one with much open terrain, move carefully.
	<br/>
	<br/>Once the asset is neutralised and Ionannia is secure, you will be allowed to extract.
	<br/>
	<br/>%1 <!--- Casualties Cap --->
	<br/><font size='18' color='#80FF00'>SPECIAL TASKS</font>
	<br/>The AAF appear to have deployed a minefield to the West of Ionannia, you are advised to avoid it at all costs.
	<br/>
	<br/>Local FIA agents have highlighted certain AAF contacts on your map, these shaded grids should be cleared of enemy presence in order to secure the town.
	<br/>
	<br/><font size='18' color='#80FF00'>FRIENDLY FORCES</font>
	<br/>One platoon of up to five squads; Alpha, Bravo, Charlie, Delta and Echo.
	<br/>
	<br/>You begin at a <marker name='respawn_west'>FIA Camp</marker> and must proceed to your objective on foot.
	<br/>
	<br/><font size='18' color='#80FF00'>ENEMY FORCES</font>
	<br/>The enemy is well trained and highly motivated, they are under increasing pressure not to lose any further ground to our forces. Expect contacts to be hiding in any built-up areas found within the AO.
	<br/>
	<br/>Your first threat is most likely to be the minefield to the West of Ionannia. The town itself will be home to a number of infantry squads. At least one supporting IFV and static emplacements will be present and covering any routes into the town.
	<br/>
	<br/>The tank sustained moderate damage in its previous engagement with Zulu. It is unlikely to be repaired and put into action before we can capture the town.
	<br/>
	<br/>The following units are known to be operational in the AO:
	<br/>%2%3
	<br/><font size='18' color='#80FF00'>BACKGROUND</font>
	<br/>The FIA forces have been engaging the AAF forces recently in a number of small 'Hit and Run' attacks across the North-Western side of Altis. 
	<br/>
	<br/>In one such operation, Zulu group were tasked with taking out an AAF Tank company stationed at a nearby enemy base. 
	<br/>
	<br/>Zulu were able to eliminate the majority of the armour before pulling back, however a one of the enemy assets was able to retreat during the battle. 
	<br/>
	<br/>Your platoon has been ordered to move out and eliminate the remaining armour asset undergoing repairs somewhere in the town of <marker name='O'>Ionannia</marker>.
	<br/>
	<br/>The AAF has often used this town as a rearm and repair point for their vehicles, the elimination of the tank and capture of Ionannia will offer us a real advantage in returning Altis back to the hands of FIA and its people.
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
