

snowS = "#particlesource" createVehicleLocal getpos player;
snowS setParticleCircle [0, [0, 0, 0]];
snowS setParticleRandom [0, [40, 40, 5], [10, 10, 1], 2, 0.025, [0, 0, 0, 0], 0, 0];
snowS setParticleParams [["\A3\data_f\ParticleEffects\Universal\Universal", 16, 12, 16,0], "", "Billboard", 1, 10, [0, 0, 6], [0, 0, -12], 0, 1, .6, .3, [.07], [[1, 1, 1, .4]], [1000], 1, 0, "", "", snowS];
snowS setDropInterval 0.0005;

addMissionEventHandler ["EachFrame",{snowS setPosATL getPosATL player}];

dc_fnc_coldBreath = {
	if (hasInterface) then {
		while {alive _this} do {
					sleep (4*(1 - getFatigue _this) + random 1);
					if (_this distance player < 300) then {
						drop [["\A3\data_f\ParticleEffects\Universal\Universal", 16, 12, 8,1], "", "Billboard", 1,
							 (1-((vectorMagnitude velocity _this) / 35)) *.75 max .05,
							 _this selectionPosition "Head" vectorAdd [0,.02,0],
							 velocityModelSpace _this vectorAdd [0, .1, 0], 1, 1.3, 1, .01, [.1,.25,.33,.4], [[1, 1, 1, .5],[1, 1, 1, 0]], [1], 1, 0, "", "", _this];
						drop [["\A3\data_f\ParticleEffects\Universal\Universal", 16, 12, 8,1], "", "Billboard", 1,
							(1-((vectorMagnitude velocity _this) / 35)) *.75 max .05,
							_this selectionPosition "Head" vectorAdd [0,.02,0],
							velocityModelSpace _this vectorAdd [0, .15, 0], 1, 1.3, 1, .01, [.1,.22,.3,.35], [[1, 1, 1, .5],[1, 1, 1, 0]], [1], 1, 0, "", "", _this];
					};
		};
	};
};

{
	_x spawn dc_fnc_coldBreath;
} forEach allUnits;

[] spawn {
	while {true} do {
		sleep .3 + random 1;
		_nearbyPos = [(position player select 0) - 200 + random 400,(position player select 1) - 200 + random 400,0];
		_vel = [3-random 6, 3-random 6, random 2];
		for "_i" from 1 to 3 do {
		drop [["\A3\data_f\ParticleEffects\Universal\Universal", 16, 12, 1,1], "", "Billboard", 1, 8, player worldToModel _nearbyPos, _vel vectorAdd [3-random 1.5, 3-random 1.5, .4-random .2], 5-random 10, 1.4, 1, 0, [8,10], [[1,1,1,0],[1, 1, 1, .2],[1, 1, 1, 0]], [1], 1, 0, "", "", player];
		};
	};
};

_height = .2;
_gridsize = 9;
_radius = 250;


_ppos = getPosATL player;
_ppos = [(_ppos select 0) - ((_ppos select 0) % _gridsize),(_ppos select 1) - ((_ppos select 1) % _gridsize),0];
_radiusg = floor (_radius / _gridsize);
_texts = [];

// [_ppos,_xx,_yy,_textures
_fncUpdatePos = {
	params ["_centerPos","_xx","_yy","_textures","_gridsize","_height"];

	_pos = _centerPos vectorAdd [_xx*_gridsize,_yy*_gridsize,0];
	_points = [ATLToASL [(_pos select 0) - 5,(_pos select 1) - 5,_height],
			   ATLToASL [(_pos select 0) + 5,(_pos select 1) - 5,_height],
			   ATLToASL [(_pos select 0) - 5,(_pos select 1) + 5,_height],
			   ATLToASL [(_pos select 0) + 5,(_pos select 1) + 5,_height]];

	_textures select 0 setPosASL (((_points select 0) vectorAdd (_points select 3)) vectorMultiply .5);
	_textures select 0 setVectorDirAndUp [(_points select 0 vectorDiff (_points select 1)) vectorCrossProduct (_points select 3 vectorDiff (_points select 1)),
							  _points select 1 vectorDiff (_points select 3)];
	_textures select 1 setPosASL (((_points select 0) vectorAdd (_points select 3)) vectorMultiply .5);
	_textures select 1 setVectorDirAndUp [(_points select 3 vectorDiff (_points select 2)) vectorCrossProduct (_points select 0 vectorDiff (_points select 2)),
							  _points select 1 vectorDiff (_points select 3)];

};
for "_i" from 0 to 2*_radiusg do {
	_texts pushBack [];
	_texts select _i resize (2*_radiusg);
};
for "_xx" from -_radiusg to _radiusg do {
	for "_yy" from -_radiusg to _radiusg do {
		if (_xx^2 + _yy^2 <= _radiusg^2) then {
			_text1 = "UserTexture10m_F" createVehicleLocal [0,0,0];
			_text1 setObjectTexture [0,"snow1.paa"];
			_text2 = "UserTexture10m_F" createVehicleLocal [0,0,0];
			_text2 setObjectTexture [0,"snow2.paa"];
									  
			[_ppos,_xx,_yy,[_text1,_text2],_gridsize,_height] call _fncUpdatePos;
									  
			_texts select (_radiusg + _xx) set [(_radiusg + _yy),[_text1,_text2]];
		};
	};
};


_newArray = [];
for "_i" from 0 to 2*_radiusg do {
	_newArray pushBack [];
	_newArray select _i resize (2*_radiusg);
};
while {true} do {
	sleep .5;
	_pposnew = getPosATL player;
	_pposnew = [(_pposnew select 0) - ((_pposnew select 0) % _gridsize),(_pposnew select 1) - ((_pposnew select 1) % _gridsize),0];
	_diff = _pposnew vectorDiff _ppos;
	_diff = [round ((_diff select 0) / _gridSize),round ((_diff select 1) / _gridSize)];
	
	if (_diff select 0 != 0 || _diff select 1 != 0) then {
		//systemChat format ["%1,%2",_diff,_pposnew];
	
		for "_xx" from 0 to 2*_radiusg do {
			for "_yy" from 0 to 2*_radiusg do {
				if ((_xx-_radiusg)^2 + (_yy-_radiusg)^2 <= _radiusg^2) then { // we're in the circle, oh boy
					if ((_xx - _radiusg - (_diff select 0))^2 + (_yy - _radiusg - (_diff select 1))^2 <= _radiusg^2) then {
						// point doesn't have to move, update position in array
						_newArray select (_xx - (_diff select 0)) set [_yy - (_diff select 1),_texts select _xx select _yy];
					} else {
						// point will move symmetrically across center point
						_newPos = [2*_radiusg - _xx,2*_radiusg - _yy];
						_currTexts = _texts select _xx select _yy;
						_newArray select (_newPos select 0) set [_newPos select 1,_currTexts];
						[_pposnew,(_newPos select 0)-_radiusg,(_newPos select 1)-_radiusg,_currTexts,_gridsize,_height] call _fncUpdatePos;
					};
				};
			};
		};
		_temp = _texts;
		_texts = _newArray;
		_newArray = _temp;
	};
	
	/*
	// debug - shows current state of array (sorta)
	_str = "";
	for "_yy" from 2*_radiusg to 0 step -1  do { for "_xx" from 0 to 2*_radiusg do {
		_str = _str + format ["%1 ",if (isNil {_texts select _xx select _yy}) then {"_"} else {"o"}];
	}; _str = _str + "\n"};
	hint _str;
	*/

	_ppos = _pposnew;
};

