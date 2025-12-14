{
	private _row = _x select 0;
	private _col = _x select 1;
	private _pos = _x select 2;
	private _cfg = _x select 3;
	private _sid = _x select 4;
	
	private _name = format ["CFG_%1_%2", _row, _col];
	if (_sid == side player) then {
		private _marker = createMarkerLocal [_name, _pos];
		_marker setMarkerTypeLocal _cfg;
	};
	
	if (_sid != side player && _sid == east) then {
		private _marker = createMarkerLocal [_name, _pos];
		_marker setMarkerTypeLocal "o_unknown";
	};
}forEach HEX_GRID;

///     private _name = format ["HEX_%1_%2", _row, _col];
/// HEX_GRID pushBack [_row, _col, [_x,_y], "hd_flag", "hd_flag", "hd_flag"];