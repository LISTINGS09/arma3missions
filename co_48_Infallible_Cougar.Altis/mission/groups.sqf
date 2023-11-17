// Array of all groups that need IDs/Markers.
// FORMAT: [groupIDVariable,groupName,markerType,markerName,markerColor,createChannelGroup]
// * Markers are NEVER shared between sides.
// * You can edit the RGBA values to change the colours.
// * You can delete any groups you're not using (e.g. remove '_grpBLU = [ ... ];' if you're OPFOR).
// ====================================================================================
private ["_red", "_blue", "_green", "_yellow", "_orange", "_purple", "_black", "_white"];
_red = 		[1,   0,   0,   1	];
_blue = 	[0,   0,   1,   1	];
_green = 	[0,   0.5, 0,   1	];
_yellow = 	[1,   1,   0,   1	];
_orange = 	[1,   0.6, 0,   1	];
_purple	=	[0.5, 0,   0.5, 1 	];
_black =	[0,   0,   0,   1	];
_white =	[1,   1,   1,   1	];

_grpBLU = [
	["GrpBLU_CO","CO","b_hq","CO",_yellow]
	,["GrpBLU_ASL","Alpha","b_inf","A",_red]
	,["GrpBLU_BSL","Bravo","b_inf","B",_blue]
	,["GrpBLU_CSL","Charlie","b_inf","C",_green]
	,["GrpBLU_ST1","Recon","b_recon","R",_white]
	,["GrpBLU_MMG1","MMG1","b_support","MG1",_orange]
	,["GrpBLU_MMG2","MMG2","b_support","MG2",_orange]
	,["GrpBLU_MAT1","MAT1","b_motor_inf","AT1",_purple]
	,["GrpBLU_MAT2","MAT2","b_motor_inf","AT2",_purple]
	,["GrpBLU_MTR1","MTR","b_mortar","MTR",_white]
];