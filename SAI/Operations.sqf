SAI_WEST_ENEMIES = [];
SAI_WEST_REC = [];
SAI_WEST_DEF = [];
SAI_WEST_QRF = [];

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

_west = SAI_WEST_AIR + SAI_WEST_VEH + SAI_WEST_ARM + SAI_WEST_INF;
_east = SAI_EAST_AIR + SAI_EAST_VEH + SAI_EAST_ARM + SAI_EAST_INF;

_modw = ceil (count _west)/3;
_mode = ceil (count _east)/3;

SAI_WEST_REC append (_west select [0, _modw]);
_west = _west - SAI_WEST_REC;
SAI_WEST_QRF append (_west select [0, _modw]);
_west = _west - SAI_WEST_QRF;
SAI_WEST_DEF append _west;

SAI_EAST_REC append (_east select [0, _mode]);
_east = _east - SAI_EAST_REC;
SAI_EAST_QRF append (_east select [0, _mode]);
_east = _east - SAI_EAST_QRF;
SAI_EAST_DEF append _east;