SAI_MARKERS_WEST = allMapmarkers select {_x find "SAI_WEST_" == 0};
SAI_MARKERS_EAST = allMapmarkers select {_x find "SAI_EAST_" == 0};
SAI_WEST_HQ = false;
SAI_EAST_HQ = false;
/// remove SAI_CENT?

/// WEST
private _markersWest = [];
{
	private _grp = _x select 0;
	private _typ = _x select 1;
	private _pos = getpos leader _grp;
	private _idx = groupId _grp;
	private _mrk = format ["SAI_WEST_%1", _idx];
	_markersWest append [_mrk];
	
	if !(_mrk in SAI_MARKERS_WEST) then {
		_mrk = createMarker [_mrk, _pos];
	} else {
		_mrk setMarkerPos _pos;
		if (SAI_EAST knowsAbout vehicle leader _grp > 0 && markerText _mrk != "!") then {_mrk setMarkerText "!"};
		if (SAI_EAST knowsAbout vehicle leader _grp == 0 && markerText _mrk != "") then {_mrk setMarkerText ""};
	};
	
	private _smt = "mil_dot";
	if (_typ == "INF") then {_smt = "b_inf"};
	if (_typ == "MOT") then {_smt = "b_motor_inf"};
	if (_typ == "MEC") then {_smt = "b_mech_inf"};
	if (_typ == "ARM") then {_smt = "b_armor"};
	if (_typ == "PLA") then {_smt = "b_plane"};
	if (_typ == "HEL") then {_smt = "b_air"};
	if (_typ == "TRA") then {_smt = "b_air"};
	if (_typ == "LOG") then {_smt = "b_unknown"};
	if (_typ == "SUP") then {_smt = "b_support"};
	if (_typ == "STA") then {_smt = "b_installation"};
	if (_typ == "ART") then {_smt = "b_art"};
	if (_typ == "UAV") then {_smt = "b_uav"};
	if (_typ == "COM") then {_smt = "b_hq"; SAI_WEST_HQ = true};
	if (markerType _mrk != _smt) then {
		_mrk setMarkerType _smt;
	};
}forEach SAI_WEST_ALL;

{
	if (_x in _markersWest == false) then {
		deletemarker _x;
	};
}forEach SAI_MARKERS_WEST;

/// EAST
private _markersEast = [];
{
	private _grp = _x select 0;
	private _typ = _x select 1;
	private _pos = getpos leader _grp;
	private _idx = groupId _grp;
	private _mrk = format ["SAI_EAST_%1", _idx];
	_markersEast append [_mrk];
	
	if !(_mrk in SAI_MARKERS_EAST) then {
		_mrk = createMarker [_mrk, _pos];
		_mrk setMarkerAlpha 0;
	} else {
		_mrk setMarkerPos _pos;
		if (SAI_WEST knowsAbout vehicle leader _grp > 0 && markerAlpha _mrk != 1) then {_mrk setMarkerAlpha 1};
		if (SAI_WEST knowsAbout vehicle leader _grp == 0 && markerAlpha _mrk != 0) then {_mrk setMarkerAlpha 0};
	};
	
	private _smt = "mil_dot";
	if (_typ == "INF") then {_smt = "o_inf"};
	if (_typ == "MOT") then {_smt = "o_motor_inf"};
	if (_typ == "MEC") then {_smt = "o_mech_inf"};
	if (_typ == "ARM") then {_smt = "o_armor"};
	if (_typ == "PLA") then {_smt = "o_plane"};
	if (_typ == "HEL") then {_smt = "o_air"};
	if (_typ == "TRA") then {_smt = "b_air"};
	if (_typ == "LOG") then {_smt = "o_unknown"};
	if (_typ == "SUP") then {_smt = "o_support"};
	if (_typ == "STA") then {_smt = "o_installation"};
	if (_typ == "ART") then {_smt = "o_art"};
	if (_typ == "UAV") then {_smt = "o_uav"};
	if (_typ == "COM") then {_smt = "o_hq"; SAI_EAST_HQ = true};
	if (markerType _mrk != _smt) then {
		_mrk setMarkerType _smt;
	};
}forEach SAI_EAST_ALL;

{
	if (_x in _markersEast == false) then {
		deletemarker _x;
	};
}forEach SAI_MARKERS_EAST;