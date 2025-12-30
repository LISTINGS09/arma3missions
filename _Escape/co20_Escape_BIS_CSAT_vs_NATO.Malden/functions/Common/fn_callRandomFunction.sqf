params["_params","_functions",["_spawn",false]];
private _function = selectRandom _functions;

_params call (missionNameSpace getVariable _function);
