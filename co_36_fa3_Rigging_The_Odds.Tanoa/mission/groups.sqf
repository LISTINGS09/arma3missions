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
	["GrpAAF_CO","CO","n_hq","CO",_green]
	,["GrpAAF_ASL","Alpha SL","n_inf","ASL",_green]
	,["GrpAAF_A1","Alpha One","n_inf","A1",_green]
	,["GrpAAF_A2","Alpha Two","n_inf","A2",_green]
	,["GrpAAF_BSL","Bravo SL","n_inf","BSL",_green]
	,["GrpAAF_B1","Bravo One","n_inf","B1",_green]
	,["GrpAAF_B2","Bravo Two","n_inf","B2",_green]
	,["GrpAAF_AH1","Attack Hawk","n_air","AH",_green]
	,["GrpAAF_TH1","Transport 1","n_air","TH1",_green]
	,["GrpAAF_TH2","Transport 2","n_air","TH2",_green]
];