// Array of all groups that need IDs/Markers.
// FORMAT: [groupID,groupName,markerType,markerName,markerColor]
// * Don't change the names of the variables - anything beginning with '_'!
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

// Group Variable Name, ORBAT Name, Icon Type, Icon Text, Icon Color, Make Channel (default true)

_grpBLU = [
	["GrpBLU_CO","CO","b_hq","CO",_yellow],
	["GrpBLU_DC","JTAC","b_hq","J",_yellow],
	["GrpBLU_ASL","Alpha","b_inf","A",_blue],
	["GrpBLU_BSL","Bravo","b_inf","B",_blue],
	["GrpBLU_CSL","Charlie","b_inf","C",_blue],
	["GrpBLU_DSL","Delta","b_inf","D",_blue],
	["GrpBLU_ESL","Echo","b_inf","E",_blue],
	["GrpBLU_TH1","Vector1","b_air","V1",_orange],
	["GrpBLU_TH2","Vector2","b_air","V2",_orange],
	["GrpBLU_TH3","Vector3","b_air","V3",_orange],
	["GrpBLU_TH4","Vector4","b_air","V4",_orange],
	["GrpBLU_TH5","Vector5","b_air","V5",_orange]
	// Always make sure there's no comma after the last entry!
];