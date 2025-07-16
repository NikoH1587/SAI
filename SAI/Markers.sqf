createMarker ["SAI_WEST", [0,0]];
createMarker ["SAI_EAST", [0,0]];
createMarker ["SAI_CENT", [0,0]];
createMarker ["SAI_RIGH", [0,0]];
createMarker ["SAI_LEFT", [0,0]];

if (SAI_DEBUG) then {
	"SAI_WEST" setMarkerType "hd_flag";
	"SAI_EAST" setMarkerType "hd_flag";
	"SAI_CENT" setMarkerType "hd_flag";
	"SAI_RIGH" setMarkerType "hd_flag";
	"SAI_LEFT" setMarkerType "hd_flag";
	"SAI_WEST" setMarkerColor "ColorWEST";
	"SAI_EAST" setMarkerColor "ColorEAST";
};

SAI_WEST_OBJECTIVES = [];
SAI_EAST_OBJECTIVES = [];