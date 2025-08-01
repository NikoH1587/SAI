SAI_WEST_ENEMIES = [];
SAI_WEST_REC = [];
SAI_WEST_DEF = [];
SAI_WEST_QRF = [];

SAI_EAST_ENEMIES = [];
SAI_EAST_REC = [];
SAI_EAST_DEF = [];
SAI_EAST_QRF = [];

{
	if ((SAI_WEST knowsAbout _x) > 0 && (side _x == SAI_EAST) && alive _x) then {
		SAI_WEST_ENEMIES append [_x];
		private _grp = group _x;
		private _idx = groupId _grp;
		private _mrk = format ["SAI_EAST_%1", _idx];
		if (markerAlpha _mrk == 0) then {
			_mrk setMarkerAlpha 1;
		};
	};
	
	if ((SAI_EAST knowsAbout _x) > 0 && (side _x == SAI_WEST) && alive _x) then {
		SAI_WEST_ENEMIES append [_x];
	};
}forEach allUnits;

/// make this better later
/// make select 1 from each type to do one thing?
/// like if 3 armors, 1 recon, 1 qrf and 1 in reserve
private _west = SAI_WEST_ARM + SAI_WEST_MOT + SAI_WEST_MEC + SAI_WEST_INF + SAI_WEST_HEL;
private _east = SAI_EAST_ARM + SAI_EAST_MOT + SAI_EAST_MEC + SAI_EAST_INF + SAI_EAST_HEL;

private _modw = ceil (count _west)/3;
private _mode = ceil (count _east)/3;

SAI_WEST_REC append (_west select [0, _modw]);
private _west = _west - SAI_WEST_REC;
SAI_WEST_QRF append (_west select [0, _modw]);
private _west = _west - SAI_WEST_QRF;
SAI_WEST_DEF append _west;

SAI_EAST_REC append (_east select [0, _mode]);
private _east = _east - SAI_EAST_REC;
SAI_EAST_QRF append (_east select [0, _mode]);
private _east = _east - SAI_EAST_QRF;
SAI_EAST_DEF append _east;