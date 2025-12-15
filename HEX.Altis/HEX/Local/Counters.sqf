LOC_MARKERS = [];

/// Create markers for counter clientside
{
	private _hex = _x;
	private _sid = _x select 4;
	
	if (_sid == side player) then {
		private _near = _hex call HEX_FNC_NEAR;
		{
			private _hex2 = _x;
			if (_hex2 in LOC_MARKERS == false) then {LOC_MARKERS pushback _hex2};
		}forEach _near;
	};
}forEach HEX_GRID;

{
	private _row = _x select 0;
	private _col = _x select 1;
	private _pos = _x select 2;
	private _cfg = _x select 3;

	private _name = format ["LOC_%1_%2", _row, _col];
	private _marker = createMarkerLocal [_name, _pos];
	if (_cfg != "hd_dot") then {
		_marker setMarkerTypeLocal _cfg;
	};
}forEach LOC_MARKERS;



///     private _name = format ["HEX_%1_%2", _row, _col];
/// HEX_GRID pushBack [_row, _col, [_x,_y], "hd_flag", "hd_flag", "hd_flag"];