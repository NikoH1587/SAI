HEX_FOW = [];

{
	private _row = _x select 0;
	private _col = _x select 1;
	private _pos = _x select 2;
	private _locs = nearestLocations [_pos, [], HEX_SIDE*2];
	private _hide = true;
	{
		if (side _x == side player) then {_hide = false};
	}forEach _locs;
	
	if (_hide) then {
		private _name = format ["FOW_%1_%2", _row, _col];
		private _marker = createMarkerLocal [_name, _pos];
		_marker setMarkerShapeLocal "HEXAGON";
		_marker setMarkerBrushLocal "SolidFull";
		_marker setMarkerColorLocal "ColorGrey";
		_marker setMarkerDirLocal 90;
		_marker setMarkerSizeLocal [HEX_SIDE*0.99, HEX_SIDE*0.99];
		HEX_FOW pushback _marker;
	};
}forEach HEX_GRID;

///     private _name = format ["HEX_%1_%2", _row, _col];
/// HEX_GRID pushBack [_row, _col, [_x,_y], "hd_flag", "hd_flag", "hd_flag"];