{
	_position = getMarkerPos _x;
	_count = 2;
	if (getMarkerSize _x select 0 < 1) then {_count = 1};
	if (getMarkerSize _x select 0 > 1) then {_count = 3};
	_inf = false;
	_sup = false;
	_spawn = [];
	_side = SAI_EAST;
	switch (getMarkerType _x) do {
		case "b_inf": {_spawn = SAI_SPAWN_WEST_INF; _side = SAI_WEST; _inf = true};
		case "b_motor_inf": {_spawn = SAI_SPAWN_WEST_MOT; _side = SAI_WEST};
		case "b_mech_inf": {_spawn = SAI_SPAWN_WEST_MEC; _side = SAI_WEST};
		case "b_armor": {_spawn = SAI_SPAWN_WEST_ARM; _side = SAI_WEST};
		case "b_art": {_spawn = SAI_SPAWN_WEST_ART; _side = SAI_WEST; _sup = true};
		case "b_support": {_spawn = SAI_SPAWN_WEST_SUP; _side = SAI_WEST; _sup = true};
		case "b_air": {_spawn = SAI_SPAWN_WEST_AIR; _side = SAI_WEST; _sup = true};
		case "b_installation": {_spawn = SAI_SPAWN_WEST_STA; _side = SAI_WEST; _sup = true};
		
		case "o_inf": {_spawn = SAI_SPAWN_EAST_INF; _side = SAI_EAST; _inf = true};
		case "o_motor_inf": {_spawn = SAI_SPAWN_EAST_MOT; _side = SAI_EAST};
		case "o_mech_inf": {_spawn = SAI_SPAWN_EAST_MEC; _side = SAI_EAST};
		case "o_armor": {_spawn = SAI_SPAWN_EAST_ARM; _side = SAI_EAST};
		case "o_art": {_spawn = SAI_SPAWN_EAST_ART; _side = SAI_EAST; _sup = true};
		case "o_support": {_spawn = SAI_SPAWN_EAST_SUP; _side = SAI_EAST; _sup = true};
		case "o_air": {_spawn = SAI_SPAWN_EAST_AIR; _side = SAI_EAST; _sup = true};
		case "o_installation": {_spawn = SAI_SPAWN_EAST_STA; _side = SAI_EAST; _sup = true};
	};
	
	if (_inf == true) then {
		for "_i" from 1 to _count do {
			_select = _spawn select floor random count _spawn;
			_pos = [_position, 0, 250, 5, 0, 0.5, 0, [], [_position]] call BIS_fnc_findSafePos;
			_group = [_pos, _side, _select, [], [], [1, 1]] call BIS_fnc_spawnGroup;
		};
	};
	
	if (_inf == false) then {
		for "_i" from 1 to (_count) do {
			_select = _spawn select floor random count _spawn;
			_pos = [_position, 0, 250, 5, 0, 0.5, 0, [], [_position]] call BIS_fnc_findSafePos;
			_unit = [_pos, random 360, _select, _side] call BIS_fnc_spawnVehicle;
			_crew = _unit select 1;
			{_x setSkill 1}forEach _crew;
		}
	};

	if (_sup == false) then {_x setMarkerAlpha 0.25};
}forEach SAI_SPAWNS;