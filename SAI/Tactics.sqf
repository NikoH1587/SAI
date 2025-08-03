{
	private _group = _x select 0;
	private _task = _x select 1;
	private _target = _x select 2;
	
	private _ldr = leader _group;
	private _veh = vehicle _ldr;
	private _inf = SAI_WEST_INF;
	private _side = side _group;
	
	if (_side == SAI_EAST) then {
		_inf = SAI_EAST_INF;
	};
		
	/// busy override
	private _plr = false;
	private _busy = false;
	if (isPlayer _ldr) then {_plr = true};	
	_busy = [_ldr, _veh, _plr] call SAI_WP_CHK;
	
	/// exclude transport/service checks
	private _stat = _group in (SAI_WEST_INF + SAI_EAST_INF + SAI_WEST_STA + SAI_EAST_STA + SAI_WEST_ART + SAI_EAST_ART + SAI_WEST_PLA + SAI_EAST_PLA);	
	
	/// needService override
	private _serv = false;
		
	/// transport override
	private _tran = false;
	
	/// combat override?
	/// recon squads should pull back maybe?
	
	if (_busy == false && _stat == false && _serv == false) then {
		_tran = [_group, _inf, _plr] call SAI_WP_LOG;
	};
	
	if (_busy == false && _tran == false && _serv == false) then {
		switch (_task) do {
			case "REC": {[_group, getMarkerPos _target, _plr] call SAI_WP_REC};	
			case "QRF": {[_group, _target, _plr] call SAI_WP_QRF};
			case "DEF": {[_group, getMarkerPos _target, _plr] call SAI_WP_DEF};
			case "ART": {[_group, _target, _plr] call SAI_WP_ART};
			case "PLA": {[_group, _target, _plr] call SAI_WP_PLA};
			case "SUP": {[_group, _plr] call SAI_WP_SUP};
			/// add plane order
			/// add statics order
		}
	}
}forEach (SAI_OPS_WEST + SAI_OPS_EAST);