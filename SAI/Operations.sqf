SAI_WEST_OBJECTIVE = "SAI_CENT";
SAI_EAST_OBJECTIVE = "SAI_CENT";
if (SAI_MODE_WEST == "ATTACK") then {SAI_WEST_OBJECTIVE = "SAI_EAST"};
if (SAI_MODE_WEST == "DEFEND") then {SAI_WEST_OBJECTIVE = "SAI_WEST"};
if (SAI_MODE_EAST == "ATTACK") then {SAI_EAST_OBJECTIVE = "SAI_WEST"};
if (SAI_MODE_EAST == "DEFEND") then {SAI_EAST_OBJECTIVE = "SAI_EAST"};

SAI_WEST_ENEMIES = [];
SAI_WEST_REC = [];
SAI_WEST_DEF = [];
SAI_EAST_QRF = [];

SAI_EAST_ENEMIES = [];
SAI_EAST_REC = [];
SAI_EAST_DEF = [];
SAI_EAST_QRF = [];

{
	if ((SAI_WEST knowsAbout _x) == 4 && (side _x == SAI_EAST)) then {
		SAI_WEST_ENEMIES append [_x];
	};
	
	if ((SAI_EAST knowsAbout _x) == 4 && (side _x == SAI_WEST)) then {
		SAI_EAST_ENEMIES append [_x];
	};
}forEach allUnits;

_west = SAI_WEST_INF + SAI_WEST_VEH + SAI_WEST_ARM;
_east = SAI_EAST_INF + SAI_EAST_VEH + SAI_EAST_ARM;

{
	_modw = (count _west)/3;
	_mode = (count _east)/3;
	if (count SAI_WEST_DEF < _modw && _x in SAI_WEST_INF) then {SAI_WEST_DEF append [_x]; _west = _west - [_x]};
	if (count SAI_WEST_REC < _modw && _x in SAI_WEST_VEH) then {SAI_WEST_REC append [_x]; _west = _west - [_x]};
	if (count SAI_WEST_QRF < _modw && _x in SAI_WEST_ARM) then {SAI_WEST_QRF append [_x]; _west = _west - [_x]};
	if (count SAI_EAST_DEF < _mode && _x in SAI_EAST_INF) then {SAI_EAST_DEF append [_x]; _east = _east - [_x]};
	if (count SAI_EAST_REC < _mode && _x in SAI_EAST_VEH) then {SAI_EAST_REC append [_x]; _east = _east - [_x]};
	if (count SAI_EAST_QRF < _mode && _x in SAI_EAST_ARM) then {SAI_EAST_QRF append [_x]; _east = _east - [_x]};
}forEach (SAI_WEST_ALL + SAI_EAST_ALL);

{
	_modw = (count _west)/3;
	_mode = (count _east)/3;
	if (count SAI_WEST_DEF < _modw && _x in SAI_WEST_INF) then {SAI_WEST_DEF append [_x]; _west = _west - [_x]};
	if (count SAI_WEST_REC < _modw && _x in SAI_WEST_VEH) then {SAI_WEST_REC append [_x]; _west = _west - [_x]};
	if (count SAI_WEST_QRF < _modw && _x in SAI_WEST_ARM) then {SAI_WEST_QRF append [_x]; _west = _west - [_x]};
	if (count SAI_EAST_DEF < _mode && _x in SAI_EAST_INF) then {SAI_EAST_DEF append [_x]; _east = _east - [_x]};
	if (count SAI_EAST_REC < _mode && _x in SAI_EAST_VEH) then {SAI_EAST_REC append [_x]; _east = _east - [_x]};
	if (count SAI_EAST_QRF < _mode && _x in SAI_EAST_ARM) then {SAI_EAST_QRF append [_x]; _east = _east - [_x]};
}forEach (SAI_WEST_ALL + SAI_EAST_ALL);