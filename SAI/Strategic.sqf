/// get forces ratio
private _force_west = 0;
{_force_west = _force_west + (_x select 3)}forEach SAI_WEST_ALL;
private _force_east = 0;
{_force_east = _force_east + (_x select 3)}forEach SAI_EAST_ALL;

SAI_OBJ_WEST = 0;
SAI_OBJ_EAST = 0;

{
	private _marker = _x;
	private _pos = getMarkerPos _marker;
	private _west = 0;
	private _east = 0;
	private _side = "NONE";

	{
		private _posGrp = _x select 2;
		private _valGrp = _x select 3;
		
		if (_posGrp distance _pos < SAI_DISTANCE) then {
			_west = _west + _valGrp;
		};
	}forEach SAI_WEST_ALL;
	
	{
		private _posGrp = _x select 2;
		private _valGrp = _x select 3;
		
		if (_posGrp distance _pos < SAI_DISTANCE) then {
			_east = _east + _valGrp;
		};
	}forEach SAI_EAST_ALL;
	
	if (_west > _east * 1.5 && _west > (_force_west / 4)) then {_side = "WEST";};
	if (_east > _west * 1.5 && _east > (_force_east / 4)) then {_side = "EAST";};
	
	switch (_side) do {
		case "NONE": {if (markerColor _marker == "ColorWEST") then {SAI_OBJ_WEST == SAI_OBJ_WEST + 1}};
		case "NONE": {if (markerColor _marker == "ColorEAST") then {SAI_OBJ_EAST == SAI_OBJ_EAST + 1}};
		case "WEST": {if (markerColor _marker != "ColorWEST") then {_marker setMarkerColor "ColorWEST"}; SAI_OBJ_WEST == SAI_OBJ_WEST + 1};
		case "EAST": {if (markerColor _marker != "ColorEAST") then {_marker setMarkerColor "ColorEAST"}; SAI_OBJ_EAST == SAI_OBJ_EAST + 1};
	};
}forEach ["SAI_WEST", "SAI_CENT", "SAI_EAST"];

/// switch between gambit/attack/defend
SAI_OBJECTIVE = "SAI_CENT";
if (_force_west > _force_east * 1.5 or SAI_OBJ_WEST > 1) then {SAI_OBJECTIVE = "SAI_EAST"};
if (_force_east > _force_west * 1.5 or SAI_OBJ_EAST > 1) then {SAI_OBJECTIVE = "SAI_WEST"};

/// destruction victory tracking
SAI_FORCE_WEST = SAI_FORCE_WEST max _force_west;
SAI_FORCE_EAST = SAI_FORCE_EAST max _force_east;

/// Track enemy positions for fire support solutions
SAI_ENY_WEST = [];

{
	private _grp = _x select 0;
	private _typ = _x select 1;
	private _pos = _x select 2;
	private _found = false;
	private _idx = groupId _grp;
	private _mrk = format ["SAI_EAST_%1", _idx];
	
	{if ((_x select 2) distance _pos < 500) then {_found = true}}forEach SAI_WEST_ALL;
	if (_found && (_typ in ["HEL", "PLA", "UAV"] == false)) then {
		SAI_ENY_WEST append [_pos];
		_mrk setMarkerPos _pos;
		if (markerAlpha _mrk != 1) then {_mrk setMarkerAlpha 1}
	} else {
		if !(_typ in ["HEL", "PLA", "UAV"]) then {if (markerAlpha _mrk != 0) then {_mrk setMarkerAlpha 0}}
	};
	
	if (_typ in ["HEL", "PLA", "UAV"]) then {
		_mrk setMarkerPos _pos;
		if (markerAlpha _mrk != 1) then {_mrk setMarkerAlpha 1}
	};
}forEach SAI_EAST_ALL;

SAI_ENY_EAST = [];

{
	private _grp = _x select 0;
	private _typ = _x select 1;
	private _pos = _x select 2;
	private _found = false;
	
	{if ((_x select 2) distance _pos < 500) then {_found = true}}forEach SAI_EAST_ALL;
	if (_found && (_typ in ["HEL", "PLA", "UAV"] == false)) then {SAI_ENY_EAST append [_pos]};
}forEach SAI_WEST_ALL;


