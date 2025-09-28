SAI_SPAWN_GROUPS = {
	private _sel = _this select 0;
	private _pos = _this select 1;
	private _dir = _this select 2;
	private _sid = _this select 3;

	private _sel = _sel select floor random count _sel;
	private _config = configFile >> "cfgGroups" >> _sel select 0 >> _sel select 1 >> _sel select 2 >> _sel select 3;
	private _spawned = [_pos, _sid, _config, [], [], [1, 1], [], [-1, 1], _dir] call BIS_fnc_spawnGroup;
	private _vehs = [_spawned, false] call BIS_fnc_groupVehicles;
	{
		if (_sid == SAI_WEST) then {addSwitchableUnit _x};
		if (count _vehs != 0 && vehicle _x == _x) then {
			_x moveInAny (_vehs select floor random count _vehs)
		}
	}forEach units _spawned;
};

SAI_SPAWN_VEHICLES = {
	private _sel = _this select 0;
	private _pos = _this select 1;
	private _dir = _this select 2;
	private _sid = _this select 3;
	
	private _spawned = [_pos, _dir, _sel, _sid] call BIS_fnc_spawnVehicle;
	{
		if (_sid == SAI_WEST) then {addSwitchableUnit _x};
		_x setSkill 1;
	}forEach (_spawned select 1);
};

if (SAI_CFG_SCALE > 0) then {
/// WEST
	private _sel = SAI_CFG_WEST_MHQ select floor random count SAI_CFG_WEST_MHQ;
	private _pos = [SAI_POS_REAR_WEST, 0, SAI_DISTANCE / 2, 10, 0, 0.5, 0, [], [SAI_POS_REAR_WEST]] call BIS_fnc_findSafePos;
	private _dir = _pos getDir SAI_POS_EAST;
	private _sid = SAI_WEST;	
	[_sel, _pos, _dir, _sid] call SAI_SPAWN_VEHICLES;
/// EAST
	private _sel = SAI_CFG_EAST_MHQ select floor random count SAI_CFG_EAST_MHQ;
	private _pos = [SAI_POS_REAR_EAST, 0, SAI_DISTANCE / 2, 10, 0, 0.5, 0, [], [SAI_POS_REAR_EAST]] call BIS_fnc_findSafePos;
	private _dir = _pos getDir SAI_POS_WEST;
	private _sid = SAI_EAST;
	[_sel, _pos, _dir, _sid] call SAI_SPAWN_VEHICLES;
};

for "_i" from 1 to (SAI_CFG_SPAWNS_WEST) do {
/// WEST
	private _sel = SAI_CFG_WEST_GRP select floor random count SAI_CFG_WEST_GRP;
	private _pos = [SAI_POS_WEST, 0, SAI_DISTANCE, 10, 0, 0.5, 0, [], [SAI_POS_WEST]] call BIS_fnc_findSafePos;
	private _dir = _pos getDir SAI_POS_EAST;
	private _sid = SAI_WEST;
	[_sel, _pos, _dir, _sid] call SAI_SPAWN_GROUPS;
/// EAST
	private _sel = SAI_CFG_EAST_GRP select floor random count SAI_CFG_EAST_GRP;
	private _pos = [SAI_POS_EAST, 0, SAI_DISTANCE, 10, 0, 0.5, 0, [], [SAI_POS_EAST]] call BIS_fnc_findSafePos;
	private _dir = _pos getDir SAI_POS_WEST;
	private _sid = SAI_EAST;
	[_sel, _pos, _dir, _sid] call SAI_SPAWN_GROUPS;
};

if (SAI_CFG_SCALE == 1) then {
/// WEST
	private _sel = SAI_CFG_WEST_STA select floor random count SAI_CFG_WEST_STA;
	private _pos = [SAI_POS_LINE_WEST, 0, SAI_DISTANCE / 2, 10, 0, 0.5, 0, [], [SAI_POS_LINE_WEST]] call BIS_fnc_findSafePos;
	private _dir = _pos getDir SAI_POS_EAST;
	private _sid = SAI_WEST;
	[_sel, _pos, _dir, _sid] call SAI_SPAWN_VEHICLES;

	private _sel = SAI_CFG_WEST_BNK select floor random count SAI_CFG_WEST_BNK;
	private _pos = [SAI_POS_LINE_WEST, 0, SAI_DISTANCE / 2, 10, 0, 0.5, 0, [], [SAI_POS_LINE_WEST]] call BIS_fnc_findSafePos;
	private _dir = SAI_POS_EAST getDir _pos;
	private _sid = SAI_WEST;
	[_sel, _pos, _dir, _sid] call SAI_SPAWN_VEHICLES;
	private _mrk = createMarker ["bunker1", _pos];
	_mrk setMarkerType "loc_Bunker";
/// EAST
	private _sel = SAI_CFG_EAST_STA select floor random count SAI_CFG_EAST_STA;
	private _pos = [SAI_POS_LINE_EAST, 0, SAI_DISTANCE / 2, 10, 0, 0.5, 0, [], [SAI_POS_LINE_EAST]] call BIS_fnc_findSafePos;
	private _dir = _pos getDir SAI_POS_WEST;
	private _sid = SAI_EAST;
	[_sel, _pos, _dir, _sid] call SAI_SPAWN_VEHICLES;

	private _sel = SAI_CFG_EAST_BNK select floor random count SAI_CFG_EAST_BNK;
	private _pos = [SAI_POS_LINE_EAST, 0, SAI_DISTANCE / 2, 10, 0, 0.5, 0, [], [SAI_POS_LINE_EAST]] call BIS_fnc_findSafePos;
	private _dir = SAI_POS_WEST getDir _pos;
	private _sid = SAI_EAST;
	[_sel, _pos, _dir, _sid] call SAI_SPAWN_VEHICLES;
	private _mrk = createMarker ["bunker2", _pos];
	_mrk setMarkerType "loc_Bunker";
};

