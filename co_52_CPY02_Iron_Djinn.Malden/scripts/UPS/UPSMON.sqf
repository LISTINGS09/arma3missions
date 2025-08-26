// SERVER OR HEADLESS CLIENT CHECK
//if (!isServer) exitWith {};
if (!isServer && hasInterface ) exitWith {};

if (isNil("UPSMON_INIT")) then {
	UPSMON_INIT=0;
};

if (isNil("UPSMON_Night")) then {
	UPSMON_Night = false;
};

waitUntil {UPSMON_INIT==1};

if ((count _this)<2) exitWith 
{
	if (UPSMON_Debug > 0) then {
		hint "UPSMON: Unit and marker name have to be defined!";
		diag_log text "UPSMON: Unit and marker name have to be defined!";
	};
};

//=================== Group ======================================
//================================================================

private ["_obj","_npc","_Ucthis","_grpid","_side","_grpname","_grp","_currpos","_behaviour","_formation","_speed","_members","_grptype","_areamarker","_centerpos","_centerX","_centerY","_areasize","_area","_rangeX","_rangeY","_grpmission","_spawned","_unitstypes","_respawn","_respawnpos","_respawntime","_respawndelay","_template","_issoldier","_hostility","_onroad","_shareinfos","_noveh","_fortify","_nowpType","_ambush","_radiorange","_initpos","_bldpositions","_positiontoambush","_wait","_time"];
//group or leader
_obj = _this select 0; 

if ((typeName _obj != "OBJECT" && typeName _obj != "GROUP") || IsNil "_obj" || IsNull _obj) exitWith 
{
	if (UPSMON_Debug > 0) then {
		hint "UPSMON: Unit not defined!";
		diag_log text "UPSMON: Unit not defined!";
	};
};

// Get leader
_npc = [_obj] call UPSMON_SetLeaderGrp;

if (!alive _npc) exitWith
{
	if (UPSMON_Debug > 0) then {
		diag_log text "UPSMON: Leader is dead!";
		hint "UPSMON: Leader is dead!";
	};
};

// Get parameters
_Ucthis = [_this] call UPSMON_GetParams;
			
// give this group a unique index
UPSMON_Instances = UPSMON_Instances + 1;
_grpid = UPSMON_Instances;

// group infos
_side = side _npc;
_grpname = format["%1_%2",_side,_grpid];
_grp = group _npc;
_currpos = GetposATL _npc;
_behaviour = [_npc,_Ucthis] call UPSMON_GetGroupbehaviour;
_formation = [_npc,_Ucthis] call UPSMON_GetGroupformation;
_speed = [_npc,_Ucthis] call UPSMON_GetGroupspeed;
_members = units _grp;

if (count _members == 0) then {
	hint format["UPSMON: Group %1 contains no units!",_grp];
	diag_log text format["UPSMON: Group %1 contains no units!",_grp];
};

// what type of "vehicle" is _npc ?
_grptype = [_npc] call UPSMON_grptype;

//Set EH
[_members,_Ucthis,_grpid] spawn UPSMON_SetEventhandlers;

_grp setVariable ["UPSMON_Ucthis", _Ucthis, false];
_grp setVariable ["UPSMON_grpid", _grpid, false];
_grp setVariable ["UPSMON_Origin",[_currpos,_behaviour,_speed,_formation,_members,_side]];

// == get the name of area marker ==============================================
_areamarker = _this select 1;
if (typeName _areamarker != "STRING" || isNil ("_areamarker")) exitWith 
{
	hint "UPSMON: Area marker not defined.\n(Typo, or name not enclosed in quotation marks?)";
	diag_log text "UPSMON: Area marker not defined.\n(Typo, or name not enclosed in quotation marks?)";
};

[_grp,_areamarker,_Ucthis] spawn UPSMON_SetMarkerArea;
_grp setVariable ["UPSMON_Marker", _areamarker, false];

// remember center position of area marker
_centerpos = getMarkerPos _areamarker;
_centerX = abs(_centerpos select 0);
_centerY = abs(_centerpos select 1);
_centerpos = [_centerX,_centerY];

// X/Y range of target area
_areasize = getMarkerSize _areamarker;
_rangeX = _areasize select 0;
_rangeY = _areasize select 1;
_area = abs((_rangeX * _rangeY) ^ 0.5);

// ===============================================	

if (UPSMON_Debug>0) then {
	player sideChat format["%1: New instance %2",_grpname,_grpid];
	diag_log format["%1: New instance %2",_grpname,_grpid];
}; 

