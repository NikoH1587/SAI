///createDialog "SCS_MENU2";
private _display = findDisplay 1100;
openmap true;
///(findDisplay 46) createDisplay "SCS_MENU2";

HEX_CENTER = [] call BIS_fnc_randomPos;
HEX_COUNT = 12;
HEX_SIDE = 1000;
HEX_GRID = [];
_hexDirsEven = [[0,-1],[1,-1],[1,0],[0,1],[-1,0],[-1,-1]];
_hexDirsOdd = [[0,-1],[1,0],[1,1],[0,1],[-1,1],[-1,0]];

HEX_FNC_HEX2POS = {
	private _row = _this select 0;
	private _col = _this select 1;
	private _offsetY = if (_col mod 2 == 0) then {0} else {HEX_SIDE * (sqrt(3)/2)};
	private _posX = (HEX_CENTER  select 0) + (_col * HEX_SIDE * 1.5);
	private _posY = (HEX_CENTER  select 1) + (_row * HEX_SIDE * sqrt(3)) + _offsetY;
	[_posX, _posY];
};

HEX_FNC_POS2HEX = {
	private _pos = _this;
	private _hex = HEX_GRID select {
		private _hexPos = _x call HEX_FNC_HEX2POS;
		(_pos distance _hexPos < HEX_SIDE * 0.75)
	};
	if (count _hex > 0) exitWith {_hex select 0};
	hint "Hex not found!";
	nil
};

HEX_FNC_NEAR = {
	private _hex = _this;
	private _row = _hex select 0;
	private _col = _hex select 1;
	
	private _dirs = if (_col mod 2 == 0) then {_hexDirsEven} else {_hexDirsOdd};
	private _near = [];
	
	{
		private _rowNew = _row + (_x select 1);
		private _colNew = _col + (_x select 0);
		
		private _found = HEX_GRID select {(_x select 0) == _rowNew && (_x select 1) == _colNew};
		if (count _found > 0) then {_near pushBack (_found select 0)};
	}forEach _dirs;
	
	_near
};

if (surfaceIsWater HEX_CENTER) exitWith {
	private _msg = "[HEX] Starting hex is in water! Cannot generate grid here.";
	diag_log _msg;
	hint _msg;
};

HEX_GRID pushBack [0,0];

_ring = 1;
while {count HEX_GRID < HEX_COUNT} do {
	private _row = -_ring;
	private _col = 0;
	private _dirs = [[1,0],[0,1],[-1,1],[-1,0],[0,-1],[1,-1]];
	
	private _added = 0;
	{
		private _dir = _x;
		private _steps = _ring;
		while {_steps > 0 && count HEX_GRID < HEX_COUNT} do {
			_col = _col + (_dir select 0);
			_row = _row + (_dir select 1);

			private _pos = [_row,_col] call HEX_FNC_HEX2POS;
			
			if (!surfaceIsWater _pos) then {
				private _marker = format ["HEX%1%2", _row, _col];
				HEX_GRID pushBack [_row, _col];
				_added = _added + 1;
			};
			
			_steps = _steps - 1;
		};
	}forEach _dirs;
	
	if (_added == 0) exitWith {hint "Cannot add more hexes! Map too small?"};
	_ring = _ring + 1;
};

{
	private _marker = format ["HEX%1%2", _row, _col];
	_marker setMarkerShape "HEXAGON";
	_marker setMarkerBrush "Solid";
	_marker setMarkerColor "ColorBLACK";
	_marker setMarkerAlpha 0.5;
	_marker setMarkerDir 90;
	_marker setMarkerSize [HEX_SIDE, HEX_SIDE];
}forEach HEX_GRID;

HEX_WEST = [
///	[[0, 0], "Alpha", "b_inf", 1, []],
	[[0, 0], "Alpha", "b_inf", 1, []],
	[[0, 1], "Bravo", "b_recon", 1, []]
];

{
	private _row = _x select 0;
	private _col = _x select 1;
	private _pos = [_row, _col] call HEX_FNC_HEX2POS;
	
	private _marker = createMarker [_x select 2, _pos];
	_marker setMarkerType (_x select 3);
	_marker setMarkerText (_x select 2);
}forEach HEX_WEST;

HEX_EAST = [
///	[[0, 0], "Alpha", "b_inf", 1, []],
	[[1, 0], "1st", "o_inf", 1, []],
	[[1, 1], "2nd", "o_recon", 1, []]
];

///_locations = nearestLocations [_rando select 2, ["NameCityCapital", "NameCity", "NameLocal", "NameVillage", "Hill"], HEX_SIDE];
///HEX_OBJECTIVES = [];
///{
///	HEX_OBJECTIVES pushback (position _x);
///}forEach _locations;

///if (count HEX_OBJECTIVES == 0) then {HEX_OBJECTIVES pushback (_rando select 2)};

///for "_i" from 1 to (3 - (count HEX_OBJECTIVES)) do {
///	private _pos = [
///		[[_rando select 2, HEX_SIDE]],
///		["water"],
///		{
///			{_this distance _x > (HEX_SIDE/4)}forEach HEX_OBJECTIVES;
///		}
///	] call BIS_fnc_randomPos;
///	HEX_OBJECTIVES pushback _pos;
///};

///{
///	private _name = "HEX_" + str _x;
///	private _marker = createMarker [_name, _x];
///	_marker setMarkerShape "ELLIPSE";
///	_marker setMarkerBrush "Border";
///	_marker setMarkerColor "ColorBLACK";
///	_marker setMarkerDir 90;
///	_marker setMarkerSize [HEX_SIDE/4, HEX_SIDE/4];
///}forEach HEX_OBJECTIVES;