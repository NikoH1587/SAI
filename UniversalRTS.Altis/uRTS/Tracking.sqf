private _westMapMarkers = allMapmarkers select {_x find "uRTS_WEST_" == 0};
private _westMarkers = [];
private _eastEnyMarkers = [];
{
	private _nid = _x select 0;
	private _type = _x select 1;
	private _mrk = format ["uRTS_WEST_%1", _nid];	
	_westMarkers append [_mrk];
	private _grp = _nid call BIS_fnc_groupFromNetId;
	private _pos = getpos leader _grp;
	
	if !(_mrk in _westMapMarkers) then {
		_mrk = createMarker [_mrk, _pos];
		_mrk setMarkerAlpha 0;
	} else {
		_mrk setMarkerPos _pos;
		if (east knowsAbout vehicle leader _grp > 0) then {_eastEnyMarkers append [_mrk]};
	};
	
	if (markerType _mrk != _type) then {
		_mrk setMarkerType _type;
	};
}forEach uRTS_WEST_ALL;

{
	if !(_x in _westMarkers) then {
		deletemarker _x;
	};
}forEach _westMapMarkers;

private _eastMapMarkers = allMapmarkers select {_x find "uRTS_EAST_" == 0};
private _eastMarkers = [];
private _westEnyMarkers = [];
{
	private _nid = _x select 0;
	private _type = _x select 1;
	private _mrk = format ["uRTS_EAST_%1", _nid];	
	_eastMarkers append [_mrk];
	private _grp = _nid call BIS_fnc_groupFromNetId;
	private _pos = getpos leader _grp;
	
	if !(_mrk in _eastMapMarkers) then {
		_mrk = createMarker [_mrk, _pos];
		_mrk setMarkerAlpha 0;
	} else {
		_mrk setMarkerPos _pos;
		if (west knowsAbout vehicle leader _grp > 0) then {_westEnyMarkers append [_mrk]};
	};
	
	if (markerType _mrk != _type) then {
		_mrk setMarkerType _type;
	};
}forEach uRTS_EAST_ALL;

{
	if !(_x in _eastMarkers) then {
		deletemarker _x;
	};
}forEach _eastMapMarkers;

[_eastMarkers, _eastEnyMarkers] remoteExec ["uRTS_PLAYER_TRACKING", east];
[_westMarkers, _westEnyMarkers] remoteExec ["uRTS_PLAYER_TRACKING", west];