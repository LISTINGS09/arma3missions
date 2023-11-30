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

_grpIND = [
	["GrpIND_CO","CO","n_hq","CO",_green]
	,["GrpIND_ASL","Able","n_inf","A",_green]
	,["GrpIND_BSL","Baker","n_inf","B",_green]
	,["GrpIND_IFV1","Thunder 1","n_armor","T1",_green]
	,["GrpIND_IFV2","Thunder 2","n_armor","T2",_green]
	,["GrpIND_AH1","Eagle 1","n_air","E1",_green]
	,["GrpIND_AH2","Eagle 2","n_air","E2",_green]
];