if (SAI_CFG_SCALE == 2) then {
///WEST
	private _sel = SAI_CFG_WEST_LOG select floor random count SAI_CFG_WEST_LOG;
	private _pos = [SAI_POS_REAR_WEST, 0, SAI_DISTANCE / 2, 10, 0, 0.5, 0, [], [SAI_POS_REAR_WEST]] call BIS_fnc_findSafePos;
	private _dir = _pos getDir SAI_POS_EAST;
	private _sid = SAI_WEST;
	[_sel, _pos, _dir, _sid] call SAI_SPAWN_VEHICLES;

	private _sel = SAI_CFG_WEST_SUP select floor random count SAI_CFG_WEST_SUP;
	private _pos = [SAI_POS_REAR_WEST, 0, SAI_DISTANCE / 2, 10, 0, 0.5, 0, [], [SAI_POS_REAR_WEST]] call BIS_fnc_findSafePos;
	private _dir = _pos getDir SAI_POS_EAST;
	private _sid = SAI_WEST;
	[_sel, _pos, _dir, _sid] call SAI_SPAWN_VEHICLES;

	private _sel = SAI_CFG_WEST_ART select floor random count SAI_CFG_WEST_ART;
	private _pos = [SAI_POS_REAR_WEST, 0, SAI_DISTANCE / 2, 10, 0, 0.5, 0, [], [SAI_POS_REAR_WEST]] call BIS_fnc_findSafePos;
	private _dir = _pos getDir SAI_POS_EAST;
	private _sid = SAI_WEST;
	[_sel, _pos, _dir, _sid] call SAI_SPAWN_VEHICLES;

	private _sel = SAI_CFG_WEST_AIR select floor random count SAI_CFG_WEST_AIR;
	private _pos = [] call BIS_fnc_randomPos;
	private _dir = random 360;
	private _sid = SAI_WEST;
	[_sel, _pos, _dir, _sid] call SAI_SPAWN_VEHICLES;

/// EAST
	private _sel = SAI_CFG_EAST_LOG select floor random count SAI_CFG_EAST_LOG;
	private _pos = [SAI_POS_REAR_EAST, 0, SAI_DISTANCE / 2, 10, 0, 0.5, 0, [], [SAI_POS_REAR_EAST]] call BIS_fnc_findSafePos;
	private _dir = _pos getDir SAI_POS_WEST;
	private _sid = SAI_EAST;
	[_sel, _pos, _dir, _sid] call SAI_SPAWN_VEHICLES;

	private _sel = SAI_CFG_EAST_SUP select floor random count SAI_CFG_EAST_SUP;
	private _pos = [SAI_POS_REAR_EAST, 0, SAI_DISTANCE / 2, 10, 0, 0.5, 0, [], [SAI_POS_REAR_EAST]] call BIS_fnc_findSafePos;
	private _dir = _pos getDir SAI_POS_WEST;
	private _sid = SAI_EAST;
	[_sel, _pos, _dir, _sid] call SAI_SPAWN_VEHICLES;

	private _sel = SAI_CFG_EAST_ART select floor random count SAI_CFG_EAST_ART;
	private _pos = [SAI_POS_REAR_EAST, 0, SAI_DISTANCE / 2, 10, 0, 0.5, 0, [], [SAI_POS_REAR_EAST]] call BIS_fnc_findSafePos;
	private _dir = _pos getDir SAI_POS_WEST;
	private _sid = SAI_EAST;
	[_sel, _pos, _dir, _sid] call SAI_SPAWN_VEHICLES;

	private _sel = SAI_CFG_EAST_AIR select floor random count SAI_CFG_EAST_AIR;
	private _pos = [] call BIS_fnc_randomPos;
	private _dir = random 360;
	private _sid = SAI_EAST;
	[_sel, _pos, _dir, _sid] call SAI_SPAWN_VEHICLES;
};