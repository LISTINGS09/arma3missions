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
	<br/>
	Our 'friend' in the AAF has tipped us off about something big this time. Apparently, they've sized a couple hundred million in untraceable US bills from the local insurgents. A convoy carrying the cash is moving from <marker name=kavala>Kavala</marker> to <marker name=airfieldarea>Krya Nera airfield</marker>, where they'll fly it off to god-knows-where.
	<br/><br/>
	If this goes right, they'll never make it to the airfield. We'll ambush them in the mountains near Abdera, move the cash offshore, and live like kings for the rest of our lives.
	<br/>
	<br/>
	<font size='18' color='#80FF00'>COMMANDER'S INTENT</font>
	<br/>
	The convoy vehicles are going to be electronically locked, so we won't be able to drive the cash out. We'll have to take them by helicopter to the <marker name=escape>dropoff</marker>.
	<br/><br/>
	We have two military surplus Littlebirds to do the slingloading. We're expecting six boxes, so they'll have to make multiple trips. Also, those things carry less armor than their pilots, so try to keep them out of harm's way.
	<br/><br/>
	If things get too hot or we lose the helicopters, we might have to make an early escape. Just remember, the less money we get, the less money ends up in your pockets - we'll need at least three to cover our costs.
	<br/>
	1. Ambush the <marker name=indpath>convoy</marker>.<br/>
	2. Bring the money to the <marker name=escape>dropoff</marker>.<br/>
	3. <marker name=escape>Escape Altis.</marker>
	<br/><br/>
	The mission will end when all players are within ~3km of the escape point - make sure all boxes are collected before this!
	<br/>
	<br/>
	<font size='18' color='#80FF00'>ENEMY FORCES</font>
	<br/>
	The convoy should consist of three transport trucks escorted by armed vehicles and troops. We've also spotted heavy armor at <marker name=airfieldarea>the airfield</marker>. After we attack the convoy, expect an AAF reaction force from the north, west, and south.
	<br/>
	<br/>
	<font size='18' color='#80FF00'>FRIENDLY FORCES</font>
	<br/>
	<marker name=escape>A few of our comrades are holding offshore in an unregistered trawler.</marker> We've also bribed a few of the locals to leave out some dingies that we can use in our escape.
	<br/>
	<br/>
	<font size='18' color='#80FF00'>MONEY BOXES</font>
	<br/>
	The boxes of money will be strapped down to the trucks. They can be released with a scrollwheel action or by destroying the truck. Don't worry about damaging the cash, it's protected by ultra-heavy-duty cardboard armor.
	<br/><br/>
	<img image='photo.jpg'/>
	<br/>
	<br/>%1 <!--- Casualties Cap --->
	<br/><font size='18' color='#80FF00'>CREDITS</font>
	<br/>Created by <font color='#FF0080'>darkChozo</font color>
	<br/>
	<br/>A custom-made mission for ArmA 3 and Zeus Community
	<br/>http://zeus-community.net
	<br/>",
	if (f_param_CasualtiesCap > 0 && f_param_CasualtiesCap < 100) then { format["Ensure casualties are kept below %1 and %1&#37; of your force is not incapacitated.<br/>", f_param_CasualtiesCap] } else { "" }
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