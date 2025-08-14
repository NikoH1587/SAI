{
	private _amount = SAI_CFG_SCALE * 10;
	
	private _vehicles = SAI_SPAWN_WEST;
	private _support = SAI_SPAWN_WEST_SUP;
	private _artillery = SAI_SPAWN_WEST_ART;
	private _infantry = [SAI_SPAWN_WEST_INF];
	private _markers = SAI_MARKERS_WEST;
	private _side = SAI_WEST;
	if (_x == "EAST") then {
		_vehicles = SAI_SPAWN_EAST;
		_support = SAI_SPAWN_EAST_SUP;
		_artillery = SAI_SPAWN_EAST_ART;
		_infantry = [SAI_SPAWN_EAST_INF];
		_markers = SAI_MARKERS_EAST;
		_side = SAI_EAST;
	};
	
	for "_i" from 1 to (_amount) do {
		private _rando = 1;
		if (_i % 2 == 0) then {_rando = 1};
		if (_i % 2 != 0) then {_rando = 0};
		private _vehs = _vehicles select floor random count _vehicles;
		private _infs = _infantry select floor random count _infantry;
		
		if (_i == 11 or _i == 21) then {_vehs = _artillery; _rando = 0};
		if (_i == 12 or _i == 22) then {_vehs = _support; _rando = 0};
		
		if (count _vehs == 0) then {_rando == 1};
		
		private _marker = getMarkerPos (_markers select floor random count _markers);
		private _pos = [_marker, 0, SAI_DISTANCE, 5, 0, 0.5, 0, [], [_marker]] call BIS_fnc_findSafePos;
		private _dir = (((_pos getDir SAI_CENTER) - 90) + random 90);

		if (_rando < 0.5) then {
			private _select = _vehs select floor random count _vehs;
			private _spawned = [_pos, _dir, _select, _side] call BIS_fnc_spawnVehicle;
			{
				if (_side == SAI_WEST) then {addSwitchableUnit _x};
				_x setSkill 1;
			}forEach (_spawned select 1);
		};
		
		if (_rando >= 0.5) then {
			private _select = _infs select floor random count _infs;
			private _spawned = [_pos, _side, _select] call BIS_fnc_spawnGroup;
			
			{
				if (_side == SAI_WEST) then {addSwitchableUnit _x};
				_x setSkill 1;
			}forEach units _spawned;
		};
	}
} forEach ["WEST", "EAST"];

if (SAI_DEBUG) then {
	{SAI_CURATOR addCuratorEditableObjects [[_x], true]}forEach allunits;
	{SAI_CURATOR addCuratorEditableObjects [[_x], true]}forEach vehicles;
};