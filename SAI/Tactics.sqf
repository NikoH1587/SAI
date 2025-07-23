{
	_ldr = leader _x;
	_veh = vehicle leader _x;
	_ord = "NONE";
	_srv = needService _veh;
	_obj = getMarkerPos SAI_OBJECTIVE;
	_rtb = "SAI_WEST";
	_eny = SAI_WEST_ENEMIES;
	_inf = SAI_WEST_INF;
	_side = side _x;
	
	if (_side == SAI_EAST) then {
		_rtb = "SAI_EAST";
		_eny = SAI_EAST_ENEMIES;
		_inf = SAI_EAST_INF;
	};
	
	_busy = [_ldr, _veh] call SAI_WP_CHK;
	_tran = false;
	_comb = (behaviour _ldr == "COMBAT");
	_flee = fleeing _ldr;
	
	
	if (_busy == false && _comb == false && _flee == false) then {
		_tran = [_x, _inf] call SAI_WP_LOG;
	};
	
	if (_busy == false && _tran == false && _comb == false && _flee == false) then {
		if (_x in (SAI_WEST_REC + SAI_EAST_REC)) then {_ord = "REC"};
		if (_x in (SAI_WEST_QRF + SAI_EAST_QRF)) then {_ord = "QRF"};
		if (_x in (SAI_WEST_DEF + SAI_EAST_DEF)) then {_ord = "DEF"};
		if (_x in (SAI_WEST_ART + SAI_EAST_ART)) then {_ord = "ART"};
		if (_x in (SAI_WEST_LOG + SAI_EAST_LOG)) then {_ord = "DEF"};
		if (_x in (SAI_WEST_SUP + SAI_EAST_SUP)) then {_ord = "DEF"};
		if (_x in (SAI_WEST_STA + SAI_EAST_STA)) then {_ord = "NONE"};

		switch (_ord) do {
			case "REC": {[_x, _obj] call SAI_WP_REC};	
			case "QRF": {[_x, _eny] call SAI_WP_QRF};
			case "DEF": {[_x, _rtb] call SAI_WP_DEF};
			case "ART": {[_x, _eny] call SAI_WP_ART};
		}
	}
}forEach (SAI_ALL);