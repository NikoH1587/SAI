SAI_OPS_WEST = [];
SAI_OPS_EAST = [];

/// get infantry groups for transportation tasking
private _infW = SAI_WEST_ALL select {(_x select 1) == "INF"};
SAI_WEST_INF = [];
{SAI_WEST_INF append [_x select 0]}forEach _infW;

private _infE = SAI_EAST_ALL select {(_x select 1) == "INF"};
SAI_EAST_INF = [];
{SAI_EAST_INF append [_x select 0]}forEach _infE;

/// pull groups to do recon on neutral objectives
/// WEST
{
	private _count = 1;
	if (SAI_MODE_WEST == "GAMBIT") then {_count = 3};
	for "_i" from 1 to _count do {
		private _pos = _x;
		private _select = SAI_WEST_ALL select {(_x select 1) in ["INF", "MOT", "MEC", "ARM", "HEL"]};
		private _closest = [];
		private _minDist = 1e10;
	
		if (count SAI_WEST_ALL > 0) then {
			{
				private _pos2 = _x select 2;
				private _distance = _pos2 distance _pos;
				if (_distance < _minDist) then {
					_minDist = _distance;
					_closest = _x;
				};
			}forEach _select;
	
			SAI_OPS_WEST append [[_closest select 0, "REC", _pos]];
			SAI_WEST_ALL = SAI_WEST_ALL - [_closest];
		}
	}
}forEach (SAI_OBJ_NEUT + SAI_OBJ_WEST_SEC);

{
	private _count = 1;
	if (SAI_MODE_WEST == "DEFEND") then {_count = 3};
	for "_i" from 1 to _count do {
		private _pos = _x;
		private _select = SAI_WEST_ALL select {(_x select 1) in ["INF", "MOT", "MEC", "ARM", "HEL"]};
		private _closest = [];
		private _minDist = 1e10;
	
		if (count SAI_WEST_ALL > 0) then {
			{
				private _pos2 = _x select 2;
				private _distance = _pos2 distance _pos;
				if (_distance < _minDist) then {
					_minDist = _distance;
					_closest = _x;
				};
			}forEach _select;
	
			SAI_OPS_WEST append [[_closest select 0, "DEF", _pos]];
			SAI_WEST_ALL = SAI_WEST_ALL - [_closest];
		}
	}
}forEach SAI_OBJ_WEST;

{
	private _count = 0;
	if (SAI_MODE_WEST == "ATTACK") then {_count = 3};
	for "_i" from 1 to _count do {
		private _pos = _x;
		private _select = SAI_WEST_ALL select {(_x select 1) in ["INF", "MOT", "MEC", "ARM", "HEL"]};
		private _closest = [];
		private _minDist = 1e10;
	
		if (count SAI_WEST_ALL > 0) then {
			{
				private _pos2 = _x select 2;
				private _distance = _pos2 distance _pos;
				if (_distance < _minDist) then {
					_minDist = _distance;
					_closest = _x;
				};
			}forEach _select;
	
			SAI_OPS_WEST append [[_closest select 0, "ATK", _pos]];
			SAI_WEST_ALL = SAI_WEST_ALL - [_closest];
		}
	}
}forEach SAI_OBJ_EAST;