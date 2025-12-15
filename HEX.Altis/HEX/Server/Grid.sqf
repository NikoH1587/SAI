/// HEX_GRID pushBack [[_row, _col], _marker, _pos, _brush, _side, []];

/// chang later
if (getMarkerPos "HEX_AO" select 0 == 0) then {
	"HEX_AO" setMarkerPos ([] call BIS_fnc_randomPos);
	HEX_OFFSET = floor (random 500);
	};
 
/// coord steps for grid
private _hexX = HEX_SIDE * 1.5;
private _hexY = HEX_SIDE * sqrt 3;
private _hexS = worldSize;

/// Creates THE grid
for "_col" from 0 to round(_hexS / _hexX) do {
    for "_row" from 0 to round(_hexS / _hexY) do {

        private _offset = if (_col mod 2 == 0) then {0} else {_hexY / 2};
        private _x = _col * _hexX + HEX_OFFSET;
        private _y = _row * _hexY + _offset + HEX_OFFSET;

        if (_x > _hexS or _y > _hexS) exitWith {};
		
        if ((count ([_x,_y] nearRoads (HEX_SIDE / 2)) > 0 or (surfaceisWater [_x, _y] == false)) && [_x, _y] inArea "HEX_AO" == true) then {
			HEX_GRID pushBack [_row, _col, [_x,_y], "Invisible", civilian, 0];
		};
    };
};

/// Place counters
{
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
		{(_x select 3) == "Invisible"}
	] call BIS_fnc_sortBy;
	private _hex = selectRandom (_sorted select [0, 3]);
	if (HEX_SCENARIO == "R") then {_hex = selectRandom (_sorted select [0, 9])};
	_hex set [3, _x];
	_hex set [4, west];
	_hex set [5, 1];
}forEach HEX_CFG_WEST;

{
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
		{(_x select 3) == "Invisible"}
	] call BIS_fnc_sortBy;
	private _hex = selectRandom (_sorted select [0, 3]);
	if (HEX_SCENARIO == "R") then {_hex = selectRandom (_sorted select [0, 9])};
	_hex set [3, _x];
	_hex set [4, east];
	_hex set [5, 1];
}forEach HEX_CFG_EAST;

/// Create counters
{
	private _row = _x select 0;
	private _col = _x select 1;
	private _pos = _x select 2;
	private _cfg = _x select 3;
	private _sid = _x select 4;

	_location = createLocation [_cfg, _pos, _row, _col];
	_location setSide _sid;
	HEX_LOCS pushback _location;
	
	/// Create GRID overlay
	private _name = format ["HEX_%1", _pos];
	private _marker = createMarker [_name, _pos];
	_marker setMarkerShape "HEXAGON";
	_marker setMarkerBrush "Border";
	_marker setMarkerDir 90;
	_marker setMarkerSize [HEX_SIDE, HEX_SIDE];
}forEach HEX_GRID;

publicVariable "HEX_GRID";
/// Fog of war?
hint str HEX_LOCS;
copyToClipBoard str HEX_GRID;

