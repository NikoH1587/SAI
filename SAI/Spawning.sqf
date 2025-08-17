SAI_SPAWN_INFANTRY = {
	private _side = _this select 0;
	private _base = _this select 1;

	private _pos = [_base, 0, SAI_DISTANCE, 5, 0, 0.5, 0, [], [_base]] call BIS_fnc_findSafePos;
	
	private _spawns = SAI_SPAWN_WEST_INF;
	if (_side == SAI_EAST) then {_spawns = SAI_SPAWN_EAST_INF};
	private _select = _spawns select floor random count _spawns;
	
	private _spawned = [_pos, _side, _select] call BIS_fnc_spawnGroup;
	{
		if (_side == SAI_WEST) then {addSwitchableUnit _x};
		_x setSkill 1;
		if (SAI_FSM) then {_x disableAI "FSM"};
	}forEach units _spawned;
};

SAI_SPAWN_VEHICLES = {
	private _side = _this select 0;
	private _base = _this select 1;
	
	private _pos = [_base, 0, SAI_DISTANCE, 5, 0, 0.5, 0, [], [_base]] call BIS_fnc_findSafePos;
	
	private _enybase = SAI_POS_EAST;
	if (_side == SAI_EAST) then {_enybase = SAI_POS_WEST};
	private _dir = _base getDir _enybase;
	
	
	private _categories = SAI_SPAWN_WEST;
	if (_side == SAI_EAST) then {_categories = SAI_SPAWN_EAST};
	if (count _categories > 0) then {
		private _spawns = _categories select floor random count _categories;
		private _select = _spawns select floor random count _spawns;
	
		private _spawned = [_pos, _dir, _select, _side] call BIS_fnc_spawnVehicle;
	
		{
			if (_side == SAI_WEST) then {addSwitchableUnit _x};
			_x setSkill 1;
			if (SAI_FSM) then {_x disableAI "FSM"};
		}forEach (_spawned select 1);
	} else {
		[_side, _base] call SAI_SPAWN_INFANTRY;
	};
};

SAI_SPAWN_ARTILLERY = {
	private _side = _this select 0;
	private _base = _this select 1;
	
	private _enybase = SAI_POS_EAST;
	if (_side == SAI_EAST) then {_enybase = SAI_POS_WEST};
	
	private _dir = _enybase getDir _base;
	private _pos = [_base, 0, SAI_DISTANCE / 2, 5, 0, 0.5, 0, [], [_base]] call BIS_fnc_findSafePos;
	
	private _spawns = SAI_SPAWN_WEST_ART;
	if (_side == SAI_EAST) then {_spawns = SAI_SPAWN_EAST_ART};
	if (count _spawns > 0) then {
		private _select = _spawns select floor random count _spawns;
	
		_dir = _base getDir _enybase;
		private _spawned = [_pos, _dir, _select, _side] call BIS_fnc_spawnVehicle;
		{
			if (_side == SAI_WEST) then {addSwitchableUnit _x};
			_x setSkill 1;
		}forEach (_spawned select 1);
	} else {
		[_side, _base] call SAI_SPAWN_INFANTRY;	
	}
};

SAI_SPAWN_STATICS = {
	private _side = _this select 0;
	private _base = _this select 1;
	
	private _enybase = SAI_POS_EAST;
	if (_side == SAI_EAST) then {_enybase = SAI_POS_WEST};
	
	private _dir = _base getDir _enybase;
	private _pos = [_base, 0, SAI_DISTANCE / 2, 5, 0, 0.5, 0, [], [_base]] call BIS_fnc_findSafePos;
	
	private _spawns = SAI_SPAWN_WEST_STA;
	if (_side == SAI_EAST) then {_spawns = SAI_SPAWN_EAST_STA};
	if (count _spawns > 0) then {
		private _select = _spawns select floor random count _spawns;
	
		private _spawned = [_pos, _dir, _select, _side] call BIS_fnc_spawnVehicle;
		{
			if (_side == SAI_WEST) then {addSwitchableUnit _x};
			_x setSkill 1;
		}forEach (_spawned select 1);
	} else {
		[_side, _base] call SAI_SPAWN_INFANTRY;	
	}
};