//To not run all at the same time we hope to have as many seconds as id's
sleep (random 0.8);

_grpmission = "PATROL";

UPSMON_Total = UPSMON_Total + (count _members);


if (UPSMON_Debug>0 && !alive _npc) then {
	player sideChat format["%1 There is no alive members %1 %2 %3",_grpid,typeName _npc,typeOf _npc, count units _npc];
	diag_log text format["%1 There is no alive members %1 %2 %3",_grpid,typeName _npc,typeOf _npc, count units _npc];
};	

///================= Optional parameters ===================================
//Track Option
if ("TRACK" in _UCthis || UPSMON_Debug > 0) then {UPSMON_Trackednpcs pushBack _grp;};	

	// Spawn part ===================================
	//spawned for squads created in runtime
	_spawned= if ("SPAWNED" in _UCthis) then {true} else {false};
	if (_spawned) then 
	{
		//if (UPSMON_Debug>0) then {player sidechat format["%1: squad has been spawned, respawns %2",_grpid,_respawnmax]}; 	
		switch (side _grp) do 
		{
				case west:
			{ 	
				UPSMON_AllWest=UPSMON_AllWest + units _npc; 
			};
			case east:
			{  	
				UPSMON_AllEast=UPSMON_AllEast + units _npc; 
			};
			case resistance:
			{  	
				UPSMON_AllRes=UPSMON_AllRes + units _npc; 			
			};		
		};
		
		if (side _grp != civilian) then {call (compile format ["UPSMON_%1_Total = UPSMON_%1_Total + count (units _npc)",side _npc]);}; 	
	};	
	//
	_unitstypes = [_members] call UPSMON_Getmemberstype;
	_grp setVariable ["UPSMON_RESPAWNUNITS",_unitstypes];
	
	//Respawn
	_respawn = if ("RESPAWN" in _UCthis || "RESPAWN:" in _UCthis) then {true} else {false};
	_respawnpos = [_Ucthis,_npc] call UPSMON_GetRespawnpos;
	_respawntime = [_Ucthis] call UPSMON_GetRespawntime;
	_respawndelay = [_Ucthis] call UPSMON_GetRespawndelay;
	
	_grp setVariable ["UPSMON_RESPAWN",_respawn];
	_grp setVariable ["UPSMON_RESPAWNPOS",_respawnpos];
	_grp setVariable ["UPSMON_RESPAWNTIME",_respawntime];
	_grp setVariable ["UPSMON_RESPAWNDELAY",_respawndelay];
	
	//Template
	_template = ["TEMPLATE:",0,_UCthis] call UPSMON_getArg;
	[_spawned,_template,_side,_unitstypes] spawn UPSMON_SetTemplate;
	
	//Clones
	[_Ucthis,_unitstypes] spawn UPSMON_SetClones;
	//===================================================
	
// suppress fight behaviour
_isSoldier = if ("NOAI" in _UCthis || _side == CIVILIAN) then {false} else {true};
_grp setVariable ["UPSMON_NOAI",_isSoldier];

if (_side == CIVILIAN) then
{
	_hostility = ["Hostility:",0,_UCthis] call UPSMON_getArg;
	_grp setVariable ["UPSMON_GrpHostility",_hostility]
};
// create _targerpoint on the roads only (by this group)
_onroad = if ("ONROAD" in _UCthis) then {true} else {false};
_grp setVariable ["UPSMON_ONROAD",_onroad];

// Group will not throw smoke
if ("NOSMOKE" in _UCthis) then {_grp setVariable ["UPSMON_NOSMOKE",true]};

//Do group share infos ?
_shareinfos = if ("NOSHARE" in _UCthis) then {false} else {true};
_grp setVariable ["UPSMON_Shareinfos",_shareinfos];

// Group will not call artillery support
if ("NOARTILLERY" in _UCthis) then {_grp setVariable ["UPSMON_NOARTILLERY",true];};


// Squad will not leave his marker area
if ("NOFOLLOW" in _UCthis) then {_grp setVariable ["UPSMON_NOFOLLOW",true];};	
		
// do not search for vehicles (unless in fight and combat vehicles)
_noveh = if ("NOVEH" in _UCthis) then {1} else {0};	
_noveh = if ("NOVEH2" in _UCthis) then {2} else {_noveh};	// Ajout
_grp setVariable ["UPSMON_NOVEH",_noveh];

[_grp,_Ucthis] call UPSMON_SetRenfParam;

