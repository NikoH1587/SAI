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
(count SAI_WEST_STA * 1) +
(count SAI_WEST_SUP * 1);

_force_east = 
(count SAI_EAST_INF * 1) +
(count SAI_EAST_VEH * 2) +
(count SAI_EAST_AIR * 3) +
(count SAI_EAST_ARM * 4) +
(count SAI_EAST_ART * 5) +
(count SAI_EAST_LOG * 1) +
(count SAI_EAST_STA * 1) +
(count SAI_EAST_SUP * 1);

SAI_MODE_WEST = "GAMBIT";
SAI_MODE_EAST = "GAMBIT";

if (_force_west > _force_east * 1.5) then {SAI_MODE_WEST = "ATTACK", SAI_MODE_EAST = "DEFEND"};
if (_force_east > _force_west * 1.5) then {SAI_MODE_EAST = "ATTACK", SAI_MODE_WEST = "DEFEND"};

_westX = _westX / _westG;
_westY = _westY / _westG;
_eastX = _eastX / _eastG;
_eastY = _eastY / _eastG;
_centX = (_westX + _eastX) / 2;
_centY = (_westY + _eastY) / 2;

SAI_DISTANCE = ([_westX, _westY] distance [_eastX, _eastY]) / 2;

_dirX = _eastX - _westX;
_dirY = _eastY - _westY;

_length = sqrt (_dirX^2 + _dirY^2);
_unitX = _dirX / _length;
_unitY = _dirY / _length;

_righX = _unitY;
_righY = -_unitX;
_leftX = -_unitY;
_leftY = _unitX;

"SAI_WEST" setMarkerPos [_westX, _westY];
"SAI_EAST" setMarkerPos [_eastX, _eastY];
"SAI_CENT" setMarkerPos [_centX, _centY];
"SAI_RIGH" setMarkerPos [_centX + (_righX * SAI_DISTANCE), _centY + (_righY * SAI_DISTANCE)];
"SAI_LEFT" setMarkerPos [_centX + (_leftX * SAI_DISTANCE), _centY + (_leftY * SAI_DISTANCE)];

_west_loc = position nearestLocation [getMarkerPos "SAI_WEST", ""];
_east_loc = position nearestLocation [getMarkerPos "SAI_EAST", ""];
_cent_loc = position nearestLocation [getMarkerPos "SAI_CENT", ""];
_righ_loc = position nearestLocation [getMarkerPos "SAI_RIGH", ""];
_left_loc = position nearestLocation [getMarkerPos "SAI_LEFT", ""];

if (_west_loc in [_east_loc, _cent_loc, _righ_loc, _left_loc] == false) then {"SAI_WEST" setMarkerPos _west_loc};
if (_east_loc in [_west_loc, _cent_loc, _righ_loc, _left_loc] == false) then {"SAI_EAST" setMarkerPos _east_loc};
if (_cent_loc in [_west_loc, _east_loc, _righ_loc, _left_loc] == false) then {"SAI_CENT" setMarkerPos _cent_loc};
if (_righ_loc in [_west_loc, _east_loc, _cent_loc, _left_loc] == false) then {"SAI_RIGH" setMarkerPos _righ_loc};
if (_left_loc in [_west_loc, _east_loc, _cent_loc, _righ_loc] == false) then {"SAI_LEFT" setMarkerPos _left_loc};

if (SAI_DEBUG) then {
	"SAI_WEST" setMarkerText SAI_MODE_WEST + " " + str _force_west;
	"SAI_EAST" setMarkerText SAI_MODE_EAST + " " + str _force_east;
};
