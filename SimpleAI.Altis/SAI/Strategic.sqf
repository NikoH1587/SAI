/// do respawn
private _westCount = count SAI_WEST_ALL;
private _eastCount = count SAI_EAST_ALL;

if ((_westCount - 5) < SAI_CFG_SPAWNS_WEST && SAI_CFG_RESPAWNS_WEST > 1) then {
	[SAI_WEST, SAI_POS_REAR_WEST] call SAI_SPAWN_INFANTRY;
	[SAI_WEST, SAI_POS_REAR_WEST] call SAI_SPAWN_VEHICLES;
	SAI_CFG_RESPAWNS_WEST = SAI_CFG_RESPAWNS_WEST - 2;
};

if ((_eastCount - 5) < SAI_CFG_SPAWNS_EAST && SAI_CFG_RESPAWNS_EAST > 1) then {
	[SAI_EAST, SAI_POS_REAR_EAST] call SAI_SPAWN_INFANTRY;
	[SAI_EAST, SAI_POS_REAR_EAST] call SAI_SPAWN_VEHICLES;
	SAI_CFG_RESPAWNS_EAST = SAI_CFG_RESPAWNS_EAST - 2;
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
if (SAI_OBJ_WEST > 1 or (count SAI_WEST_ALL) > ((count SAI_EAST_ALL) * 1.5)) then {SAI_OBJECTIVE = "SAI_EAST"};
if (SAI_OBJ_EAST > 1 or (count SAI_EAST_ALL) > ((count SAI_WEST_ALL) * 1.5)) then {SAI_OBJECTIVE = "SAI_WEST"};

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