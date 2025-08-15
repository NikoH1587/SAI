SAI_OPS_WEST = [];
SAI_OPS_EAST = [];

/// get infantry groups for transportation tasking
private _infW = SAI_WEST_ALL select {(_x select 1) == "INF"};
SAI_WEST_INF = [];
{SAI_WEST_INF append [_x select 0]}forEach _infW;

private _infE = SAI_EAST_ALL select {(_x select 1) == "INF"};
SAI_EAST_INF = [];
{SAI_EAST_INF append [_x select 0]}forEach _infE;

/// WEST
{
	private _grp = _x select 0;
	private _typ = _x select 1;
	private _pos = _x select 2;
	private _raw = _typ in ["INF", "MOT", "MEC", "ARM", "HEL", "UAV"];
	
	if (_raw) then {
		private _res = _forEachIndex > (count SAI_WEST_ALL / 2);
		private _obj = SAI_POS_CENT;
		private _mod = "NAN";
		
		if (!_res) then {
			if (SAI_MODE == "GAMBIT") then {
				_obj = SAI_POS_CENT;
				private _dis = _pos distance _obj;
				if (_dis > SAI_DISTANCE) then {_mod = "REC"};
				if (_dis < SAI_DISTANCE) then {_mod = "DEF", _obj = _pos};
			};
			
			if (SAI_MODE == "DEFEND") then {
				_obj = SAI_POS_WEST;
				private _dis = _pos distance _obj;
				if (_dis > SAI_DISTANCE) then {_mod = "MOV"};
				if (_dis < SAI_DISTANCE) then {_mod = "DEF", _obj = _pos};
			};
			
			if (SAI_MODE == "ATTACK") then {
				_obj = SAI_POS_EAST;
				private _dis = _pos distance _obj;
				if (_dis > SAI_DISTANCE) then {_mod = "MOV"};
				if (_dis < SAI_DISTANCE) then {_mod = "ATK"};
			};
		};
		
		if (_res) then {
			if (SAI_MODE == "GAMBIT") then {
				_obj = SAI_POS_WEST;
				private _dis = _pos distance _obj;
				if (_dis > SAI_DISTANCE) then {_mod = "MOV"};
				if (_dis < SAI_DISTANCE) then {_mod = "DEF", _obj = _pos};
			};
			
			if (SAI_MODE == "DEFEND") then {
				_obj = SAI_POS_WEST;
				private _dis = _pos distance _obj;
				if (_dis > SAI_DISTANCE) then {_mod = "MOV"};
				if (_dis < SAI_DISTANCE) then {_mod = "DEF", _obj = _pos};
			};
			
			if (SAI_MODE == "ATTACK") then {
				_obj = SAI_POS_EAST;
				private _dis = _pos distance _obj;
				if (_dis > SAI_DISTANCE) then {_mod = "MOV"};
				if (_dis < SAI_DISTANCE) then {_mod = "ATK"};
			};
		};		
		
		if (_obj select 0 != _pos select 0 && _obj select 1 != _pos select 1) then {
			_obj = [((_obj select 0) + (_pos select 0)) / 2, ((_obj select 1) + (_pos select 1)) / 2];
			_obj = [[[_obj, SAI_DISTANCE]], ["water"]] call BIS_fnc_randomPos
			};
		SAI_OPS_WEST append [[_grp, _mod, _obj]];
	};
	
	if (_typ == "ART" && count SAI_ENY_WEST > 0) then {
		private _eny = SAI_ENY_WEST select floor random count SAI_ENY_WEST;
		SAI_OPS_WEST append [[_grp, "ART", _eny]];
	};
	
	if (_typ == "PLA" && count SAI_ENY_WEST > 0) then {
		private _eny = SAI_ENY_WEST select floor random count SAI_ENY_WEST;
		SAI_OPS_WEST append [[_grp, "PLA", _eny]];
	};
	
}forEach SAI_WEST_ALL;

/// EAST
{
	private _grp = _x select 0;
	private _typ = _x select 1;
	private _pos = _x select 2;
	private _raw = _typ in ["INF", "MOT", "MEC", "ARM", "HEL", "UAV"];
	
	if (_raw) then {
		private _res = _forEachIndex > (count SAI_EAST_ALL / 2);
		private _obj = SAI_POS_CENT;
		private _mod = "NAN";
		
		if (!_res) then {
			if (SAI_MODE == "GAMBIT") then {
				_obj = SAI_POS_CENT;
				private _dis = _pos distance _obj;
				if (_dis > SAI_DISTANCE) then {_mod = "REC"};
				if (_dis < SAI_DISTANCE) then {_mod = "DEF", _obj = _pos};
			};
			
			if (SAI_MODE == "DEFEND") then {
				_obj = SAI_POS_EAST;
				private _dis = _pos distance _obj;
				if (_dis > SAI_DISTANCE) then {_mod = "MOV"};
				if (_dis < SAI_DISTANCE) then {_mod = "DEF", _obj = _pos};
			};
			
			if (SAI_MODE == "ATTACK") then {
				_obj = SAI_POS_WEST;
				private _dis = _pos distance _obj;
				if (_dis > SAI_DISTANCE) then {_mod = "MOV"};
				if (_dis < SAI_DISTANCE) then {_mod = "ATK"};
			};
		};
		
		if (_res) then {
			if (SAI_MODE == "GAMBIT") then {
				_obj = SAI_POS_EAST;
				private _dis = _pos distance _obj;
				if (_dis > SAI_DISTANCE) then {_mod = "MOV"};
				if (_dis < SAI_DISTANCE) then {_mod = "DEF", _obj = _pos};
			};
			
			if (SAI_MODE == "DEFEND") then {
				_obj = SAI_POS_EAST;
				private _dis = _pos distance _obj;
				if (_dis > SAI_DISTANCE) then {_mod = "MOV"};
				if (_dis < SAI_DISTANCE) then {_mod = "DEF", _obj = _pos};
			};
			
			if (SAI_MODE == "ATTACK") then {
				_obj = SAI_POS_WEST;
				private _dis = _pos distance _obj;
				if (_dis > SAI_DISTANCE) then {_mod = "MOV"};
				if (_dis < SAI_DISTANCE) then {_mod = "ATK"};
			};
		};		
		
		if (_obj select 0 != _pos select 0 && _obj select 1 != _pos select 1) then {
			_obj = [((_obj select 0) + (_pos select 0)) / 2, ((_obj select 1) + (_pos select 1)) / 2];
			_obj = [[[_obj, SAI_DISTANCE]], ["water"]] call BIS_fnc_randomPos
			};
		SAI_OPS_EAST append [[_grp, _mod, _obj]];
	};
	
	if (_typ == "ART" && count SAI_ENY_EAST > 0) then {
		private _eny = SAI_ENY_EAST select floor random count SAI_ENY_EAST;
		SAI_OPS_EAST append [[_grp, "ART", _eny]];
	};
	
	if (_typ == "PLA" && count SAI_ENY_WEST > 0) then {
		private _eny = SAI_ENY_EAST select floor random count SAI_ENY_EAST;
		SAI_OPS_EAST append [[_grp, "PLA", _eny]];
	};
	
}forEach SAI_EAST_ALL;