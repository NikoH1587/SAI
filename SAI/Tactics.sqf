/// choose closest objective per group???
{
	private _grp = _x select 0;
	private _tsk = _x select 1;
	private _pos = _x select 2;
	/// add override to arty etc so won't be random pos
	private _ldr = leader _grp;
	private _veh = vehicle _ldr;
	private _inf = SAI_WEST_INF;
	private _dir = SAI_POS_EAST;
	private _rtb = SAI_POS_REAR_WEST;
	private _def = SAI_POS_LINE_WEST;
	private _side = side _grp;
	if (_side == SAI_EAST) then {
		_inf = SAI_EAST_INF;
		_dir = SAI_POS_WEST;
		_rtb = SAI_POS_REAR_EAST;
		_def = SAI_POS_LINE_EAST;
	};
	
	/// busy override
	private _plr = false;
	private _busy = false;
	if (isPlayer _ldr) then {_plr = true};	
	_busy = [_ldr, _veh, _plr] call SAI_WP_CHK;
	
	/// needService override
	private _serv = false;
	
	if (_busy == false && _serv == false) then {
		switch (_tsk) do {
			case "REC": {[_grp, _pos, _plr, _dir] call SAI_WP_REC};
			case "MOV": {[_grp, _pos, _plr, _dir] call SAI_WP_MOV};
			case "DEF": {[_grp, _pos, _plr, _dir] call SAI_WP_DEF};
			case "ATK": {[_grp, _pos, _plr] call SAI_WP_ATK};
			case "ART": {[_grp, _pos, _plr] call SAI_WP_ART};
			case "PLA": {[_grp, _pos, _plr] call SAI_WP_PLA};
			case "UAV": {[_grp, _pos, _plr] call SAI_WP_UAV};
			case "LOG": {[_grp, _inf, _rtb] call SAI_WP_LOG};
		}
	}
}forEach (SAI_OPS_WEST + SAI_OPS_EAST)