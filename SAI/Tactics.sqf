{
	private _ldr = leader _x;
	private _veh = vehicle leader _x;
	private _ord = "NONE";
	private _obj = getMarkerPos SAI_OBJECTIVE;
	private _rtb = "SAI_WEST";
	private _eny = SAI_WEST_ENEMIES;
	private _inf = SAI_WEST_INF;
	private _side = side _x;
	
	if (_side == SAI_EAST) then {
		_rtb = "SAI_EAST";
		_eny = SAI_EAST_ENEMIES;
		_inf = SAI_EAST_INF;
	};
	
	private _busy = [_ldr, _veh] call SAI_WP_CHK;
	private _tran = false;
	private _stat = _x in (SAI_WEST_INF + SAI_EAST_INF + SAI_WEST_STA + SAI_EAST_STA + SAI_WEST_ART + SAI_EAST_ART + SAI_WEST_PLA + SAI_EAST_PLA);
	
	if (_busy == false && _stat == false) then {
		_tran = [_x, _inf] call SAI_WP_LOG;
	};
	
	if (_busy == false && _tran == false) then {
		if (_x in (SAI_WEST_REC + SAI_EAST_REC)) then {_ord = "REC"};
		if (_x in (SAI_WEST_QRF + SAI_EAST_QRF)) then {_ord = "QRF"};
		if (_x in (SAI_WEST_DEF + SAI_EAST_DEF)) then {_ord = "DEF"};
		if (_x in (SAI_WEST_LOG + SAI_EAST_LOG)) then {_ord = "DEF"};
		if (_x in (SAI_WEST_SUP + SAI_EAST_SUP)) then {_ord = "SUP"};
		if (_x in (SAI_WEST_STA + SAI_EAST_STA)) then {_ord = "NAN"};
		if (_x in (SAI_WEST_ART + SAI_EAST_ART)) then {_ord = "ART"};
		if (_x in (SAI_WEST_PLA + SAI_EAST_PLA)) then {_ord = "PLA"};

		switch (_ord) do {
			case "REC": {[_x, _obj] call SAI_WP_REC};	
			case "QRF": {[_x, _eny] call SAI_WP_QRF};
			case "DEF": {[_x, _rtb] call SAI_WP_DEF};
			case "ART": {[_x, _eny] call SAI_WP_ART};
			case "SUP": {[_x] call SAI_WP_SUP};
			/// add plane order
			/// add statics order
		}
	}
}forEach SAI_ALL;