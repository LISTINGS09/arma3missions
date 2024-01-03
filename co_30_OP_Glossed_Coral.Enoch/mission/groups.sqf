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
	["GrpOPF_CO","Commander","b_hq","CO",_opfor]
	,["GrpOPF_ASL","Alpha","b_inf","A",_opfor]
	,["GrpOPF_BSL","Bravo","b_inf","B",_opfor]
	,["GrpOPF_IFV1","IFV1","b_mech_inf","IFV1",_opfor]
	,["GrpOPF_IFV2","IFV2","b_mech_inf","IFV2",_opfor]
	,["GrpOPF_TNK1","Thunder1","b_armor","THU1",_opfor]
	,["GrpOPF_TNK2","Thunder2","b_armor","THU2",_opfor]
];