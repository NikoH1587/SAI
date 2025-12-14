/// HEX_GRID pushBack [[_row, _col], _marker, _pos, _brush, _side, []];

if (getMarkerPos "HEX_AO" select 0 == 0) then {
	"HEX_AO" setMarkerPos ([] call BIS_fnc_randomPos);
	HEX_OFFSET = floor (random 500);
	};
 
private _hexX = HEX_SIDE * 1.5;
private _hexY = HEX_SIDE * sqrt 3;
private _hexS = worldSize;

for "_col" from 0 to round(_hexS / _hexX) do {
    for "_row" from 0 to round(_hexS / _hexY) do {

        private _offset = if (_col mod 2 == 0) then {0} else {_hexY / 2};
        private _x = _col * _hexX + HEX_OFFSET;
        private _y = _row * _hexY + _offset + HEX_OFFSET;

        if (_x > _hexS or _y > _hexS) exitWith {};
		
        if ((count ([_x,_y] nearRoads (HEX_SIDE / 2)) > 0 or (surfaceisWater [_x, _y] == false)) && [_x, _y] inArea "HEX_AO" == true) then {
			HEX_GRID pushBack [_row, _col, [_x,_y], "hd_flag", resistance];
		};

///		if ([_x, _y] inArea "HEX_AO" == true && surfaceIsWater [_x,_y] == false) then {
///			HEX_GRID pushBack [_row, _col, [_x,_y], "hd_flag", resistance];
////	};
    };
};

/// temporary! places counters randomly
{
	private _hexes = HEX_GRID select {(_x select 3) == "hd_flag"};
	private _hex = selectRandom _hexes;
	_hex  set [3, _x];
	_hex  set [4, west];
}forEach HEX_CFG_WEST;

{
	private _hexes = HEX_GRID select {(_x select 3) == "hd_flag"};
	private _hex = selectRandom _hexes;
	_hex  set [3, _x];
	_hex  set [4, east];
}forEach HEX_CFG_EAST;

{
	private _row = _x select 0;
	private _col = _x select 1;
	private _pos = _x select 2;
    private _name = format ["HEX_%1_%2", _row, _col];
	private _marker = createMarker [_name, _pos];
	_marker setMarkerShape "HEXAGON";
	_marker setMarkerBrush "Border";
	_marker setMarkerAlpha 0.5;
	_marker setMarkerDir 90;
	_marker setMarkerSize [HEX_SIDE, HEX_SIDE];
}forEach HEX_GRID;

publicVariable "HEX_GRID";

hint str HEX_GRID;
copyToClipBoard str HEX_GRID;

