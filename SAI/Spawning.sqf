SAI_SPAWNS = allMapMarkers select {(_x find "SAI_SPAWN_" == 0) && (markerAlpha _x == 1)};

{
	_position = getMarkerPos _x;
	_count = 4;
	if (getMarkerSize _x select 0 < 1) then {_count = 2};
	if (getMarkerSize _x select 0 > 1) then {_count = 6};
	
	_primary = [];
	_secondary = [];
	_infantry = [];
	_side = SAI_EAST;
	
	switch (getMarkerType _x) do {
		case "b_motor_inf": {_primary = SAI_SPAWN_WEST_ART, _secondary = SAI_SPAWN_WEST_MOT, _infantry = SAI_SPAWN_WEST_INF; _side = SAI_WEST};
		case "b_mech_inf": {_primary = SAI_SPAWN_WEST_ARM, _secondary = SAI_SPAWN_WEST_MEC, _infantry = SAI_SPAWN_WEST_INF; _side = SAI_WEST};
		case "b_recon": {_primary = SAI_SPAWN_WEST_PLA, _secondary = SAI_SPAWN_WEST_HEL, _infantry = SAI_SPAWN_WEST_INF; _side = SAI_WEST};
		case "b_support": {_primary = SAI_SPAWN_WEST_STA, _secondary = SAI_SPAWN_WEST_SUP, _infantry = SAI_SPAWN_WEST_INF; _side = SAI_WEST};
		case "b_unknown": {_primary = SAI_SPAWN_WEST_STA, _secondary = SAI_SPAWN_WEST_ANY, _infantry = SAI_SPAWN_WEST_INF; _side = SAI_WEST};
		
		case "o_motor_inf": {_primary = SAI_SPAWN_EAST_ART, _secondary = SAI_SPAWN_EAST_MOT, _infantry = SAI_SPAWN_EAST_INF; _side = SAI_EAST};
		case "o_mech_inf": {_primary = SAI_SPAWN_EAST_ARM, _secondary = SAI_SPAWN_EAST_MEC, _infantry = SAI_SPAWN_EAST_INF; _side = SAI_EAST};
		case "o_recon": {_primary = SAI_SPAWN_EAST_PLA, _secondary = SAI_SPAWN_EAST_HEL, _infantry = SAI_SPAWN_EAST_INF; _side = SAI_EAST};
		case "o_support": {_primary = SAI_SPAWN_EAST_STA, _secondary = SAI_SPAWN_EAST_SUP, _infantry = SAI_SPAWN_EAST_INF; _side = SAI_EAST};
		case "o_unknown": {_primary = SAI_SPAWN_EAST_STA, _secondary = SAI_SPAWN_EAST_ANY, _infantry = SAI_SPAWN_EAST_INF; _side = SAI_EAST};
	};

	for "_i" from 1 to _count do {
		_select = _infantry select floor random count _infantry;
		_pos = [_position, 0, 500, 5, 0, 0.5, 0, [], [_position]] call BIS_fnc_findSafePos;
		_group = [_pos, _side, _select, [], [], [1, 1]] call BIS_fnc_spawnGroup;
	};
	
	if (count _secondary > 0) then {
		for "_i" from 1 to (_count - 2) do {
			_select = _secondary select floor random count _secondary;
			_pos = [_position, 0, 500, 5, 0, 0.5, 0, [], [_position]] call BIS_fnc_findSafePos;
			_unit = [_pos, random 360, _select, _side] call BIS_fnc_spawnVehicle;
			_unit setSkill 1;
		}
	};
	
	if (count _primary > 0) then {
		for "_i" from 1 to (_count - 4) do {
			_select = _primary select floor random count _primary;
			_pos = [_position, 0, 500, 5, 0, 0.5, 0, [], [_position]] call BIS_fnc_findSafePos;
			_unit = [_pos, random 360, _select, _side] call BIS_fnc_spawnVehicle;
			_unit setSkill 1;
		}
	};
}forEach SAI_SPAWNS