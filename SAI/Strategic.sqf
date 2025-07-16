SAI_WEST_ALL = [];
SAI_EAST_ALL = [];
_westX = 0;
_westY = 0;
_eastX = 0;
_eastY = 0;

{
	_leader = leader _x;
	_side = side _leader;
	_pos = getPos _leader;
	_posX = _pos select 0;
	_posY = _pos select 1;
	if (_side == SAI_WEST) then {SAI_WEST_ALL append [_x]; _westX = _westX + _posX; _westY = _westY + _posY};
	if (_side == SAI_EAST) then {SAI_EAST_ALL append [_x]; _eastX = _eastX + _posX; _eastY = _eastY + _posY};
}forEach allGroups;

_westG = count SAI_WEST_ALL;
_eastG = count SAI_EAST_ALL;

_force_west = 
(count SAI_WEST_INF * 1) +
(count SAI_WEST_VEH * 2) +
(count SAI_WEST_AIR * 3) +
(count SAI_WEST_ARM * 4) +
(count SAI_WEST_ART * 5) +
(count SAI_WEST_LOG * 1) +
(count SAI_WEST_SUP * 1);

_force_east = 
(count SAI_EAST_INF * 1) +
(count SAI_EAST_VEH * 2) +
(count SAI_EAST_AIR * 3) +
(count SAI_EAST_ARM * 4) +
(count SAI_EAST_ART * 5) +
(count SAI_EAST_LOG * 1) +
(count SAI_EAST_SUP * 1);

SAI_MODE_WEST = "GAMBIT";
SAI_MODE_EAST = "GAMBIT";

if (_force_west > _force_east * 1.25) then {SAI_MODE_WEST = "ATTACK", SAI_MODE_EAST = "DEFEND"};
if (_force_west < _force_east * 1.25) then {SAI_MODE_WEST = "DEFEND", SAI_MODE_EAST = "ATTACK"};

_westX = _westX / _westG;
_westY = _westY / _westG;
_eastX = _eastX / _eastG;
_eastY = _eastY / _eastG;
_centX = (_westX + _eastX) / 2;
_centY = (_westY + _eastY) / 2;

"SAI_WEST" setMarkerPos [_westX, _westY];
"SAI_EAST" setMarkerPos [_eastX, _eastY];
"SAI_CENT" setMarkerPos [_centX, _centY];

SAI_DISTANCE = ([_westX, _westY] distance [_eastX, _eastY]) / 2;

if (SAI_DEBUG) then {
	"SAI_WEST" setMarkerText SAI_MODE_WEST + str _force_west;
	"SAI_EAST" setMarkerText SAI_MODE_EAST + str _force_east;
};
