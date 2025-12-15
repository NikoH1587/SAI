{
	private _row = _x select 0;
	private _col = _x select 1;
	private _pos = _x select 2;
    private _name = format ["HEX_%1_%2", _row, _col];
	private _marker = createMarker [_name, _pos];
	_marker setMarkerShape "HEXAGON";
	_marker setMarkerBrush "Border";
	_marker setMarkerAlpha 0.5;
	_marker setMarkerDir 90;
	_marker setMarkerSize [HEX_SIDE, HEX_SIDE];
}forEach HEX_GRID;

{
	private _pos = _x select 2;
	private _cfg = _x select 3;
	private _sid = _x select 4;
	
	/// create "base" locations
	private _size = HEX_SIDE/4;
	_location = createLocation [_cfg, _pos, _size, _size];
	_location setSide _sid;
	HEX_LOCS pushback _location;
	
	/// Create GRID overlay
	private _name = format ["HEX_%1", _pos];
	private _marker = createMarker [_name, _pos];
	_marker setMarkerShape "HEXAGON";
	_marker setMarkerBrush "Border";
	_marker setMarkerDir 90;
	_marker setMarkerSize [HEX_SIDE, HEX_SIDE];
	
	/// add already existing locations
	private _locs = nearestLocations [_pos, HEX_CFG_LOCS, HEX_SIDE];
	{
		private _loc = _x;
		private _pos = position _x;
		if (_pos inArea _marker) then {
			_loc setSide civilian;
			HEX_LOCS pushback _loc;
		};	
	}forEach _locs;
}forEach HEX_GRID;

{
	private _pos = position _x;
	private _side = side _x;
	private _size = (size _x) select 1;
	private _dir = direction _x;
	private _name = str _x;
	private _marker = createMarker [_name, position _x];
	private _color = "ColorUNKNOWN";
	if (side _x == west) then {_color = "colorBLUFOR"};
	if (side _x == east) then {_color = "colorOPFOR"};
	if (side _x == civilian) then {_color = "ColorCIV"};
	_marker setMarkerShape "RECTANGLE";
	_marker setMarkerBrush "Border";
	_marker setMarkerDir _dir;
	_marker setMarkerSize [_size, _size];
	_marker setMarkerColor _color;
}forEach HEX_LOCS;