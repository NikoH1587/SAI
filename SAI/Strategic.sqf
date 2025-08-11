private _westX = 0;
private _westY = 0;
private _eastX = 0;
private _eastY = 0;

private _force_west = 
(count SAI_WEST_INF * 1) +
(count SAI_WEST_LOG * 1) +
(count SAI_WEST_MOT * 2) +
(count SAI_WEST_MEC * 3) +
(count SAI_WEST_ARM * 4) +
(count SAI_WEST_HEL * 3) +
(count SAI_WEST_PLA * 4) +
(count SAI_WEST_ART * 5) +
(count SAI_WEST_STA * 1) +
(count SAI_WEST_SUP * 1);

private _force_east =
(count SAI_EAST_INF * 1) +
(count SAI_EAST_LOG * 1) +
(count SAI_EAST_MOT * 2) +
(count SAI_EAST_MEC * 3) +
(count SAI_EAST_ARM * 4) +
(count SAI_EAST_HEL * 3) +
(count SAI_EAST_PLA * 4) +
(count SAI_EAST_ART * 5) +
(count SAI_EAST_STA * 1) +
(count SAI_EAST_SUP * 1);

SAI_WEST_OBJ = [];
SAI_EAST_OBJ = [];
SAI_NEUT_OBJ = [];
{
	private _marker = _x;
	private _pos = getMarkerPos _marker;
	private _west = 0;
	private _east = 0;
	private _side = "NONE";
	private _entities = _pos nearEntities SAI_DISTANCE;
	
	{
		if (alive _x) then {
			if (side _x == SAI_WEST) then {_west = _west + 1};
			if (side _x == SAI_EAST) then {_east = _east + 1};
		}
	}forEach _entities;
	
	if (_west > _east * 1.5) then {_side = "WEST"};
	if (_east > _west * 1.5) then {_side = "EAST"};
	
	switch (_side) do {
	case "NONE": {if (markerColor _marker != "ColorBLACK") then {_marker setMarkerColor "ColorBLACK"}; SAI_NEUT_OBJ append [_pos]};
	case "WEST": {if (markerColor _marker != "ColorWEST") then {_marker setMarkerColor "ColorWEST"}; SAI_WEST_OBJ append [_pos]};
	case "EAST": {if (markerColor _marker != "ColorEAST") then {_marker setMarkerColor "ColorEAST"}; SAI_EAST_OBJ append [_pos]};
	}
}forEach SAI_MARKERS;

if (_force_west > _force_east * 1.5) then {SAI_NEUT_OBJ append SAI_EAST_OBJ};
if (_force_east > _force_west * 1.5) then {SAI_NEUT_OBJ append SAI_WEST_OBJ};

if (count SAI_NEUT_OBJ == 0) then {(SAI_WEST_OBJ + SAI_EAST_OBJ) select floor random count (SAI_WEST_OBJ + SAI_EAST_OBJ)};

SAI_FORCE_WEST = SAI_FORCE_WEST max _force_west;
SAI_FORCE_EAST = SAI_FORCE_EAST max _force_east;

SAI_WEST_ENEMIES = [[0, 0, 0]];
SAI_EAST_ENEMIES = [[0, 0, 0]];

{
	if ((SAI_WEST knowsAbout _x) > 0 && (side _x == SAI_EAST) && alive _x) then {
		private _pos = getPos _x;
		SAI_WEST_ENEMIES append [_pos];
		private _grp = group _x;
		private _idx = groupId _grp;
		private _mrk = format ["SAI_EAST_%1", _idx];
		if (markerAlpha _mrk == 0) then {
			_mrk setMarkerAlpha 1;
		};
	};
	
	if ((SAI_EAST knowsAbout _x) > 0 && (side _x == SAI_WEST) && alive _x) then {
		private _pos = getPos _x;
		SAI_EAST_ENEMIES append [_pos];
	};
}forEach allUnits;

if (false) then {
	private _percentWest = floor ((_force_west / SAI_FORCE_WEST) * 100);
	private _percentEast = floor ((_force_east / SAI_FORCE_EAST) * 100);
	private _conquestWest = floor ((SAI_DEFEND_WEST / (count SAI_MARKERS)) * 100);
	private _conquestEast = floor ((SAI_DEFEND_EAST / (count SAI_MARKERS)) * 100);
	player sideChat ("WEST CONQ: " + str _conquestWest + " DOM: " + str _percentWest + "%");
	player sideChat ("WEST CONQ: " + str _conquestEast + " DOM: " + str _percentEast + "%");
};