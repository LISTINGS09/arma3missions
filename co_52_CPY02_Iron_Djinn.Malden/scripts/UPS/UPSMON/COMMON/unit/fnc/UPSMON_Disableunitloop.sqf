/****************************************************************

****************************************************************/
private["_unit"];	

_unit = _this select 0;

waituntil {IsNull _unit || !alive _unit || !IsNull ((group _unit) getVariable ["UPSMON_target",Objnull]) || _unit getVariable ["UPSMON_SUPSTATUS",""] != "" || _unit getVariable ["UPSMON_Wait",time] <= time};

if (!IsNull _unit) then
{
	if (alive _unit) then
	{
		_unit switchmove "";
		_unit enableAI "MOVE";
		_unit setVariable ["UPSMON_Civdisable",false];		
	};
};