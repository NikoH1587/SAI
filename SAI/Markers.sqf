SAI_MARKERS = allMapmarkers select {_x find "SAI_OBJ_" == 0};
SAI_MARKERS_WEST = [];
SAI_MARKERS_EAST = [];

private _count = 0;
private _centX = 0;
private _centY = 0;

{
	private _mrk = _x;
	private _pos = getMarkerPos _x;
	private _mrkX = _pos select 0;
	private _mrkY = _pos select 1;
	_count = _count + 1;
	_centX = _centX + _mrkX;
	_centY = _centY + _mrkY;
	_mrk setMarkerShape "Ellipse";
	_mrk setMarkerSize [500, 500];
	_mrk setMarkerBrush "Border";
	if (markerColor _mrk == "ColorWEST") then {SAI_MARKERS_WEST append [_mrk]};
	if (markerColor _mrk == "ColorEAST") then {SAI_MARKERS_EAST append [_mrk]};
}forEach SAI_MARKERS;

_centX = _centX / _count;
_centY = _centY / _count;

SAI_CENTER = [_centX, _centY];
///private _respawn_west = createMarker ["respawn_west", SAI_POS_WEST];

SAI_DISTANCE = 500;

private _sizeOut = 50000;
private _sizeX = SAI_DISTANCE * _count;
private _sizeY = SAI_DISTANCE * _count;
private _dir = 0;
private _posX = _centX;
private _posY = _centY;

for "_i" from 0 to 270 step 90 do {
	private _size1 = [_sizeX,_sizeY] select (abs cos _i);
	private _size2 = [_sizeX,_sizeY] select (abs sin _i);
	private _sizeMarker = [_size2,_sizeOut] select (abs sin _i);
	private _dirTemp = _dir + _i;
	private _markerPos = [
		_posX + (sin _dirTemp * _sizeOut),
		_posY + (cos _dirTemp * _sizeOut)
	];
[_i,_markerPos,[_sizeMarker,_sizeOut - _size1]] call bis_fnc_log;

	private _marker = format ["SAI_COVERMAP_%1",_i];
	createmarker [_marker,_markerPos];
	_marker setmarkerpos _markerPos;
	_marker setmarkersize [_sizeMarker,_sizeOut - _size1];
	_marker setmarkerdir _dirTemp;
	_marker setmarkershape "rectangle";
	_marker setmarkerbrush "solid";
	_marker setmarkercolor "colorBlack";

};