SAI_MARKERS_WEST = allMapmarkers select {_x find "SAI_WEST_" == 0};
SAI_MARKERS_WP = allMapmarkers select {_x find "SAI_WPWP_" == 0};
SAI_MARKERS_EAST = allMapmarkers select {_x find "SAI_EAST_" == 0};
private _westID = SAI_WEST_ALL apply {groupId _x};
private _eastID = SAI_EAST_ALL apply {groupId _x};

{
	private _name = _x;
	private _idx = _name select [9, count _name];
	private _alive = _idx in _westID;
	private _wpMrk = format ["SAI_WPWP_%1", _idx];
	
	if (!_alive && markerAlpha _name != 0.5) then {
		_name setMarkerColor "ColorBlack";
		_name setMarkerAlpha 0.5;
		deleteMarker _wpMrk;
	};
}forEach SAI_MARKERS_WEST;

{
	private _name = _x;
	private _idx = _name select [9, count _name];
	private _alive = _idx in _eastID;
	
	if (!_alive && markerAlpha _name != 0.5) then {
		_name setMarkerColor "ColorBlack";
		_name setMarkerAlpha 0.5;
	};
}forEach SAI_MARKERS_EAST;

{
	private _grp = _x;
	private _idx = groupId _grp;
	private _ldr = leader _grp;
	private _mrk = format ["SAI_WEST_%1", _idx];
	private _wpMrk = format ["SAI_WPWP_%1", _idx];
	
	
	if !(_mrk in SAI_MARKERS_WEST) then {
		_wpMrk = createMarker [_wpMrk, position _ldr];
		_mrk = createMarker [_mrk, position _ldr];
		_wpMrk setMarkerShape "POLYLINE";
		_wpMrk setMarkerColor "ColorWEST";
		_wpMrk setMarkerAlpha 0.5;
	} else {
		private _wp = currentWaypoint _grp;
		private _ldrPos = position _ldr;
		private _wpPos = waypointPosition [_grp, _wp];
		if (_wpPos select 0 != 0 && _wpPos select 1 != 0 && _wpPos distance _ldrPos > 10) then {
			_wpMrk setMarkerPolyline [_ldrPos select 0, _ldrPos select 1, _wpPos select 0, _wpPos select 1];
		};
		_mrk setMarkerPos (position _ldr);
	};
	
	
	private _typ = "mil_dot";
	if (_grp in SAI_WEST_INF) then {_typ = "b_inf"};
	if (_grp in SAI_WEST_MOT) then {_typ = "b_motor_inf"};
	if (_grp in SAI_WEST_MEC) then {_typ = "b_mech_inf"};
	if (_grp in SAI_WEST_ARM) then {_typ = "b_armor"};
	if (_grp in SAI_WEST_PLA) then {_typ = "b_plane"};
	if (_grp in SAI_WEST_HEL) then {_typ = "b_air"};
	if (_grp in SAI_WEST_LOG) then {_typ = "b_unknown"};
	if (_grp in SAI_WEST_SUP) then {_typ = "b_support"};
	if (_grp in SAI_WEST_STA) then {_typ = "b_installation"};
	if (_grp in SAI_WEST_ART) then {_typ = "b_art"};
	if (_grp in SAI_WEST_UAV) then {_typ = "b_uav"};
	if (markerType _mrk != _typ) then {
		_mrk setMarkerType _typ;
	}
}forEach SAI_WEST_ALL;

{
	private _grp = _x;
	private _idx = groupId _grp;
	private _ldr = leader _grp;
	private _mrk = format ["SAI_EAST_%1", _idx];
	
	if !(_mrk in SAI_MARKERS_EAST) then {
		_mrk = createMarker [_mrk, position _ldr];
		_mrk setMarkerAlpha 0;
	} else {
		_mrk setMarkerPos (position _ldr);
		if (markerAlpha _mrk == 1) then {
		_mrk setMarkerAlpha 0;
		}
	};
	
	
	private _typ = "mil_dot";
	if (_grp in SAI_EAST_INF) then {_typ = "o_inf"};
	if (_grp in SAI_EAST_MOT) then {_typ = "o_motor_inf"};
	if (_grp in SAI_EAST_MEC) then {_typ = "o_mech_inf"};
	if (_grp in SAI_EAST_ARM) then {_typ = "o_armor"};
	if (_grp in SAI_EAST_PLA) then {_typ = "o_plane"};
	if (_grp in SAI_EAST_HEL) then {_typ = "o_air"};
	if (_grp in SAI_EAST_LOG) then {_typ = "o_unknown"};
	if (_grp in SAI_EAST_SUP) then {_typ = "o_support"};
	if (_grp in SAI_EAST_STA) then {_typ = "o_installation"};
	if (_grp in SAI_EAST_ART) then {_typ = "o_art"};
	if (_grp in SAI_EAST_UAV) then {_typ = "o_uav"};

	if (markerType _mrk != _typ) then {
		_mrk setMarkerType _typ;
	}
}forEach SAI_EAST_ALL;