//fortify group in near places
_fortify= if ("FORTifY" in _UCthis) then {true} else {false};
_fortifyorig = if ("FORTifY" in _UCthis) then {true} else {false};

//TRANSPORT group 
if ("TRANSPORT" in _UCthis) then 
{
	_grp setVariable ["UPSMON_TRANSPORT",true];
	if (count (_grp getVariable ["UPSMON_Transportmission",[]]) == 0) then {_grp getVariable ["UPSMON_Transportmission",["WAITING",_currpos,Objnull]]};
	if (_grptype == "IsAir") then {_h1 = createVehicle ["Land_HelipadEmpty_F",_currpos, [], 0, "NONE"];};
	switch (_side) do {
		case West: {
		if (isnil "UPSMON_TRANSPORT_WEST_UNITS") then  {UPSMON_TRANSPORT_WEST_UNITS = []};
		UPSMON_TRANSPORT_WEST_UNITS pushBack _grp;		
		};
		case EAST: {
		if (isnil "UPSMON_TRANSPORT_EAST_UNITS") then  {UPSMON_TRANSPORT_EAST_UNITS = []};
		UPSMON_TRANSPORT_EAST_UNITS pushBack _grp;	
		};
		case RESISTANCE: {
		if (isnil "UPSMON_TRANSPORT_GUER_UNITS") then  {UPSMON_TRANSPORT_GUER_UNITS = []};
		UPSMON_TRANSPORT_GUER_UNITS pushBack _grp;			
		};
	};
};

//Patrol in building
if ("LANDDROP" in _UCthis) then {_grp setVariable ["UPSMON_LANDDROP",true];};

// don't make waypoints
_nowpType = if ("NOWP" in _UCthis) then {1} else { if ("NOMOVE" in _UCthis) then {1} else {0}; };
_nowpType = if ("NOWP2" in _UCthis) then {2} else {_nowpType}; 
_nowpType = if ("NOWP3" in _UCthis) then {3} else {_nowpType};
_grp setVariable ["UPSMON_NOWP",_nowpType];

//Ambush squad will no move until in combat or so close enemy
_ambush= if (("AMBUSH" in _UCthis) || ("AMBUSHDIR:" in _UCthis) || ("AMBUSH2" in _UCthis) || ("AMBUSHDIR2:" in _UCthis)) then {true} else {false};
	
// Range of AI radio so AI can call Arty or Reinforcement
_RadioRange = ["RADIORANGE:",8000,_UCthis] call UPSMON_getArg; // ajout

// set drop units at random positions
_initpos = "ORIGINAL";
if ("RANDOM" in _UCthis) then {_initpos = "RANDOM"};
if ("RANDOMUP" in _UCthis) then {_initpos = "RANDOMUP"}; 
if ("RANDOMDN" in _UCthis) then {_initpos = "RANDOMDN"};
if ("RANDOMA" in _UCthis) then {_initpos = "RANDOMA"};
// don't position groups or vehicles on rooftops
if ((_initpos!="ORIGINAL") && (_grptype != "IsMan")) then {_initpos="RANDOM"};




//=================================================================================
//==============	initialization Random / Ambush / Fortify ======================

// make start position random 
if (_initpos!="ORIGINAL") then 
{
	// find a random position (try a max of 20 positions)
	_try=0;
	_bldpositions = [];
	_currPos = [];
	_range = _rangeX;
	if (_rangeX < _rangeY) then {_range = _rangeY};
	
	if (_initpos=="RANDOM") then
	{
		while {_try<20} do 
		{
			if (_grptype == "Isboat" || _grptype == "Isdiver") then 
			{
				_currPos = [_areamarker,2,[],1] call UPSMON_pos;
			} 
			else 
			{
				_currPos=[_areamarker,0,[],1] call UPSMON_pos;
			};
		
			if (count _currPos > 0) then {_try=99};
			_try=_try+1;
			sleep .01;
		};
	}
	else
	{
		//(_initpos=="RANDOMUP") || (_initpos=="RANDOMDN") || (_initpos=="RANDOMA")
		_bldpositions = [[_centerX,_centerY,0],_initpos,_range,_areamarker,true] call UPSMON_GetNearestBuildings;
	};
		
	if (count _bldpositions == 0) then 
	{
		if (count _currPos == 0) then {_currPos = getPosATL _npc;};
		{ //man
			if (vehicle _x == _x) then 
			{
				_targetpos = _currPos findEmptyPosition [0, 50];
				sleep .05;						
				if (count _targetpos == 0) then {_targetpos = _currpos};
				_x setpos _targetpos;	
			}
			else
			{
				_targetpos = [];
				if (_grptype != "Isboat") then {_targetpos = _currPos findEmptyPosition [10,50];};
				sleep .05;						
				if (count _targetpos == 0) then {_targetpos = _currpos};
				_x setPos _targetpos;		
			};
		} forEach units _npc; 
	} 
	else 
	{
		// put the unit on top of a building
		_units = [units _npc] call UPSMON_getunits;
		_grpmission = "STATIC";
		if (_nowpType == 3) then 
		{
			_unitsin = [_npc,["static"],_range,true,_areamarker] call UPSMON_GetIn_NearestVehicles;
			_units = _units - _unitsin;
			_grpmission = "FORTifY";
			[_grp,[0,0],"HOLD","LINE","LIMITED","AWARE","YELLOW",1] call UPSMON_DocreateWP;
		}
		else
		{
			_nowpType = 1; // don't move if on roof
		};
		if (count _units > 0) then {_units = [_units,_bldpositions] call UPSMON_SpawninBuildings;};
		_currPos = getPosATL _npc;		
	};
};

