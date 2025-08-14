/// choose closest objective per group???
{
	private _group = _x select 0;
	private _task = _x select 1;
	private _target = _x select 2;
	private _ldr = leader _group;
	private _veh = vehicle _ldr;
	private _inf = SAI_WEST_INF;
	private _side = side _group;
	private _pos = getPos _ldr;
	if (_side == SAI_EAST) then {
		_inf = SAI_EAST_INF;
	};
	
	/// busy override
	private _plr = false;
	private _busy = false;
	if (isPlayer _ldr) then {_plr = true};	
	_busy = [_ldr, _veh, _plr] call SAI_WP_CHK;
	
	/// needService override
	private _serv = false;
		
	/// transport override
	private _tran = false;
	
	if (_busy == false && _serv == false) then {
		_tran = [_group, _inf, _plr] call SAI_WP_LOG;
	};
	
	if (_busy == false && _tran == false && _serv == false) then {
		switch (_task) do {
			case "REC": {[_group, _target, _plr] call SAI_WP_REC};
			case "DEF": {[_group, _target, _plr] call SAI_WP_DEF};
			case "ATK": {[_group, _target, _plr] call SAI_WP_ATK};
			case "ART": {[_group, _target, _plr] call SAI_WP_ART};
			case "PLA": {[_group, _target, _plr] call SAI_WP_PLA};
			case "UAV": {[_group, _target, _plr] call SAI_WP_UAV};
			case "SUP": {[_group, _plr] call SAI_WP_SUP};
			/// add plane order
			/// add statics order
		}
	}
}forEach SAI_OPS_WEST;