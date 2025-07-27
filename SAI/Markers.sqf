SAI_SPAWNS = allMapMarkers select {(_x find "SAI_SPAWN" == 0) && (markerAlpha _x == 1)};

SAI_SPAWN_WEST = [];
SAI_SPAWN_EAST = [];

{
	_type = getMarkerType _x;
	if (_type in ["b_inf","b_motor_inf","b_mech_inf","b_armor","b_support","b_art","b_air","b_installation"]) then {SAI_SPAWN_WEST append [_x]};
	if (_type in ["o_inf","o_motor_inf","o_mech_inf","o_armor","o_support","o_art","o_air","o_installation"]) then {SAI_SPAWN_EAST append [_x]};
}forEach SAI_SPAWNS;

_westX = 0;
_westY = 0;
_westC = 0;

{
	_pos = getMarkerPos _x;
	_posX = _pos select 0;
	_posY = _pos select 1;
	_westX = _westX + _posX;
	_westY = _westY + _posY;
	_westC = _westC + 1;
}forEach SAI_SPAWN_WEST;

_westX = _westX / _westC;
_westY = _westY / _westC;

_eastX = 0;
_eastY = 0;
_eastC = 0;
{
	_pos = getMarkerPos _x;
	_posX = _pos select 0;
	_posY = _pos select 1;
	_eastX = _eastX + _posX;
	_eastY = _eastY + _posY;
	_eastC = _eastC + 1;
}forEach SAI_SPAWN_EAST;

_eastX = _eastX / _eastC;
_eastY = _eastY / _eastC;

_centX = (_westX + _eastX) / 2;
_centY = (_westY + _eastY) / 2;

createMarker ["SAI_WEST", [_westX, _westY]];
createMarker ["SAI_EAST", [_eastX, _eastY]];
createMarker ["SAI_CENT", [_centX, _centY]];

SAI_DISTANCE = (([_westX, _westY] distance [_eastX, _eastY]) / 2) max 250;

if (SAI_DEBUG) then {
	"SAI_WEST" setMarkerType "hd_flag";
	"SAI_EAST" setMarkerType "hd_flag";
	"SAI_CENT" setMarkerType "hd_flag";
	"SAI_WEST" setMarkerColor "ColorWEST";
	"SAI_EAST" setMarkerColor "ColorEAST";
};