_combatmode = "YELLOW";
// AMBUSH
if (_ambush) then 
{
	[_grp,[0,0],"HOLD","LINE","LIMITED","STEALTH","BLUE",1] call UPSMON_DocreateWP;
	_grp setVariable ["UPSMON_AMBUSHFIRE",false];
		
	{
		if !(isNil "bdetect_enable") then {_x setVariable ["bcombat_task", [ "", "mydummytask", 100, [] ] ];};
	} forEach units _npc;
	_positiontoambush = [_grp,_Ucthis,_currpos] call UPSMON_getAmbushpos;
	_grpmission = "AMBUSH";
	_grp setVariable ["UPSMON_Positiontoambush",_positiontoambush];
	_wait = ["AMBUSHWAIT:",500,_UCthis] call UPSMON_getArg;
	_time = time + _wait;
	_grp setVariable ["UPSMON_AMBUSHWAIT",_time];
	_linkdistance = ["LINKED:",0,_UCthis] call UPSMON_getArg;
	_grp setVariable ["UPSMON_LINKED",_linkdistance];
	
	_Behaviour = "STEALTH";
	_combatmode = "BLUE";
};

if (_fortify) then 
{			
	[_grp,[0,0],"HOLD","LINE","LIMITED","AWARE","YELLOW",1] call UPSMON_DocreateWP;
	_unitsin = [_npc,["static"],50,false,""] call UPSMON_GetIn_NearestVehicles;
	_units = (units _grp) - _unitsin;
	if ( count _units > 0 ) then 
	{
		_units = [_npc,_units,70,9999] call UPSMON_moveNearestBuildings;
		if (count _units > 0) then 
		{
			_lookpos = [getposATL _npc,getDir _npc, 20] call UPSMON_GetPos2D;
			[getposATL _npc,_lookpos,50,false,_units] call UPSMON_fnc_find_cover;
		};

	};
	_grpmission = "FORTifY";
};

if ("RELAX" in _Ucthis) then {_grpmission = "RELAX";_nowtype = 2;};

if (_nowpType > 0 && _grpmission != "FORTifY") then {_grpmission = "STATIC"};

{_x allowfleeing 0;} forEach units _grp;
_grp enableAttack false;
_npc setbehaviour _Behaviour;
_npc setspeedmode _speed;
_grp setformation _formation;
_grp setcombatmode _combatmode;

// did the leader die?
_npc = [_npc,_grp] call UPSMON_getleader;							
if (!alive _npc || !canMove _npc || isplayer _npc ) exitWith {};

_grp setVariable ["UPSMON_GrpStatus","GREEN"];
_grp setVariable ["UPSMON_GrpMission",_grpmission];
_grp setVariable ["UPSMON_OrgGrpMission",_grpmission];
_grp setVariable ["UPSMON_Lastinfos",[[0,0,0],[0,0,0]]];
_grp setVariable ["UPSMON_NOWP",_nowpType];
_grp setVariable ["UPSMON_Removegroup",false];

//Assign the current group in the array of UPSMON Groups
if (_side != civilian) then
{
	if (!(_grp in UPSMON_NPCs)) then {UPSMON_NPCs pushBack _grp;};
}
else
{
	if (!(_grp in UPSMON_Civs)) then {UPSMON_Civs pushBack _grp;};
};
