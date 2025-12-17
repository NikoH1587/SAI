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

/// if (_x inArea _grid) then {};