SAI_OPS_WEST = [];

SAI_WEST_GRP = SAI_WEST_INF + SAI_WEST_MOT + SAI_WEST_MEC + SAI_WEST_ARM + SAI_WEST_HEL + SAI_WEST_UAV;
SAI_WEST_REC = [];
SAI_WEST_QRF = [];
SAI_WEST_DEF = [];

{
	private _grp = _x;
	if (_x in SAI_WEST_GRP) then {
		private _assigned = false;
		if (count SAI_WEST_REC < ((count SAI_WEST_GRP)/3) && _assigned == false) then {_assigned = true; SAI_WEST_REC append [_grp]};
		if (count SAI_WEST_QRF < ((count SAI_WEST_GRP)/3) && _assigned == false) then {_assigned = true; SAI_WEST_QRF append [_grp]};
		if (_assigned == false) then {SAI_WEST_DEF append [_grp]};
	};
}forEach SAI_WEST_ALL;

{
	private _obj = [0, 0, 0];
	if (count SAI_NEUT_OBJ > 0) then {
		private _mod = count SAI_WEST_REC / count SAI_NEUT_OBJ;
		private _idx = floor (_forEachIndex / _mod);
		if (_idx >= count SAI_NEUT_OBJ) then {_idx = 0};
		_obj = SAI_NEUT_OBJ select _idx;
	};
	SAI_OPS_WEST append [[_x, "REC", _obj]];
}forEach SAI_WEST_REC;

{
	private _obj = [0, 0, 0];
	if (count SAI_WEST_OBJ > 0) then {
		private _mod = count SAI_WEST_DEF / count SAI_WEST_OBJ;
		private _idx = floor (_forEachIndex / _mod);
		if (_idx >= count SAI_WEST_OBJ) then {_idx = 0};
		_obj = SAI_WEST_OBJ select _idx;
	};
	SAI_OPS_WEST append [[_x, "DEF", _obj]];
}forEach SAI_WEST_DEF;

{SAI_OPS_WEST append [[_x, "LOG", []]]}forEach SAI_WEST_LOG;
{SAI_OPS_WEST append [[_x, "SUP", []]]}forEach SAI_WEST_SUP;
{SAI_OPS_WEST append [[_x, "STA", []]]}forEach SAI_WEST_STA;
{SAI_OPS_WEST append [[_x, "QRF", SAI_WEST_ENEMIES select floor random count SAI_WEST_ENEMIES]]}forEach SAI_WEST_QRF;
{SAI_OPS_WEST append [[_x, "ART", SAI_WEST_ENEMIES select floor random count SAI_WEST_ENEMIES]]}forEach SAI_WEST_ART;
{SAI_OPS_WEST append [[_x, "PLA", SAI_WEST_ENEMIES select floor random count SAI_WEST_ENEMIES]]}forEach SAI_WEST_PLA;

SAI_OPS_EAST = [];

SAI_EAST_GRP = SAI_EAST_INF + SAI_EAST_MOT + SAI_EAST_MEC + SAI_EAST_ARM + SAI_EAST_HEL + SAI_EAST_UAV;
SAI_EAST_REC = [];
SAI_EAST_QRF = [];
SAI_EAST_DEF = [];

{
	private _grp = _x;
	if (_x in SAI_EAST_GRP) then {
		private _assigned = false;
		if (count SAI_EAST_REC < ((count SAI_EAST_GRP)/3) && _assigned == false) then {_assigned = true; SAI_EAST_REC append [_grp]};
		if (count SAI_EAST_QRF < ((count SAI_EAST_GRP)/3) && _assigned == false) then {_assigned = true; SAI_EAST_QRF append [_grp]};
		if (_assigned == false) then {SAI_EAST_DEF append [_grp]};
	};
}forEach SAI_EAST_ALL;

{
	private _obj = [0, 0, 0];
	if (count SAI_NEUT_OBJ > 0) then {
		private _mod = count SAI_EAST_REC / count SAI_NEUT_OBJ;
		private _idx = floor (_forEachIndex / _mod);
		if (_idx >= count SAI_NEUT_OBJ) then {_idx = 0};
		_obj = SAI_NEUT_OBJ select _idx;
	};
	SAI_OPS_EAST append [[_x, "REC", _obj]];
}forEach SAI_EAST_REC;

{
	private _obj = [0, 0, 0];
	if (count SAI_EAST_OBJ > 0) then {
		private _mod = count SAI_EAST_DEF / count SAI_EAST_OBJ;
		private _idx = floor (_forEachIndex / _mod);
		if (_idx >= count SAI_EAST_OBJ) then {_idx = 0};
		_obj = SAI_EAST_OBJ select _idx;
	};
	SAI_OPS_EAST append [[_x, "DEF", _obj]];
}forEach SAI_EAST_DEF;

{SAI_OPS_EAST append [[_x, "LOG", []]]}forEach SAI_EAST_LOG;
{SAI_OPS_EAST append [[_x, "SUP", []]]}forEach SAI_EAST_SUP;
{SAI_OPS_EAST append [[_x, "STA", []]]}forEach SAI_EAST_STA;
{SAI_OPS_EAST append [[_x, "QRF", SAI_EAST_ENEMIES select floor random count SAI_EAST_ENEMIES]]}forEach SAI_EAST_QRF;
{SAI_OPS_EAST append [[_x, "ART", SAI_EAST_ENEMIES select floor random count SAI_EAST_ENEMIES]]}forEach SAI_EAST_ART;
{SAI_OPS_EAST append [[_x, "PLA", SAI_EAST_ENEMIES select floor random count SAI_EAST_ENEMIES]]}forEach SAI_EAST_PLA;