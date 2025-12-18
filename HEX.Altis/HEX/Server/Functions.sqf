HEX_FNC_NEAR = {
	private _hex = _this;
	private _row = _hex select 0;
	private _col = _hex select 1;
	
	private _dirs = if (_col mod 2 == 0) then {HEX_EVEN} else {HEX_ODD};
	private _near = [];
	
	{
		private _rowNew = _row + (_x select 1);
		private _colNew = _col + (_x select 0);
		
		private _found = HEX_GRID select {(_x select 0) == _rowNew && (_x select 1) == _colNew};
		if (count _found > 0) then {_near pushBack (_found select 0)};
	}forEach _dirs;
	
	_near
};

HEX_FNC_FILL = {
	private _hex = _this select 0;
	private _max = _this select 1;
	
	private _open = [_hex];
	private _seen = [_hex];
	
	while {count _open > 0 && count _seen < _max} do {
		private _hex2 = _open deleteAt 0;
		{
			private _hex3 = _x;
			if ((_hex3 in HEX_GRID) && !(_hex3 in _seen)) then {
				_seen pushBack _hex3;
				_open pushBack _hex3;
			};
		}forEach (_hex2 call HEX_FNC_NEAR);
	};
	
	_seen
};
/// if (_x inArea _grid) then {};