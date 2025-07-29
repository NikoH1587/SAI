for "_i" from 1 to ((4 - SAI_CFG_DIFFICULTY) * SAI_CFG_SCALE) do {
	if (count SAI_SPAWN_WEST > 0) then {
		_rando = SAI_SPAWN_WEST select floor random count SAI_SPAWN_WEST;
		_select = _rando select floor random count _rando;
		_pos = [SAI_POS_WEST, 0, SAI_DISTANCE/2, 5, 0, 0.5, 0, [], [SAI_POS_WEST]] call BIS_fnc_findSafePos;
		_unit = [_pos, random 360, _select, SAI_WEST] call BIS_fnc_spawnVehicle;
		_veh = _unit select 0;
		_crew = _unit select 1;
		_veh setVehicleAmmo (SAI_SUPPLY_WEST max random 1);
		{
		_x setSkill (SAI_MORALE_WEST max random 1);
		addSwitchableUnit _x;
		}forEach _crew;
	}
};

for "_i" from 1 to (SAI_CFG_SCALE - 1) do {
	if (count SAI_SPAWN_WEST_SUP > 0) then {
		_select = SAI_SPAWN_WEST_SUP select floor random count SAI_SPAWN_WEST_SUP;
		_pos = [SAI_POS_WEST, 0, SAI_DISTANCE/2, 5, 0, 0.5, 0, [], [SAI_POS_WEST]] call BIS_fnc_findSafePos;
		_unit = [_pos, random 360, _select, SAI_WEST] call BIS_fnc_spawnVehicle;
		_veh = _unit select 0;
		_crew = _unit select 1;
		_veh setVehicleAmmo (SAI_SUPPLY_WEST max random 1);
		{
		_x setSkill (SAI_MORALE_WEST max random 1);
		addSwitchableUnit _x;
		}forEach _crew;
	};
};

for "_i" from 1 to (SAI_CFG_SCALE - 1) do {
	if (count SAI_SPAWN_WEST_ART > 0) then {
		_select = SAI_SPAWN_WEST_ART select floor random count SAI_SPAWN_WEST_ART;
		_pos = [SAI_POS_WEST, 0, SAI_DISTANCE/2, 5, 0, 0.5, 0, [], [SAI_POS_WEST]] call BIS_fnc_findSafePos;
		_unit = [_pos, random 360, _select, SAI_WEST] call BIS_fnc_spawnVehicle;
		_veh = _unit select 0;
		_crew = _unit select 1;
		_veh setVehicleAmmo (SAI_SUPPLY_WEST max random 1);
		{
		_x setSkill (SAI_MORALE_WEST max random 1);
		addSwitchableUnit _x;
		}forEach _crew;
	};
};
	
for "_i" from 1 to ((4 - SAI_CFG_DIFFICULTY) * SAI_CFG_SCALE) do {
	_select = SAI_SPAWN_WEST_INF select floor random count SAI_SPAWN_WEST_INF;
	_pos = [SAI_POS_WEST, 0, SAI_DISTANCE/2, 5, 0, 0.5, 0, [], [SAI_POS_WEST]] call BIS_fnc_findSafePos;
	_group = [_pos, SAI_WEST, _select, [], [], [SAI_MORALE_WEST, 1], [SAI_SUPPLY_WEST, 1]] call BIS_fnc_spawnGroup;
	{
	addSwitchableUnit _x;	
	}forEach units _group;
};

for "_i" from 1 to ((4 + SAI_CFG_DIFFICULTY) * SAI_CFG_SCALE) do {
	if (count SAI_SPAWN_EAST > 0) then {
		_rando = SAI_SPAWN_EAST select floor random count SAI_SPAWN_EAST;
		_select = _rando select floor random count _rando;
		_pos = [SAI_POS_EAST, 0, SAI_DISTANCE/2, 5, 0, 0.5, 0, [], [SAI_POS_EAST]] call BIS_fnc_findSafePos;
		_unit = [_pos, random 360, _select, SAI_EAST] call BIS_fnc_spawnVehicle;
		_veh = _unit select 0;
		_crew = _unit select 1;
		_veh setVehicleAmmo (SAI_SUPPLY_EAST max random 1);
		{
		_x setSkill (SAI_MORALE_EAST max random 1);
		addSwitchableUnit _x;
		}forEach _crew;
	}
};

for "_i" from 1 to (SAI_CFG_SCALE - 1) do {
	if (count SAI_SPAWN_EAST_SUP > 0) then {
		_select = SAI_SPAWN_EAST_SUP select floor random count SAI_SPAWN_EAST_SUP;
		_pos = [SAI_POS_EAST, 0, SAI_DISTANCE/2, 5, 0, 0.5, 0, [], [SAI_POS_EAST]] call BIS_fnc_findSafePos;
		_unit = [_pos, random 360, _select, SAI_EAST] call BIS_fnc_spawnVehicle;
		_veh = _unit select 0;
		_crew = _unit select 1;
		_veh setVehicleAmmo (SAI_SUPPLY_EAST max random 1);
		{
		_x setSkill (SAI_MORALE_EAST max random 1);
		addSwitchableUnit _x;
		}forEach _crew;
	};
};

for "_i" from 1 to (SAI_CFG_SCALE - 1) do {
	if (count SAI_SPAWN_EAST_ART > 0) then {
		_select = SAI_SPAWN_EAST_ART select floor random count SAI_SPAWN_EAST_ART;
		_pos = [SAI_POS_EAST, 0, SAI_DISTANCE/2, 5, 0, 0.5, 0, [], [SAI_POS_EAST]] call BIS_fnc_findSafePos;
		_unit = [_pos, random 360, _select, SAI_EAST] call BIS_fnc_spawnVehicle;
		_veh = _unit select 0;
		_crew = _unit select 1;
		_veh setVehicleAmmo (SAI_SUPPLY_EAST max random 1);
		{
		_x setSkill (SAI_MORALE_EAST max random 1);
		addSwitchableUnit _x;
		}forEach _crew;
	};
};
	
for "_i" from 1 to ((4 + SAI_CFG_DIFFICULTY) * SAI_CFG_SCALE) do {
	_select = SAI_SPAWN_EAST_INF select floor random count SAI_SPAWN_EAST_INF;
	_pos = [SAI_POS_EAST, 0, SAI_DISTANCE/2, 5, 0, 0.5, 0, [], [SAI_POS_EAST]] call BIS_fnc_findSafePos;
	_group = [_pos, SAI_EAST, _select, [], [], [SAI_MORALE_EAST, 1], [SAI_SUPPLY_EAST, 1]] call BIS_fnc_spawnGroup;
	{
	addSwitchableUnit _x;	
	}forEach units _group;
};

if (SAI_DEBUG) then {
	{SAI_CURATOR addCuratorEditableObjects [[_x], true]}forEach allunits;
	{SAI_CURATOR addCuratorEditableObjects [[_x], true]}forEach vehicles;
};