SAI_SPAWNS = allMapMarkers select {(_x find "SAI_SPAWN_" == 0) && (markerAlpha _x == 1)};

_allwest = [];
_alleast = [];

{
	_type = getMarkerType _x;
	if (_type in ["b_motor_inf", "b_mech_inf", "b_recon", "b_support", "b_unknown"]) then {_allwest append [_x]};
	if (_type in ["o_motor_inf", "o_mech_inf", "o_recon", "o_support", "o_unknown"]) then {_alleast append [_x]};
}forEach SAI_SPAWNS;

_west = _allwest select floor random count _allwest;
_east = _alleast select floor random count _alleast;

_westX = (getMarkerPos _west) select 0;
_westY = (getMarkerPos _west) select 1;
_eastX = (getMarkerPos _east) select 0;
_eastY = (getMarkerPos _east) select 1;
_centX = (_westX + _eastX) / 2;
_centY = (_westY + _eastY) / 2;

createMarker ["SAI_WEST", [_westX, _westY]];
createMarker ["SAI_EAST", [_eastX, _eastY]];
createMarker ["SAI_CENT", [_centX, _centY]];

SAI_DISTANCE = ([_westX, _westY] distance [_eastX, _eastY]) / 2;

if (SAI_DEBUG) then {
	"SAI_WEST" setMarkerType "hd_flag";
	"SAI_EAST" setMarkerType "hd_flag";
	"SAI_CENT" setMarkerType "hd_flag";
	"SAI_WEST" setMarkerColor "ColorWEST";
	"SAI_EAST" setMarkerColor "ColorEAST";
};

