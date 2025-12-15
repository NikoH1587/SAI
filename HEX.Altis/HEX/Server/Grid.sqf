/// change later
if (getMarkerPos "HEX_AO" select 0 == 0) then {
	"HEX_AO" setMarkerPos ([] call BIS_fnc_randomPos);
	};
 
/// coord steps for grid
private _hexX = HEX_SIZE * 1.5;
private _hexY = HEX_SIZE * sqrt 3;
private _hexS = worldSize;

/// Grid config/save
for "_col" from 0 to round(_hexS / _hexX) do {
    for "_row" from 0 to round(_hexS / _hexY) do {

        private _offset = if (_col mod 2 == 0) then {0} else {_hexY / 2};
        private _x = _col * _hexX;
        private _y = _row * _hexY + _offset;

        if (_x > _hexS or _y > _hexS) exitWith {};
		
        if ((count ([_x,_y] nearRoads (HEX_SIZE / 2)) > 0 or (surfaceisWater [_x, _y] == false)) && [_x, _y] inArea "HEX_AO" == true) then {
			HEX_GRID pushBack [_row, _col, [_x,_y], "hd_dot", civilian, 0];
		};
    };
};

/// Create grid overlay
{
	private _row = _x select 0;
	private _col = _x select 1;
	private _pos = _x select 2;
	private _name = format ["HEX_%1_%2", _row, _col];
	private _marker = createMarker [_name, _pos];
	_marker setMarkerShape "HEXAGON";
	_marker setMarkerBrush "Border";
	_marker setMarkerDir 90;
	_marker setMarkerSize [HEX_SIZE, HEX_SIZE];
}forEach HEX_GRID;

/// Off-map reserve pool?

private _max = floor ((count HEX_GRID)/2);

/// Place counters
{
	private _counter = _x;
	if (_forEachIndex < _max) then {
		private _sorted = [
			HEX_GRID, 
			[], 
			{
				private _pos = _x select 2;
				private _posX = _pos select 0;
				private _posY = _pos select 1;
				_result = _posX - _posY;
				if (HEX_SCENARIO == "S") then {_result = _posX + _posY};
				if (HEX_SCENARIO == "R") then {_result = _posX};
				_result
			}, 
			"ASCEND", 
			{(_x select 3) == "hd_dot"}
		] call BIS_fnc_sortBy;
		private _hex = selectRandom (_sorted select [0, 3]);
		if (HEX_SCENARIO == "R") then {_hex = selectRandom (_sorted select [0, 9])};
		_hex set [3, _counter];
		_hex set [4, west];
		_hex set [5, 1];
	};
}forEach HEX_CFG_WEST;

{
	private _counter = _x;
	if (_forEachIndex < _max) then {
		private _sorted = [
			HEX_GRID, 
			[], 
			{
				private _pos = _x select 2;
				private _posX = _pos select 0;
				private _posY = _pos select 1;
				_result = _posX - _posY;
				if (HEX_SCENARIO == "S") then {_result = _posX + _posY};
				if (HEX_SCENARIO == "R") then {_result = _posX};
				_result
			}, 
			"DESCEND", 
			{(_x select 3) == "hd_dot"}
		] call BIS_fnc_sortBy;
		private _hex = selectRandom (_sorted select [0, 3]);
		if (HEX_SCENARIO == "R") then {_hex = selectRandom (_sorted select [0, 9])};
		_hex set [3, _counter];
		_hex set [4, east];
		_hex set [5, 1];
	};
}forEach HEX_CFG_EAST;

publicVariable "HEX_GRID";
copyToClipBoard str HEX_GRID;