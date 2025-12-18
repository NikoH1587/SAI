{
	private _hex = _x;
	private _row = _x select 0;
	private _col = _x select 1;
	private _pos = _x select 2;
	private _cfg = _x select 3;
	private _sid = _x select 4;
	private _act = _x select 5;
	private _max = 1;
	if (_cfg in ["b_mech_inf", "b_armor","o_mech_inf", "o_armor"]) then {_max = 2};
	if (_cfg in ["b_motor_inf", "b_recon","o_motor_inf", "o_recon"]) then {_max = 3};

	private _name = format ["CNT_%1_%2", _row, _col];
	deleteMarkerLocal _name;

	private _draw = false;
	if (_sid == side player) then {_draw = true};
	
	private _near = _hex call HEX_FNC_NEAR;
	{
		private _sid2 = _x select 4;
		if (_sid2 == side player) then {
			_draw = true;
		};
	}forEach _near;
	
	if (_draw == true && _cfg != "hd_dot") then {
		private _marker = createMarkerLocal [_name, _pos];
		_marker setMarkerTypeLocal _cfg;
		_sup = false;
		if (_cfg in ["b_hq", "b_support", "b_air", "b_plane", "b_art", "o_hq", "o_support", "o_air", "o_plane", "o_art"]) then {_sup = true};
		if (_sid == side player && _max > 0 && _sup == false) then {
			_marker setMarkerTextLocal ((str _act) + "/" + (str _max));			
		};
	};
}forEach HEX_GRID;

///     private _name = format ["HEX_%1_%2", _row, _col];
/// HEX_GRID pushBack [_row, _col, [_x,_y], "hd_flag", "hd_flag", "hd_flag"];