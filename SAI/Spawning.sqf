SAI_SPAWN_INFANTRY = {
	private _side = _this select 0;

	private _base = SAI_POS_WEST;
	if (_side == SAI_EAST) then {_base = SAI_POS_EAST};
	private _pos = [_base, 0, SAI_DISTANCE, 5, 0, 0.5, 0, [], [_base]] call BIS_fnc_findSafePos;
	
	private _spawns = SAI_SPAWN_WEST_INF;
	if (_side == SAI_EAST) then {_spawns = SAI_SPAWN_EAST_INF};
	private _select = _spawns select floor random count _spawns;
	
	private _spawned = [_pos, _side, _select] call BIS_fnc_spawnGroup;
	{
		if (_side == SAI_WEST) then {addSwitchableUnit _x};
		_x setSkill 1;
	}forEach units _spawned;
};

SAI_SPAWN_VEHICLES = {
	private _side = _this select 0;
	
	private _base = SAI_POS_WEST;
	if (_side == SAI_EAST) then {_base = SAI_POS_EAST};
	private _pos = [_base, 0, SAI_DISTANCE, 5, 0, 0.5, 0, [], [_base]] call BIS_fnc_findSafePos;
	
	private _enybase = SAI_POS_EAST;
	if (_side == SAI_EAST) then {_enybase = SAI_POS_WEST};
	private _dir = _base getDir _enybase;
	
	
	private _categories = SAI_SPAWN_WEST;
	if (_side == SAI_EAST) then {_categories = SAI_SPAWN_EAST};
	private _spawns = _categories select floor random count _categories;
	private _select = _spawns select floor random count _spawns;
	
	private _spawned = [_pos, _dir, _select, _side] call BIS_fnc_spawnVehicle;
	{
		if (_side == SAI_WEST) then {addSwitchableUnit _x};
		_x setSkill 1;
	}forEach (_spawned select 1);
};

SAI_SPAWN_ARTILLERY = {
	private _side = _this select 0;
	
	private _base = SAI_POS_WEST;
	if (_side == SAI_EAST) then {_base = SAI_POS_EAST};
	private _enybase = SAI_POS_EAST;
	if (_side == SAI_EAST) then {_enybase = SAI_POS_WEST};
	
	private _dir = _base getDir _enybase;
	private _rear = _base getPos [SAI_DISTANCE / 2, -_dir];
	private _pos = [_rear, 0, SAI_DISTANCE / 2, 5, 0, 0.5, 0, [], [_rear]] call BIS_fnc_findSafePos;
	
	private _spawns = SAI_SPAWN_WEST_ART;
	if (_side == SAI_EAST) then {_spawns = SAI_SPAWN_EAST_ART};
	private _select = _spawns select floor random count _spawns;
	
	private _spawned = [_pos, _dir, _select, _side] call BIS_fnc_spawnVehicle;
	{
		if (_side == SAI_WEST) then {addSwitchableUnit _x};
		_x setSkill 1;
	}forEach (_spawned select 1);
};

SAI_SPAWN_AIRCRAFT = {
	private _side = _this select 0;
	
	private _spawns = SAI_SPAWN_WEST_PLA;
	if (_side == SAI_EAST) then {_spawns = SAI_SPAWN_EAST_PLA};
	private _select = _spawns select floor random count _spawns;
	private _pos = [] call BIS_fnc_randomPos;
	private _dir = random 360;
	
	private _spawned = [_pos, _dir, _select, _side] call BIS_fnc_spawnVehicle;
	{
		if (_side == SAI_WEST) then {addSwitchableUnit _x};
		_x setSkill 1;
	}forEach (_spawned select 1);
	
	private _wp = (_spawned select 2) addWaypoint [_pos, 0];
};

for "_i" from 1 to (3*SAI_CFG_SCALE) do {
[SAI_WEST] call SAI_SPAWN_INFANTRY;
[SAI_EAST] call SAI_SPAWN_INFANTRY;
[SAI_WEST] call SAI_SPAWN_VEHICLES;
[SAI_EAST] call SAI_SPAWN_VEHICLES;
};

for "_i" from 1 to (SAI_CFG_SCALE - 1) do {
[SAI_WEST] call SAI_SPAWN_ARTILLERY;
[SAI_EAST] call SAI_SPAWN_ARTILLERY;
[SAI_WEST] call SAI_SPAWN_AIRCRAFT;
[SAI_EAST] call SAI_SPAWN_AIRCRAFT;
};