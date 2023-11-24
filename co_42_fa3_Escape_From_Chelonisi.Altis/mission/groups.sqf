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
	["GrpOFIA_CO","CO","o_hq","CO",_opfor]
	,["GrpOFIA_ASL","Alpha SL","o_inf","ASL",_opfor]
	,["GrpOFIA_A1","Alpha 1","o_inf","A1",_opfor]
	,["GrpOFIA_A2","Alpha 2","o_inf","A2",_opfor]
	,["GrpOFIA_IFV1","IFV1","o_mech_inf","I1",_opfor]
	,["GrpOFIA_PSL","Prisoner Lead","o_inf","PL",_opfor]
	,["GrpOFIA_PG1","Prisoner 1","o_inf","P1",_opfor]
	,["GrpOFIA_PG2","Prisoner 2","o_inf","P2",_opfor]
	,["GrpOFIA_PG3","Prisoner 3","o_inf","P3",_opfor]
	,["GrpOFIA_PG4","Prisoner 4","o_inf","P4",_opfor]
];