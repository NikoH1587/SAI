SAI_POS_WEST = getMarkerPos "SAI_WEST";
SAI_POS_CENT = getMarkerPos "SAI_CENT";
SAI_POS_EAST = getMarkerPos "SAI_EAST";

private _westX = SAI_POS_WEST select 0;
private _westY = SAI_POS_WEST select 1;
private _eastX = SAI_POS_EAST select 0;
private _eastY = SAI_POS_EAST select 1;
private _centX = SAI_POS_CENT select 0;
private _centY = SAI_POS_CENT select 1;

SAI_CENTER = [((_westX + _eastX + _centX) / 3), ((_westY + _eastY + _centY) / 3)];

"SAI_WEST" setMarkerDir (SAI_POS_WEST getDir SAI_CENTER);
"SAI_EAST" setMarkerDir (SAI_POS_EAST getDir SAI_CENTER);
"SAI_CENT" setMarkerDir (SAI_POS_CENT getDir SAI_CENTER);

private _maxdist = 0;
{
	private _distance = (getMarkerPos _x) distance SAI_CENTER;
	if (_distance > _maxdist) then {_maxdist = _distance};
}forEach ["SAI_WEST", "SAI_CENT", "SAI_EAST"];

private _sizeOut = 50000;
private _sizeX = _maxdist + (SAI_DISTANCE*1.25);
private _sizeY = _maxdist + (SAI_DISTANCE*1.25);
private _dir = 0;
private _posX = SAI_CENTER select 0;
private _posY = SAI_CENTER select 1;

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
	_marker setmarkerbrush "SolidFull";
	_marker setmarkercolor "colorBlack";

};