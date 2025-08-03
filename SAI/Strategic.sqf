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
(count SAI_EAST_STA * 1) +
(count SAI_EAST_SUP * 1);

SAI_RECON_WEST = [];
SAI_DEFEND_WEST = [];
SAI_RECON_EAST = [];
SAI_DEFEND_EAST = [];

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
	case "NONE": {if (markerColor _marker != "ColorBLACK") then {_marker setMarkerColor "ColorBLACK"}; SAI_RECON_WEST append [_marker]; SAI_RECON_EAST append [_marker]};
	case "WEST": {if (markerColor _marker != "ColorWEST") then {_marker setMarkerColor "ColorWEST"}; SAI_DEFEND_WEST append [_marker]};
	case "EAST": {if (markerColor _marker != "ColorEAST") then {_marker setMarkerColor "ColorEAST"}; SAI_DEFEND_EAST append [_marker]};
	}
}forEach SAI_MARKERS;

if (count SAI_RECON_WEST == 0) then {SAI_RECON_WEST = SAI_DEFEND_WEST};
if (count SAI_RECON_EAST == 0) then {SAI_RECON_EAST = SAI_DEFEND_EAST};

if (_force_west > _force_east * 1.5) then {SAI_RECON_WEST = SAI_RECON_WEST + SAI_DEFEND_EAST};
if (_force_east > _force_west * 1.5) then {SAI_RECON_EAST = SAI_RECON_EAST + SAI_DEFEND_EAST};

SAI_FORCE_WEST = SAI_FORCE_WEST max _force_west;
SAI_FORCE_EAST = SAI_FORCE_EAST max _force_east;

if (false) then {
	private _percentWest = floor ((_force_west / SAI_FORCE_WEST) * 100);
	private _percentEast = floor ((_force_east / SAI_FORCE_EAST) * 100);
	private _conquestWest = floor ((SAI_DEFEND_WEST / (count SAI_MARKERS)) * 100);
	private _conquestEast = floor ((SAI_DEFEND_EAST / (count SAI_MARKERS)) * 100);
	player sideChat ("WEST CONQ: " + str _conquestWest + " DOM: " + str _percentWest + "%");
	player sideChat ("WEST CONQ: " + str _conquestEast + " DOM: " + str _percentEast + "%");
};