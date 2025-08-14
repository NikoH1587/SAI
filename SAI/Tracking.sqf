SAI_MARKERS_WEST = allMapmarkers select {_x find "SAI_WEST_" == 0};
SAI_MARKERS_EAST = allMapmarkers select {_x find "SAI_EAST_" == 0};

/// remove SAI_CENT?

/// WEST
private _markersWest = [];
_westX = 0;
_westY = 0;
_westC = 0;
{
	private _grp = _x select 0;
	private _typ = _x select 1;
	private _pos = _x select 2;
	private _posX = _pos select 0;
	private _posY = _pos select 1;
	_westX = _westX + _posX;
	_westY = _westY + _posY;
	_westC = _westC + 1;
	private _idx = groupId _grp;
	private _mrk = format ["SAI_WEST_%1", _idx];
	_markersWest append [_mrk];
	
	if !(_mrk in SAI_MARKERS_WEST) then {
		_mrk = createMarker [_mrk, _pos];
	} else {
		_mrk setMarkerPos _pos;
		if (markerAlpha _mrk == 0.5) then {
			_mrk setMarkerColor "Default";
			_mrk setMarkerAlpha 1;
		}
	};
	
	private _smt = "mil_dot";
	if (_typ == "INF") then {_smt = "b_inf"};
	if (_typ == "MOT") then {_smt = "b_motor_inf"};
	if (_typ == "MEC") then {_smt = "b_mech_inf"};
	if (_typ == "ARM") then {_smt = "b_armor"};
	if (_typ == "PLA") then {_smt = "b_plane"};
	if (_typ == "HEL") then {_smt = "b_air"};
	if (_typ == "LOG") then {_smt = "b_unknown"};
	if (_typ == "SUP") then {_smt = "b_support"};
	if (_typ == "STA") then {_smt = "b_installation"};
	if (_typ == "ART") then {_smt = "b_art"};
	if (_typ == "UAV") then {_smt = "b_uav"};
	if (markerType _mrk != _smt) then {
		_mrk setMarkerType _smt;
	};
}forEach SAI_WEST_ALL;

_westX = _westX / _westC;
_westY = _westY / _westC;

SAI_CENTER_WEST = [_westX, _westY];

{
	if (_x in _markersWest == false && markerAlpha _x != 0.5) then {
		_x setMarkerColor "ColorBLACK";
		_x setMarkerAlpha 0.5;
	};
}forEach SAI_MARKERS_WEST;

/// EAST
private _markersEast = [];
_eastX = 0;
_eastY = 0;
_eastC = 0;
{
	private _grp = _x select 0;
	private _typ = _x select 1;
	private _pos = _x select 2;
	private _posX = _pos select 0;
	private _posY = _pos select 1;
	_eastX = _eastX + _posX;
	_eastY = _eastY + _posY;
	_eastC = _eastC + 1;
	private _idx = groupId _grp;
	private _mrk = format ["SAI_EAST_%1", _idx];
	_markersEast append [_mrk];
	
	if !(_mrk in SAI_MARKERS_WEST) then {
		_mrk = createMarker [_mrk, _pos];
		_mrk setMarkerAlpha 0;
	} else {
		_mrk setMarkerPos _pos;
		if (markerAlpha _mrk == 0.5) then {
			_mrk setMarkerColor "Default";
			_mrk setMarkerAlpha 1;
		}
	};
	
	private _smt = "mil_dot";
	if (_typ == "INF") then {_smt = "o_inf"};
	if (_typ == "MOT") then {_smt = "o_motor_inf"};
	if (_typ == "MEC") then {_smt = "o_mech_inf"};
	if (_typ == "ARM") then {_smt = "o_armor"};
	if (_typ == "PLA") then {_smt = "o_plane"};
	if (_typ == "HEL") then {_smt = "o_air"};
	if (_typ == "LOG") then {_smt = "o_unknown"};
	if (_typ == "SUP") then {_smt = "o_support"};
	if (_typ == "STA") then {_smt = "o_installation"};
	if (_typ == "ART") then {_smt = "o_art"};
	if (_typ == "UAV") then {_smt = "o_uav"};
	if (markerType _mrk != _smt) then {
		_mrk setMarkerType _smt;
	};
}forEach SAI_EAST_ALL;

_eastX = _eastX / _eastC;
_eastY = _eastY / _eastC;

SAI_CENTER_EAST = [_eastX, _eastY];

{
	if (_x in _markersEast == false && markerAlpha _x != 0.5) then {
		_x setMarkerColor "ColorBLACK";
		_x setMarkerAlpha 0.5;
	};
}forEach SAI_MARKERS_EAST;