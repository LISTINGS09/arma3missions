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
	["GrpFIA_CO","CO","o_hq","CO",_blufor]
	,["GrpFIA_ASL","Alpha SL","b_inf","ASL",_blufor]
	,["GrpFIA_A1","Alpha 1","b_inf","A1",_blufor]
	,["GrpFIA_A2","Alpha 2","b_inf","A2",_blufor]
	,["GrpFIA_BSL","Bravo SL","b_inf","BSL",_blufor]
	,["GrpFIA_B1","Bravo 1","b_inf","B1",_blufor]
	,["GrpFIA_B2","Bravo 2","b_inf","B2",_blufor]
	,["GrpFIA_TH1","Vector1","b_air","V1",_blufor]
	,["GrpFIA_TH2","Vector2","b_air","V2",_blufor]
	,["GrpFIA_IFV1","IFV1","b_mech_inf","I1",_blufor]
	,["GrpFIA_IFV2","IFV2","b_mech_inf","I2",_blufor]
];