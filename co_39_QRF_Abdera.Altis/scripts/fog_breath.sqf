// Foggy breath 20110122

private ["_unit"];
_unit = _this select 0;
_int0 = _this select 1; //intensity of fog (0 to 1)

if !(_unit isKindOf "Man") exitWith {};

while {alive _unit} do {
	_ls = _unit getVariable "LastSpeed";
	_spd = abs (speed _unit);
	if (isNil "_ls") then {_ls = 0};
	_mpl = 1 + (_spd/10);
	if (_mpl > 1.2) then {_mpl = 1.2};
	_int = _int0 * _mpl;
	if (_int > 1) then {_int = 1};
	if ((_ls > _spd) or (_spd < 1)) then {_ls = _ls - (0.25 + (random 0.15))} else {_ls = _ls + (0.35 + (random 0.15))};
	if (_ls > 22) then {_ls = 22};
	if (_ls < 0) then {_ls = 0};
	_unit setVariable ["LastSpeed",_ls];

	waitUntil
		{
		sleep ((2 + (random 2))/(0.6 + (_ls/5))); // random time between breaths
		((_unit distance player) < 100)
		};

	_vl = velocity _unit;

	_source = "logic" createVehicleLocal (getPos _unit);
		_fog = "#particlesource" createVehicleLocal getPos _source;
		_fog setParticleParams [["\A3\data_f\ParticleEffects\Universal\Universal", 16, 12, 13,0],
		"", 
		"Billboard", 
		0.5, 
		(0.3 + (_int/2)), 
		[0,0,0],
		[_vl select 0,(_vl select 1) + 0.2,(_vl select 2) - 0.2], 
		1,1.25,1,0.75, //1,1.275,1,0.2,
		[0, (0.4 + (_int/5))], 
		[[1,1,1, _int], [1,1,1, 0.01], [1,1,1, 0]], 
		[1000], 
		1, 
		0.04, 
		"", 
		"", 
		_source];
		_fog setParticleRandom [1, [0.01, 0.01, 0.01], [0.25, 0.25, 0.25], 0, 0.5, [0, 0, 0, 0.1], 0, 0, 10];
		//_fog setDropInterval 0.01;
		
		//_fog setParticleRandom [2, [0, 0, 0], [0.25, 0.25, 0.25], 0, 0.5, [0, 0, 0, 0.1], 0, 0, 10];
		_fog setDropInterval (0.01-random(0.005)); //change drop interval for particle density 0.001 (most dense) -> .999 (least dense)

	_source attachTo [_unit,[0,0.15,0], "neck"]; // get fog to come out of player mouth

	sleep 0.5; // 1/2 second exhalation
	deleteVehicle _source;
};