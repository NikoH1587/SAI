{
	_position = getMarkerPos _x;
	_distance = 250;
	_count = 2;
	if (getMarkerSize _x select 0 < 1) then {_count = 1};
	if (getMarkerSize _x select 0 > 1) then {_count = 3};
	_inf = false;
	_sup = false;
	_spawn = [];
	switch (getMarkerType _x) do {
		case "o_inf": {_spawn = SAI_SPAWN_EAST_INF; _inf = true};
		case "o_motor_inf": {_spawn = SAI_SPAWN_EAST_MOT};
		case "o_mech_inf": {_spawn = SAI_SPAWN_EAST_MEC};
		case "o_armor": {_spawn = SAI_SPAWN_EAST_ARM};
		
		case "o_art": {_spawn = SAI_SPAWN_EAST_ART; _sup = true};
		case "o_support": {_spawn = SAI_SPAWN_EAST_SUP; _sup = true};
		case "o_air": {_spawn = SAI_SPAWN_EAST_AIR; _sup = true};
		case "o_installation": {_spawn = SAI_SPAWN_EAST_STA; _sup = true};
	};
	
	if (_inf == true) then {
		for "_i" from 1 to _count do {
			_select = _spawn select floor random count _spawn;
			_pos = [_position, 0, 500, 5, 0, 0.5, 0, [], [_position]] call BIS_fnc_findSafePos;
			_group = [_pos, SAI_EAST, _select, [], [], [1, 1]] call BIS_fnc_spawnGroup;
		};
	};
	
	if (_inf == false) then {
		for "_i" from 1 to (_count) do {
			_select = _spawn select floor random count _spawn;
			_pos = [_position, 0, _distance, 5, 0, 0.5, 0, [], [_position]] call BIS_fnc_findSafePos;
			_unit = [_pos, random 360, _select, SAI_EAST] call BIS_fnc_spawnVehicle;
			_crew = _unit select 1;
			{_x setSkill 1}forEach _crew;
		}
	};

	_x setMarkerAlpha 0.25;
}forEach SAI_SPAWN_EAST