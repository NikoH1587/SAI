{
	_position = getMarkerPos _x;
	_buff = 2;
	if (getMarkerSize _x select 0 < 1) then {_buff = 1};
	if (getMarkerSize _x select 0 > 1) then {_buff = 3};
	_inf = false;
	_sup = false;
	_primary = [];
	_secondary = [];
	_infantry = [];
	_side = SAI_EAST;
	switch (getMarkerType _x) do {
		case "b_motor_inf": {_primary = SAI_SPAWN_WEST_ART; _secondary = SAI_SPAWN_WEST_MOT; _infantry = SAI_SPAWN_WEST_INF; _side = SAI_WEST};
		case "b_mech_inf": {_primary = SAI_SPAWN_WEST_ARM; _secondary = SAI_SPAWN_WEST_MEC; _infantry = SAI_SPAWN_WEST_INF; _side = SAI_WEST};
		case "b_recon": {_primary = SAI_SPAWN_WEST_PLA; _secondary = SAI_SPAWN_WEST_HEL; _infantry = SAI_SPAWN_WEST_INF; _side = SAI_WEST};
		case "b_unknown": {_primary = SAI_SPAWN_WEST_STA; _secondary = SAI_SPAWN_WEST_MOT; _infantry = SAI_SPAWN_WEST_INF; _side = SAI_WEST};
		case "b_hq": {_primary = SAI_SPAWN_LOG; _secondary = SAI_SPAWN_WEST_STA; _infantry = SAI_SPAWN_WEST_INF; _side = SAI_WEST};	
		
		case "o_motor_inf": {_primary = SAI_SPAWN_EAST_ART; _secondary = SAI_SPAWN_EAST_MOT; _infantry = SAI_SPAWN_EAST_INF; _side = SAI_EAST};
		case "o_mech_inf": {_primary = SAI_SPAWN_EAST_ARM; _secondary = SAI_SPAWN_EAST_MEC; _infantry = SAI_SPAWN_EAST_INF; _side = SAI_EAST};
		case "o_recon": {_primary = SAI_SPAWN_EAST_PLA; _secondary = SAI_SPAWN_EAST_HEL; _infantry = SAI_SPAWN_EAST_INF; _side = SAI_EAST};
		case "o_unknown": {_primary = SAI_SPAWN_EAST_STA; _secondary = SAI_SPAWN_EAST_MOT; _infantry = SAI_SPAWN_EAST_INF; _side = SAI_EAST};
		case "o_hq": {_primary = SAI_SPAWN_LOG; _secondary = SAI_SPAWN_EAST_STA; _infantry = SAI_SPAWN_EAST_INF; _side = SAI_EAST};			
	};

	for "_i" from 1 to (1 * _buff) do {
		_select = _primary select floor random count _primary;
		_pos = [_position, 0, SAI_DISTANCE, 5, 0, 0.5, 0, [], [_position]] call BIS_fnc_findSafePos;
		_unit = [_pos, random 360, _select, _side] call BIS_fnc_spawnVehicle;
		_crew = _unit select 1;
		{_x setSkill 1}forEach _crew;
	};
	
	for "_i" from 1 to (2 * _buff) do {
		_select = _secondary select floor random count _secondary;
		_pos = [_position, 0, SAI_DISTANCE, 5, 0, 0.5, 0, [], [_position]] call BIS_fnc_findSafePos;
		_unit = [_pos, random 360, _select, _side] call BIS_fnc_spawnVehicle;
		_crew = _unit select 1;
		{_x setSkill 1}forEach _crew;
	};
	
	for "_i" from 1 to (3 * _buff) do {
		_select = _infantry select floor random count _infantry;
		_pos = [_position, 0, SAI_DISTANCE, 5, 0, 0.5, 0, [], [_position]] call BIS_fnc_findSafePos;
		_group = [_pos, _side, _select, [], [], [1, 1]] call BIS_fnc_spawnGroup;
	};


	_x setMarkerAlpha 1;
}forEach SAI_SPAWNS;