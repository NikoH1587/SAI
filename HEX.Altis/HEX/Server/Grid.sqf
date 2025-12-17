/// coord steps for grid
private _hexX = HEX_SIZE * 1.5;
private _hexY = HEX_SIZE * sqrt 3;
private _hexS = worldSize;
private _grid = [];
private _count = ((count HEX_CFG_WEST)* 3) + ((count HEX_CFG_EAST) * 3);
/// Grid config/save
for "_col" from 0 to round(_hexS / _hexX) do {
    for "_row" from 0 to round(_hexS / _hexY) do {

        private _offset = if (_col mod 2 == 0) then {0} else {_hexY / 2};
        private _x = _col * _hexX;
        private _y = _row * _hexY + _offset;

        if (_x > _hexS or _y > _hexS) exitWith {};
		private _land = false;
		private _landL = !(surfaceisWater [_x - (HEX_SIZE / 2), _y]);
		private _landR = !(surfaceisWater [_x + (HEX_SIZE / 2), _y]);
		private _landB = !(surfaceisWater [_x, _y - (HEX_SIZE / 2)]);
		private _landT = !(surfaceisWater [_x, _y + (HEX_SIZE / 2)]);
		{if (_x == true) then {_land = true}}forEach [_landL, _landR, _landB, _landT];
        if (_land) then {
			_grid pushBack [_row, _col, [_x,_y], "hd_dot", civilian, 0];
		};
    };
};

/// Random hex as origin of AO
if (getMarkerPos "HEX_AO" select 0 == 0) then {
	"HEX_AO" setMarkerSize [HEX_SIZE, HEX_SIZE];
	private _HEX = selectRandom _grid;
	private _pos = _HEX select 2;
	"HEX_AO" setMarkerPos _pos;
};

/// Expand AO outwards untill enough space for all counters?
for "_i" from 1 to 100 do {
	private _hexes = count HEX_GRID;
	if (_hexes < _count) then {
		HEX_GRID = [];
		private _size = getMarkerSize "HEX_AO";
		private _sizeX = _size select 0;
		private _sizeY = _size select 1;
		"HEX_AO" setMarkerSize [_sizeX + HEX_SIZE, _sizeY + HEX_SIZE];
		{
			private _hex = _x;
			private _pos = _x select 2;
			if (_pos inArea "HEX_AO") then {
				HEX_GRID pushback _hex;
			};
		}forEach _grid;
	};
};

/// Overlay rest of map
HEX_FLAG setPos getMarkerPos "HEX_AO";
private _aoSize = getMarkerSize "HEX_AO";
private _aoX = (_aoSize select 0) + HEX_SIZE;
private _aoY = (_aoSize select 1) + HEX_SIZE;
private _aoXY = [_aoX, _aoY, 0];
HEX_FLAG setVariable ["objectArea",_aoXY];
[HEX_FLAG, [], true] call BIS_fnc_moduleCoverMap;

/// Place initial counters;
{
	private _counter = _x;
	private _act = 1;
	if (_x in ["b_mech_inf", "b_armor","o_mech_inf", "o_armor"]) then {_act = 2};
	if (_x in ["b_motor_inf", "b_recon","o_motor_inf", "o_recon"]) then {_act = 3};
	private _sorted = [
		HEX_GRID, 
		[], 
		{
			private _pos = _x select 2;
			private _posX = _pos select 0;
			private _posY = _pos select 1;
			_result = _posY;
			if (HEX_SCENARIO == "N") then {_result = _posY};
			if (HEX_SCENARIO == "E") then {_result = _posX};
			if (HEX_SCENARIO == "S") then {_result = -_posY};
			if (HEX_SCENARIO == "W") then {_result = -_posX};
			_result
		}, 
		"DESCEND", 
		{(_x select 3) == "hd_dot"}
	] call BIS_fnc_sortBy;
	private _hex = selectRandom (_sorted select [0, 9]);
	_hex set [3, _counter];
	_hex set [4, west];
	_hex set [5, _act];
}forEach HEX_CFG_WEST;

/// Create grid overlay
{
	private _row = _x select 0;
	private _col = _x select 1;
	private _pos = _x select 2;
	private _sid = _x select 4;
	private _name = format ["HEX_%1_%2", _row, _col];
	private _marker = createMarker [_name, _pos];
	_marker setMarkerShape "HEXAGON";
	_marker setMarkerBrush "Border";
	_marker setMarkerDir 90;
	_marker setMarkerSize [HEX_SIZE, HEX_SIZE];
}forEach HEX_GRID;

publicVariable "HEX_GRID";
copyToClipBoard str HEX_GRID;