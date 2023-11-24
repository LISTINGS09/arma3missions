
[
/* 0 object */				_this,
/* 1 action title */			"download weapon schematic",
/* 2 idle icon */			"\a3\ui_f\data\IGUI\Cfg\simpleTasks\types\intel_ca.paa",
/* 3 progress icon */			"\a3\ui_f\data\IGUI\Cfg\simpleTasks\types\upload_ca.paa",
/* 4 condition to show */		"!intelCollected && _this distance _target < 4",
/* 5 condition for action */		"_this distance _target < 4",
/* 6 code executed on start */		{},
/* 7 code executed per tick */		{},
/* 8 code executed on completion */	{intelCollected = true; publicVariable "intelCollected"},
/* 9 code executed on interruption */	{},
/* 10 arguments */			nil,
/* 11 action duration */		15,
/* 12 priority */			6,
/* 13 remove on completion */		true,
/* 14 show unconscious */		false
] call bis_fnc_holdActionAdd;