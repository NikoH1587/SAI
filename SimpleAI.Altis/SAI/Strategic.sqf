/// do respawn
private _westCount = 0;
private _eastCount = 0;

{
	if (_x select 1 in ["INF", "MOT", "MEC", "ARM"]) then {_westCount = _westCount + 1};
}forEach SAI_WEST_ALL;

{
	if (_x select 1 in ["INF", "MOT", "MEC", "ARM"]) then {_eastCount = _eastCount + 1};
}forEach SAI_EAST_ALL;

if (_westCount < SAI_CFG_SPAWNS_WEST && SAI_CFG_RESPAWNS_WEST > 1) then {
	private _sel = SAI_CFG_WEST_GRP select floor random count SAI_CFG_WEST_GRP;
	private _pos = [SAI_POS_REAR_WEST, 0, SAI_DISTANCE / 2, 10, 0, 0.5, 0, [], [SAI_POS_REAR_WEST]] call BIS_fnc_findSafePos;
	private _dir = _pos getDir SAI_POS_EAST;
	private _sid = SAI_WEST;
	[_sel, _pos, _dir, _sid] call SAI_SPAWN_GROUPS;
	_westCount = _westCount + 1;
	SAI_CFG_RESPAWNS_WEST = SAI_CFG_RESPAWNS_WEST - 1;
};

if (_eastCount < SAI_CFG_SPAWNS_EAST && SAI_CFG_RESPAWNS_EAST > 1) then {
	private _sel = SAI_CFG_EAST_GRP select floor random count SAI_CFG_EAST_GRP;
	private _pos = [SAI_POS_REAR_EAST, 0, SAI_DISTANCE / 2, 10, 0, 0.5, 0, [], [SAI_POS_REAR_EAST]] call BIS_fnc_findSafePos;
	private _dir = _pos getDir SAI_POS_WEST;
	private _sid = SAI_EAST;
	[_sel, _pos, _dir, _sid] call SAI_SPAWN_GROUPS;
	_eastCount = _eastCount + 1;
	SAI_CFG_RESPAWNS_EAST = SAI_CFG_RESPAWNS_EAST - 1;
};

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
		
		if (_posGrp distance _pos < SAI_DISTANCE) then {
			_west = _west + 1;
		};
	}forEach SAI_WEST_ALL;
	
	{
		private _posGrp = _x select 2;
		
		if (_posGrp distance _pos < SAI_DISTANCE) then {
			_east = _east + 1;
		};
	}forEach SAI_EAST_ALL;
	
	if (_west > _east * 1.5 && _west > (_westCount/3)) then {_side = "WEST";};
	if (_east > _west * 1.5 && _east > (_eastCount/3)) then {_side = "EAST";};
	
	switch (_side) do {
		case "NONE": {if (markerColor _marker == "ColorWEST") then {SAI_OBJ_WEST = SAI_OBJ_WEST + 1}};
		case "NONE": {if (markerColor _marker == "ColorEAST") then {SAI_OBJ_EAST = SAI_OBJ_EAST + 1}};
		case "WEST": {if (markerColor _marker != "ColorWEST") then {_marker setMarkerColor "ColorWEST"}; SAI_OBJ_WEST = SAI_OBJ_WEST + 1};
		case "EAST": {if (markerColor _marker != "ColorEAST") then {_marker setMarkerColor "ColorEAST"}; SAI_OBJ_EAST = SAI_OBJ_EAST + 1};
	};
}forEach ["SAI_WEST", "SAI_CENT", "SAI_EAST"];

/// switch between gambit/attack/defend
SAI_OBJECTIVE = "SAI_CENT";
if (SAI_OBJ_WEST > 1 or _westCount >= (_eastCount * 1.5)) then {SAI_OBJECTIVE = "SAI_EAST"};
if (SAI_OBJ_EAST > 1 or _eastCount >= (_westCount * 1.5)) then {SAI_OBJECTIVE = "SAI_WEST"};

[SAI_WEST, "WEST", ["OBJECTIVE description", "OBJECTIVE", "marker"], getMarkerPos SAI_OBJECTIVE, "CREATED", -1, true, "o", false] call BIS_fnc_taskCreate;

/// Track enemy positions for fire support solutions
SAI_ENY_WEST = [];
SAI_ENY_EAST = [];

{
	private _pos = getMarkerPos _x;
	private _typ = getMarkerType _x;
	private _alp = markerAlpha _x;
	
	if (_alp == 1) then {
		if ( _typ in ["o_unknown", "o_support", "o_air", "o_uav", "o_plane"] == false) then {SAI_ENY_WEST append [_pos]}
	}
}forEach SAI_MARKERS_EAST;

{
	private _pos = getMarkerPos _x;
	private _typ = getMarkerType _x;
	private _txt = markerText _x;
	
	if (_txt == "!") then {
		if ( _typ in ["b_unknown", "b_support", "b_air", "b_uav", "b_plane"] == false) then {SAI_ENY_EAST append [_pos]}
	}
}forEach SAI_MARKERS_WEST;

/// end game conditions
/// BIS_fnc_endMission leaves a key!!

/// CONQUEST victory:
if ((SAI_OBJ_WEST) == 3) then {["end1", true, 5] call BIS_fnc_endMission};

/// CONQEUST defeat:
if ((SAI_OBJ_EAST) == 3) then {["end2", false, 5] call BIS_fnc_endMission};