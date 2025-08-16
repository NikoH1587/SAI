SAI_OPS_WEST = [];
SAI_OPS_EAST = [];

/// get infantry groups for transportation tasking
private _infW = SAI_WEST_ALL select {(_x select 1) == "INF"};
SAI_WEST_INF = [];
{SAI_WEST_INF append [[_x select 0, _x select 2]]}forEach _infW;

private _infE = SAI_EAST_ALL select {(_x select 1) == "INF"};
SAI_EAST_INF = [];
{SAI_EAST_INF append [[_x select 0, _x select 2]]}forEach _infE;

{
	private _grp = _x select 0;
	private _typ = _x select 1;
	private _pos = _x select 2;
	private _eny = count SAI_ENY_WEST > 0;
	
	if (_typ in ["INF", "MOT", "MEC", "ARM", "HEL"]) then {
		private _mod = "NAN";
		private _obj = SAI_POS_CENT;
		private _dis = _pos distance _obj;
	
		if (SAI_OBJECTIVE == "SAI_CENT") then {
			if (_dis < SAI_DISTANCE) then {_mod = "REC"} else {_mod = "MOV"};
		};	
	
		if (SAI_OBJECTIVE == "SAI_WEST") then {
			_obj = SAI_POS_WEST;
			if (_dis < SAI_DISTANCE) then {_mod = "DEF"} else {_mod = "MOV"};
		};
	
		if (SAI_OBJECTIVE == "SAI_EAST") then {
			_obj = SAI_POS_EAST;
			if (_dis < SAI_DISTANCE) then {_mod = "ATK"} else {_mod = "MOV"};
		};

		if (_mod == "MOV") then {_obj = [((_obj select 0) + (_pos select 0)) / 2, ((_obj select 1) + (_pos select 1)) / 2]};
		_obj = [[[_obj, SAI_DISTANCE]], ["water"]] call BIS_fnc_randomPos;
		SAI_OPS_WEST append [[_grp, _mod, _obj]];
	};
	
	if (_typ == "ART" && _eny) then {
		private _eny = SAI_ENY_WEST select floor random count SAI_ENY_WEST;
		SAI_ENY_WEST = SAI_ENY_WEST - [_eny];
		SAI_OPS_WEST append [[_grp, "ART", _eny]];
	};
	
	if (_typ == "PLA" && _eny) then {
		private _eny = SAI_ENY_WEST select floor random count SAI_ENY_WEST;
		SAI_ENY_WEST = SAI_ENY_WEST - [_eny];
		SAI_OPS_WEST append [[_grp, "PLA", _eny]];
	};
	
	if (_typ == "UAV" && _eny) then {
		private _eny = SAI_ENY_WEST select floor random count SAI_ENY_WEST;
		SAI_ENY_WEST = SAI_ENY_WEST - [_eny];
		SAI_OPS_WEST append [[_grp, "UAV", _eny]];
	};
	
	if (_typ == "LOG") then {
		SAI_OPS_WEST append [[_grp, "LOG", SAI_POS_WEST]];
	};
	
	if (_typ == "SUP") then {
		SAI_OPS_WEST append [[_grp, "SUP", SAI_POS_WEST]];
	};
}forEach SAI_WEST_ALL;

{
	private _grp = _x select 0;
	private _typ = _x select 1;
	private _pos = _x select 2;
	private _eny = count SAI_ENY_EAST > 0;
	
	if (_typ in ["INF", "MOT", "MEC", "ARM", "HEL"]) then {
		private _mod = "NAN";
		private _obj = SAI_POS_CENT;
		private _dis = _pos distance _obj;
	
		if (SAI_OBJECTIVE == "SAI_CENT") then {
			if (_dis < SAI_DISTANCE) then {_mod = "REC"} else {_mod = "MOV"};
		};	
	
		if (SAI_OBJECTIVE == "SAI_EAST") then {
			_obj = SAI_POS_EAST;
			if (_dis < SAI_DISTANCE) then {_mod = "DEF"} else {_mod = "MOV"};
		};
	
		if (SAI_OBJECTIVE == "SAI_WEST") then {
			_obj = SAI_POS_WEST;
			if (_dis < SAI_DISTANCE) then {_mod = "ATK"} else {_mod = "MOV"};
		};

		if (_mod == "MOV") then {_obj = [((_obj select 0) + (_pos select 0)) / 2, ((_obj select 1) + (_pos select 1)) / 2]};
		_obj = [[[_obj, SAI_DISTANCE]], ["water"]] call BIS_fnc_randomPos;
		SAI_OPS_EAST append [[_grp, _mod, _obj]];
	};
	
	if (_typ == "ART" && _eny) then {
		private _eny = SAI_ENY_EAST select floor random count SAI_ENY_EAST;
		SAI_ENY_EAST = SAI_ENY_EAST - [_eny];
		SAI_OPS_EAST append [[_grp, "ART", _eny]];
	};
	
	if (_typ == "PLA" && _eny) then {
		private _eny = SAI_ENY_EAST select floor random count SAI_ENY_EAST;
		SAI_ENY_EAST = SAI_ENY_EAST - [_eny];
		SAI_OPS_EAST append [[_grp, "PLA", _eny]];
	};
	
	if (_typ == "UAV" && _eny) then {
		private _eny = SAI_ENY_EAST select floor random count SAI_ENY_EAST;
		SAI_ENY_EAST = SAI_ENY_EAST - [_eny];
		SAI_OPS_EAST append [[_grp, "UAV", _eny]];
	};
	
	if (_typ == "LOG") then {
		SAI_OPS_EAST append [[_grp, "LOG", SAI_POS_EAST]];
	};
	
	if (_typ == "SUP") then {
		SAI_OPS_EAST append [[_grp, "SUP", SAI_POS_EAST]];
	};
}forEach SAI_EAST_ALL;
