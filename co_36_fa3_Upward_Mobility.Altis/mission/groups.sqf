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
	["GrpCSAT_CO","CO","o_hq","CO",_opfor]
	,["GrpCSAT_ASL","Alpha SL","o_inf","ASL",_opfor]
	,["GrpCSAT_A1","Alpha 1","o_inf","A1",_opfor]
	,["GrpCSAT_A2","Alpha 2","o_inf","A2",_opfor]
	,["GrpCSAT_BSL","Bravo SL","o_inf","BSL",_opfor]
	,["GrpCSAT_B1","Bravo 1","o_inf","B1",_opfor]
	,["GrpCSAT_B2","Bravo 2","o_inf","B2",_opfor]
	,["GrpCSAT_ST1","Recon","o_recon","REC",_opfor]
	,["GrpCSAT_TH1","Vector1","o_air","V1",_opfor]
	,["GrpCSAT_TH2","Vector2","o_air","V2",_opfor]
];