SAI_POS_WEST = getMarkerPos "SAI_WEST";
SAI_POS_EAST = getMarkerPos "SAI_EAST";
SAI_POS_CENT = getMarkerPos "SAI_CENT";

_respawn_west = createMarker ["respawn_west", SAI_POS_WEST];
_respawn_east = createMarker ["respawn_east", SAI_POS_WEST];

SAI_DISTANCE = (SAI_POS_WEST distance SAI_POS_EAST) / 2;

_sizeOut = 50000;
_sizeX = SAI_DISTANCE*2;
_sizeY = SAI_DISTANCE*2;
_dir = 0;
_posY = SAI_POS_CENT select 1;
_posX = SAI_POS_CENT select 0;

for "_i" from 0 to 270 step 90 do {
	_size1 = [_sizeX,_sizeY] select (abs cos _i);
	_size2 = [_sizeX,_sizeY] select (abs sin _i);
	_sizeMarker = [_size2,_sizeOut] select (abs sin _i);
	_dirTemp = _dir + _i;
	_markerPos = [
		_posX + (sin _dirTemp * _sizeOut),
		_posY + (cos _dirTemp * _sizeOut)
	];
[_i,_markerPos,[_sizeMarker,_sizeOut - _size1]] call bis_fnc_log;

	_marker = format ["SAI_COVERMAP_%1",_i];
	createmarker [_marker,_markerPos];
	_marker setmarkerpos _markerPos;
	_marker setmarkersize [_sizeMarker,_sizeOut - _size1];
	_marker setmarkerdir _dirTemp;
	_marker setmarkershape "rectangle";
	_marker setmarkerbrush "solid";
	_marker setmarkercolor "colorBlack";

};