for "_i" from 1 to ((4 - SAI_CFG_DIFFICULTY) * SAI_CFG_SCALE) do {
	if (count SAI_SPAWN_WEST > 0) then {
		private _rando = SAI_SPAWN_WEST select floor random count SAI_SPAWN_WEST;
		private _select = _rando select floor random count _rando;
		private _pos = [SAI_POS_WEST, 0, SAI_DISTANCE, 5, 0, 0.5, 0, [], [SAI_POS_WEST]] call BIS_fnc_findSafePos;
		private _dir = _pos getDir SAI_POS_EAST;
		private _unit = [_pos, _dir, _select, SAI_WEST] call BIS_fnc_spawnVehicle;
		private _veh = _unit select 0;
		private _crew = _unit select 1;
		_veh setVehicleAmmo (SAI_SUPPLY_WEST max random 1);
		{
			_x setSkill (SAI_MORALE_WEST max random 1);
			addSwitchableUnit _x;
		}forEach _crew;
	}
};

for "_i" from 1 to (SAI_CFG_SCALE - 1) do {
	if (count SAI_SPAWN_WEST_SUP > 0) then {
		private _select = SAI_SPAWN_WEST_SUP select floor random count SAI_SPAWN_WEST_SUP;
		private _pos = [SAI_POS_WEST, 0, SAI_DISTANCE, 5, 0, 0.5, 0, [], [SAI_POS_WEST]] call BIS_fnc_findSafePos;
		private _unit = [_pos, random 360, _select, SAI_WEST] call BIS_fnc_spawnVehicle;
		private _veh = _unit select 0;
		private _crew = _unit select 1;
		_veh setVehicleAmmo (SAI_SUPPLY_WEST max random 1);
		{
			_x setSkill (SAI_MORALE_WEST max random 1);
			addSwitchableUnit _x;
		}forEach _crew;
	};
};

for "_i" from 1 to (SAI_CFG_SCALE - 1) do {
	if (count SAI_SPAWN_WEST_ART > 0) then {
		private _select = SAI_SPAWN_WEST_ART select floor random count SAI_SPAWN_WEST_ART;
		private _pos = [SAI_POS_WEST, 0, SAI_DISTANCE, 5, 0, 0.5, 0, [], [SAI_POS_WEST]] call BIS_fnc_findSafePos;
		private _dir = _pos getDir SAI_POS_EAST;
		private _unit = [_pos, _dir, _select, SAI_WEST] call BIS_fnc_spawnVehicle;
		private _veh = _unit select 0;
		private _crew = _unit select 1;
		_veh setVehicleAmmo (SAI_SUPPLY_WEST max random 1);
		{
			_x setSkill (SAI_MORALE_WEST max random 1);
			addSwitchableUnit _x;
		}forEach _crew;
	};
};
	
for "_i" from 1 to ((4 - SAI_CFG_DIFFICULTY) * SAI_CFG_SCALE) do {
	private _select = SAI_SPAWN_WEST_INF select floor random count SAI_SPAWN_WEST_INF;
	private _pos = [SAI_POS_WEST, 0, SAI_DISTANCE, 5, 0, 0.5, 0, [], [SAI_POS_WEST]] call BIS_fnc_findSafePos;
	private _group = [_pos, SAI_WEST, _select, [], [], [SAI_MORALE_WEST, 1], [SAI_SUPPLY_WEST, 1]] call BIS_fnc_spawnGroup;
	{
		addSwitchableUnit _x;	
	}forEach units _group;
};

for "_i" from 1 to ((4 + SAI_CFG_DIFFICULTY) * SAI_CFG_SCALE) do {
	if (count SAI_SPAWN_EAST > 0) then {
		private _rando = SAI_SPAWN_EAST select floor random count SAI_SPAWN_EAST;
		private _select = _rando select floor random count _rando;
		private _pos = [SAI_POS_EAST, 0, SAI_DISTANCE, 5, 0, 0.5, 0, [], [SAI_POS_EAST]] call BIS_fnc_findSafePos;
		private _dir = _pos getDir SAI_POS_WEST;		
		private _unit = [_pos, _dir, _select, SAI_EAST] call BIS_fnc_spawnVehicle;
		private _veh = _unit select 0;
		private _crew = _unit select 1;
		_veh setVehicleAmmo (SAI_SUPPLY_EAST max random 1);
		{
			_x setSkill (SAI_MORALE_EAST max random 1);
			addSwitchableUnit _x;
		}forEach _crew;
	}
};

for "_i" from 1 to (SAI_CFG_SCALE - 1) do {
	if (count SAI_SPAWN_EAST_SUP > 0) then {
		private _select = SAI_SPAWN_EAST_SUP select floor random count SAI_SPAWN_EAST_SUP;
		private _pos = [SAI_POS_EAST, 0, SAI_DISTANCE, 5, 0, 0.5, 0, [], [SAI_POS_EAST]] call BIS_fnc_findSafePos;
		private _unit = [_pos, random 360, _select, SAI_EAST] call BIS_fnc_spawnVehicle;
		private _veh = _unit select 0;
		private _crew = _unit select 1;
		_veh setVehicleAmmo (SAI_SUPPLY_EAST max random 1);
		{
			_x setSkill (SAI_MORALE_EAST max random 1);
			addSwitchableUnit _x;
		}forEach _crew;
	};
};

for "_i" from 1 to (SAI_CFG_SCALE - 1) do {
	if (count SAI_SPAWN_EAST_ART > 0) then {
		private _select = SAI_SPAWN_EAST_ART select floor random count SAI_SPAWN_EAST_ART;
		private _pos = [SAI_POS_EAST, 0, SAI_DISTANCE, 5, 0, 0.5, 0, [], [SAI_POS_EAST]] call BIS_fnc_findSafePos;
		private _dir = _pos getDir SAI_POS_WEST;
		private _unit = [_pos, _dir, _select, SAI_EAST] call BIS_fnc_spawnVehicle;
		private _veh = _unit select 0;
		private _crew = _unit select 1;
		_veh setVehicleAmmo (SAI_SUPPLY_EAST max random 1);
		{
			_x setSkill (SAI_MORALE_EAST max random 1);
			addSwitchableUnit _x;
		}forEach _crew;
	};
};
	
for "_i" from 1 to ((4 + SAI_CFG_DIFFICULTY) * SAI_CFG_SCALE) do {
	private _select = SAI_SPAWN_EAST_INF select floor random count SAI_SPAWN_EAST_INF;
	private _pos = [SAI_POS_EAST, 0, SAI_DISTANCE, 5, 0, 0.5, 0, [], [SAI_POS_EAST]] call BIS_fnc_findSafePos;
	private _group = [_pos, SAI_EAST, _select, [], [], [SAI_MORALE_EAST, 1], [SAI_SUPPLY_EAST, 1]] call BIS_fnc_spawnGroup;
	{
		addSwitchableUnit _x;	
	}forEach units _group;
};

if (SAI_DEBUG) then {
	{SAI_CURATOR addCuratorEditableObjects [[_x], true]}forEach allunits;
	{SAI_CURATOR addCuratorEditableObjects [[_x], true]}forEach vehicles;
};