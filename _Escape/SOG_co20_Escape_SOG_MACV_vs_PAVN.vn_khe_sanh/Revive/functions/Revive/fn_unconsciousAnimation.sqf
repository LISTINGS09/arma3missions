params["_unit","_anim",["_switch",true]];

diag_log ("Switching to animation "+str _anim+" for unit "+name _unit);

private _simDisabled = !(simulationenabled _unit);


if(_switch) then {
	_unit switchmove _anim;
};
_unit playmovenow _anim;

