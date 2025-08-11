{
	private _scale = SAI_CFG_SCALE;

	private _difficulty = 0 - SAI_CFG_RATIO;
	private _vehicles = SAI_SPAWN_WEST;
	private _support = SAI_SPAWN_WEST_SUP;
	private _artillery = SAI_SPAWN_WEST_ART;
	private _infantry = SAI_SPAWN_WEST_INF;
	private _markers = SAI_MARKERS_WEST;
	private _side = SAI_WEST;
	private _supply = SAI_SUPPLY_WEST;
	private _morale = SAI_MORALE_WEST;
	
	if (_x == "EAST") then {
		_difficulty = 0 + SAI_CFG_RATIO;
		_vehicles = SAI_SPAWN_EAST;
		_support = SAI_SPAWN_EAST_SUP;
		_artillery = SAI_SPAWN_EAST_ART;
		_infantry = SAI_SPAWN_EAST_INF;
		_markers = SAI_MARKERS_EAST;
		_side = SAI_EAST;
		_supply = SAI_SUPPLY_EAST;
		_morale = SAI_MORALE_EAST;
	};
	
	for "_i" from 1 to ((4 + _difficulty) * _scale) do {
		if (count _vehicles > 0) then {
			private _marker = getMarkerPos (_markers select floor random count _markers);
			private _rando = _vehicles select floor random count _vehicles;
			private _select = _rando select floor random count _rando;
			private _pos = [_marker, 0, SAI_DISTANCE, 5, 0, 0.5, 0, [], [_marker]] call BIS_fnc_findSafePos;
			private _dir = (((_pos getDir SAI_CENTER) - 90) + random 90);
			private _unit = [_pos, _dir, _select, _side] call BIS_fnc_spawnVehicle;
			private _veh = _unit select 0;
			private _crew = _unit select 1;
			_veh setVehicleAmmo (_supply max random 1);
			{
				_x setSkill (_morale max random 1);
				if (_side == SAI_WEST) then {addSwitchableUnit _x};
			}forEach _crew;
		}
	};

	for "_i" from 1 to (_scale - 1) do {
		if (count _support > 0) then {
			private _marker = getMarkerPos (_markers select floor random count _markers);
			private _select = _support select floor random count _support;
			private _pos = [_marker, 0, SAI_DISTANCE, 5, 0, 0.5, 0, [], [_marker]] call BIS_fnc_findSafePos;
			private _unit = [_pos, random 360, _select, _side] call BIS_fnc_spawnVehicle;
			private _veh = _unit select 0;
			private _crew = _unit select 1;
			_veh setVehicleAmmo (_supply max random 1);
			{
				_x setSkill (_morale max random 1);
				if (_side == SAI_WEST) then {addSwitchableUnit _x};
			}forEach _crew;
		};
	};

	for "_i" from 1 to (_scale - 1) do {
		if (count _artillery > 0) then {
			private _marker = getMarkerPos (_markers select floor random count _markers);
			private _select = _artillery select floor random count _artillery;
			private _pos = [_marker, 0, SAI_DISTANCE, 5, 0, 0.5, 0, [], [_marker]] call BIS_fnc_findSafePos;
			private _dir = (((_pos getDir SAI_CENTER) - 90) + random 90);
			private _unit = [_pos, _dir, _select, _side] call BIS_fnc_spawnVehicle;
			private _veh = _unit select 0;
			private _crew = _unit select 1;
			_veh setVehicleAmmo (_supply max random 1);
			{
				_x setSkill (_morale max random 1);
				if (_side == SAI_WEST) then {addSwitchableUnit _x};
			}forEach _crew;
		};
	};
	
	for "_i" from 1 to ((4 + _difficulty) * _scale) do {
		private _marker = getMarkerPos (_markers select floor random count _markers);
		private _select = _infantry select floor random count _infantry;
		private _pos = [_marker, 0, SAI_DISTANCE, 5, 0, 0.5, 0, [], [_marker]] call BIS_fnc_findSafePos;
		private _group = [_pos, _side, _select, [], [], [_morale, 1], [_supply, 1]] call BIS_fnc_spawnGroup;
		{
			if (_side == SAI_WEST) then {addSwitchableUnit _x};	
		}forEach units _group;
	};
} forEach ["WEST", "EAST"];

if (SAI_DEBUG) then {
	{SAI_CURATOR addCuratorEditableObjects [[_x], true]}forEach allunits;
	{SAI_CURATOR addCuratorEditableObjects [[_x], true]}forEach vehicles;
};