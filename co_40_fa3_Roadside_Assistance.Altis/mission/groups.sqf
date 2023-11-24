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

_grpBLU = [
	["GrpNATO_CO","CO","o_hq","CO",_blufor]
	,["GrpNATO_ASL","Alpha SL","b_inf","ASL",_blufor]
	,["GrpNATO_A1","Alpha 1","b_inf","A1",_blufor]
	,["GrpNATO_A2","Alpha 2","b_inf","A2",_blufor]
	,["GrpNATO_BSL","Bravo SL","b_inf","BSL",_blufor]
	,["GrpNATO_B1","Bravo 1","b_inf","B1",_blufor]
	,["GrpNATO_B2","Bravo 2","b_inf","B2",_blufor]
	,["GrpNATO_CSL","Charlie SL","b_inf","CSL",_blufor]
	,["GrpNATO_C1","Charlie 1","b_inf","C1",_blufor]
	,["GrpNATO_C2","Charlie 2","b_inf","C2",_blufor]
	,["GrpNATO_TH1","Vector 1","b_air","V1",_blufor]
	,["GrpNATO_TH2","Vector 2","b_air","V2",_blufor]
	,["GrpNATO_AH1","Hawk","b_air","H",_blufor]
];