SAI_WEST_ENEMIES = [];
SAI_EAST_ENEMIES = [];

{
	if ((SAI_WEST knowsAbout _x) > 0 && (side _x == SAI_EAST) && alive _x) then {
		SAI_WEST_ENEMIES append [_x];
		private _grp = group _x;
		private _idx = groupId _grp;
		private _mrk = format ["SAI_EAST_%1", _idx];
		if (markerAlpha _mrk == 0) then {
			_mrk setMarkerAlpha 1;
		};
	};
	
	if ((SAI_EAST knowsAbout _x) > 0 && (side _x == SAI_WEST) && alive _x) then {
		SAI_WEST_ENEMIES append [_x];
	};
}forEach allUnits;

private _west = SAI_WEST_MOT + SAI_WEST_HEL + SAI_WEST_ARM + SAI_WEST_MEC + SAI_WEST_INF;
private _east = SAI_EAST_MOT + SAI_EAST_HEL + SAI_EAST_ARM + SAI_EAST_MEC + SAI_EAST_INF;

private _modw = ceil ((count _west)/3);
private _mode = ceil ((count _east)/3);

private _recw = ceil ((count SAI_RECON_WEST) / _modw);
private _rece = ceil ((count SAI_RECON_WEST) / _mode);

private _defw = ceil ((count SAI_DEFEND_WEST) / _modw);
private _defe = ceil ((count SAI_DEFEND_WEST) / _mode);

SAI_OPS_WEST = [];
SAI_OPS_EAST = [];

{
	private _group = _x;
	private _idx = _forEachIndex;
	private _total = count _east;
	
	private _task = "DEF";
	private _target = "";
	
	if (_idx < _modw) then {
		_task = "REC";
		_target = SAI_RECON_WEST select (_idx % (count SAI_RECON_WEST));
	} else {
		if (_idx < (_modw * 2)) then {
			_task = "QRF";
			if (count SAI_WEST_ENEMIES > 0) then {
				private _enemy = SAI_WEST_ENEMIES select (_idx % (count SAI_WEST_ENEMIES));
				_target = getPos _enemy;
			} else {
				_target = [0,0,0];
			};
		} else  {
			_task = "DEF";
			_target = SAI_DEFEND_WEST select ((_idx - (_modw * 2)) % (count SAI_DEFEND_WEST));
		}
	};
	SAI_OPS_WEST append [[_group, _task, _target]];
}forEach _west;

{SAI_OPS_WEST append [[_x, "LOG", [0, 0, 0]]]}forEach SAI_WEST_LOG;
{SAI_OPS_WEST append [[_x, "SUP", [0, 0, 0]]]}forEach SAI_WEST_SUP;
{SAI_OPS_WEST append [[_x, "STA", [0, 0, 0]]]}forEach SAI_WEST_STA;

{
	private _target = [0,0,0];
	if (count SAI_WEST_ENEMIES > 0) then {
		private _enemy = SAI_WEST_ENEMIES select floor random count SAI_WEST_ENEMIES;
		_target = getPosASL _enemy;
	};
	SAI_OPS_WEST append [[_x, "ART", _target]];
}forEach SAI_WEST_ART;

{
	private _target = [0,0,0];
	if (count SAI_WEST_ENEMIES > 0) then {
		private _enemy = SAI_WEST_ENEMIES select floor random count SAI_WEST_ENEMIES;
		_target = getPosASL _enemy;
	};
	SAI_OPS_WEST append [[_x, "PLA", _target]];
}forEach SAI_WEST_PLA;

{
	private _group = _x;
	private _idx = _forEachIndex;
	private _total = count _east;
	
	private _task = "DEF";
	private _target = "";
	
	if (_idx < _mode) then {
		_task = "REC";
		_target = SAI_RECON_EAST select (_idx % (count SAI_RECON_EAST));
	} else {
		if (_idx < (_mode * 2)) then {
			_task = "QRF";
			if (count SAI_WEST_ENEMIES > 0) then {
				private _enemy = SAI_WEST_ENEMIES select (_idx % (count SAI_WEST_ENEMIES));
				_target = getPos _enemy;
			} else {
				_target = [0,0,0];
			};
		} else  {
			_task = "DEF";
			_target = SAI_DEFEND_EAST select ((_idx - (_mode * 2)) % (count SAI_DEFEND_EAST));
		}
	};
	SAI_OPS_EAST append [[_group, _task, _target]];
}forEach _east;

{SAI_OPS_EAST append [[_x, "LOG", [0, 0, 0]]]}forEach SAI_EAST_LOG;
{SAI_OPS_EAST append [[_x, "SUP", [0, 0, 0]]]}forEach SAI_EAST_SUP;
{SAI_OPS_EAST append [[_x, "STA", [0, 0, 0]]]}forEach SAI_EAST_STA;

{
	private _target = [0,0,0];
	if (count SAI_EAST_ENEMIES > 0) then {
		private _enemy = SAI_EAST_ENEMIES select floor random count SAI_EAST_ENEMIES;
		_target = getPosASL _enemy;
	};
	SAI_OPS_EAST append [[_x, "ART", _target]];
}forEach SAI_EAST_ART;

{
	private _target = [0,0,0];
	if (count SAI_EAST_ENEMIES > 0) then {
		private _enemy = SAI_EAST_ENEMIES select floor random count SAI_EAST_ENEMIES;
		_target = getPosASL _enemy;
	};
	SAI_OPS_EAST append [[_x, "PLA", _target]];
}forEach SAI_EAST_PLA;