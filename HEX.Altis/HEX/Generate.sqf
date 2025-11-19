/// HEX_GRID pushBack [[_row, _col], _marker, _pos, _brush, _side, []];

if (getMarkerPos "HEX_AO" select 0 == 0) then {
	"HEX_AO" setMarkerPos ([] call BIS_fnc_randomPos);
	HEX_OFFSET = floor (random 250);
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

        private _name = format ["HEX_%1_%2", _row, _col];
        if ([_x, _y] inArea "HEX_AO" == true && surfaceIsWater [_x,_y] == false) then {
			HEX_GRID pushBack [[_row, _col], [_x,_y], _name, []]
		};
    };
};

{
	private _pos = _x select 1;
	private _name = _x select 2;
	private _marker = createMarker [_name, _pos];
	_marker setMarkerShape "HEXAGON";
	_marker setMarkerBrush "Border";
	_marker setMarkerAlpha 0.5;
	_marker setMarkerDir 90;
	_marker setMarkerSize [HEX_SIDE, HEX_SIDE];
}forEach HEX_GRID;

{
	private _hexes = HEX_GRID select {count (_x select 3) == 0};
	private _hex = selectRandom _hexes;
	(_hex select 3) pushback _x;
}forEach HEX_CFG;

{
	private _pos = _x select 1;
	private _units = _x select 3;
	{
		private _posX = (_pos select 0) + (_forEachIndex * 10);
		private _posY = (_pos select 1) + (_forEachIndex * 10);
		private _marker = createMarker [_x select 1, [_posX, _posY]];
		_marker setMarkerType (_x select 1);
	}forEach _units;
}forEach HEX_GRID;

hint str HEX_GRID;
copyToClipBoard str HEX_GRID;

/// HEX_GRID pushBack [[_row, _col], _marker, _pos, _brush, _side, []];
/// 	[[0, 0], "Alpha", [0,0], "b_inf", 1, []],