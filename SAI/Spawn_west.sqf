{
	_position = getMarkerPos"SAI_WEST";
	_distance = 250;
	_count = 2;
	if (getMarkerSize _x select 0 < 1) then {_count = 1};
	if (getMarkerSize _x select 0 > 1) then {_count = 3};
	_inf = false;
	_sup = false;
	_spawn = [];
	switch (getMarkerType _x) do {
		case "b_inf": {_spawn = SAI_SPAWN_WEST_INF; _inf = true};
		case "b_motor_inf": {_spawn = SAI_SPAWN_WEST_MOT};
		case "b_mech_inf": {_spawn = SAI_SPAWN_WEST_MEC};
		case "b_armor": {_spawn = SAI_SPAWN_WEST_ARM};
		
		case "b_art": {_spawn = SAI_SPAWN_WEST_ART; _sup = true};
		case "b_support": {_spawn = SAI_SPAWN_WEST_SUP; _sup = true};
		case "b_air": {_spawn = SAI_SPAWN_WEST_AIR; _sup = true};
		case "b_installation": {_spawn = SAI_SPAWN_WEST_STA; _sup = true};
	};
	
	if (_sup) then {_position = getMarkerPos _x; _distance = _distance / 2};
	
	if (_inf == true) then {
		for "_i" from 1 to _count do {
			_select = _spawn select floor random count _spawn;
			_pos = [_position, 0, 500, 5, 0, 0.5, 0, [], [_position]] call BIS_fnc_findSafePos;
			_group = [_pos, SAI_WEST, _select, [], [], [1, 1]] call BIS_fnc_spawnGroup;
		};
	};
	
	if (_inf == false) then {
		for "_i" from 1 to (_count) do {
			_select = _spawn select floor random count _spawn;
			_pos = [_position, 0, _distance, 5, 0, 0.5, 0, [], [_position]] call BIS_fnc_findSafePos;
			_unit = [_pos, random 360, _select, SAI_WEST] call BIS_fnc_spawnVehicle;
			_crew = _unit select 1;
			{_x setSkill 1}forEach _crew;
		}
	};

	if (_sup == false) then {_x setMarkerAlpha 0.25};
}forEach SAI_SPAWN_WEST