SAI_SPAWN_SUPPORT = {
	private _side = _this select 0;
	private _base = _this select 1;
	
	private _enybase = SAI_POS_EAST;
	if (_side == SAI_EAST) then {_enybase = SAI_POS_WEST};
	
	private _dir = _enybase getDir _base;
	private _pos = [_base, 0, SAI_DISTANCE / 2, 5, 0, 0.5, 0, [], [_base]] call BIS_fnc_findSafePos;
	
	private _spawns = SAI_SPAWN_WEST_SUP;
	if (_side == SAI_EAST) then {_spawns = SAI_SPAWN_EAST_SUP};
	if (count _spawns > 0) then {
		private _select = _spawns select floor random count _spawns;
	
		_dir = _base getDir _enybase;
		private _spawned = [_pos, _dir, _select, _side] call BIS_fnc_spawnVehicle;
		{
			if (_side == SAI_WEST) then {addSwitchableUnit _x};
			_x setSkill 1;
		}forEach (_spawned select 1);
	} else {
		[_side, _base] call SAI_SPAWN_INFANTRY;	
	}
};


SAI_SPAWN_AIRCRAFT = {
	private _side = _this select 0;
	private _base = _this select 1;
	
	private _spawns = SAI_SPAWN_WEST_PLA;
	if (_side == SAI_EAST) then {_spawns = SAI_SPAWN_EAST_PLA};
	if (count _spawns > 0) then {
		private _select = _spawns select floor random count _spawns;
		private _pos = [] call BIS_fnc_randomPos;
		private _dir = random 360;
	
		private _spawned = [_pos, _dir, _select, _side] call BIS_fnc_spawnVehicle;
		{
			if (_side == SAI_WEST) then {addSwitchableUnit _x};
			_x setSkill 1;
			if (SAI_FSM) then {_x disableAI "FSM"};
		}forEach (_spawned select 1);
	
		private _wp = (_spawned select 2) addWaypoint [_pos, 0];
	} else {
		[_side, _base] call SAI_SPAWN_INFANTRY;	
	}
};

for "_i" from 1 to (SAI_CFG_SPAWNS_WEST/2) do {
	[SAI_WEST, SAI_POS_WEST] call SAI_SPAWN_INFANTRY;
};

for "_i" from 1 to (SAI_CFG_SPAWNS_WEST/2) do {
	[SAI_WEST, SAI_POS_WEST] call SAI_SPAWN_VEHICLES;
};

for "_i" from 1 to (SAI_CFG_SPAWNS_EAST/2) do {
	[SAI_EAST, SAI_POS_EAST] call SAI_SPAWN_INFANTRY;
};

for "_i" from 1 to (SAI_CFG_SPAWNS_EAST/2) do {
	[SAI_EAST, SAI_POS_EAST] call SAI_SPAWN_VEHICLES;
};

for "_i" from 1 to (SAI_CFG_SCALE - 1) do {
	[SAI_WEST, SAI_POS_LINE_WEST] call SAI_SPAWN_STATICS;
	[SAI_EAST, SAI_POS_LINE_EAST] call SAI_SPAWN_STATICS;
	[SAI_WEST, SAI_POS_REAR_WEST] call SAI_SPAWN_ARTILLERY;
	[SAI_EAST, SAI_POS_REAR_EAST] call SAI_SPAWN_ARTILLERY;
	[SAI_WEST, SAI_POS_REAR_WEST] call SAI_SPAWN_SUPPORT;
	[SAI_EAST, SAI_POS_REAR_EAST] call SAI_SPAWN_SUPPORT;
	[SAI_WEST, SAI_POS_WEST] call SAI_SPAWN_AIRCRAFT;
	[SAI_EAST, SAI_POS_EAST] call SAI_SPAWN_AIRCRAFT;
};