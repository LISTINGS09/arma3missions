// Array of all groups that need IDs/Markers.
// FORMAT: [groupIDVariable,groupName,markerType,markerName,markerColor,createChannelGroup]
// * Markers are NEVER shared between sides.
// * You can edit the RGBA values to change the colours.
// * You can delete any groups you're not using (e.g. remove '_grpBLU = [ ... ];' if you're OPFOR).
// ====================================================================================
private ["_red", "_blue", "_green", "_yellow", "_orange", "_purple", "_black", "_white", "_blufor", "_opfor"];
_red = 		[1,   0,   0,   1	];
_blue = 	[0,   0,   1,   1	];
_green = 	[0,   0.5, 0,   1	];
_yellow = 	[1,   1,   0,   1	];
_orange = 	[1,   0.6, 0,   1	];
_purple	=	[0.5, 0,   0.5, 1 	];
_black =	[0,   0,   0,   1	];
_white =	[1,   1,   1,   1	];
_blufor = 	[0,   0.3, 0.6, 1	];
_opfor = 	[0.5, 0,   0,   1	];

_grpOPF = [
	["GrpOPF_CO","CO","o_hq","CO",_opfor]
	,["GrpOPF_ASL","Alpha","o_inf","A",_opfor]
	,["GrpOPF_BSL","Bravo","o_inf","B",_opfor]
];
