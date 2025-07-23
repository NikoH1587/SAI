SAI_CFG_WEST_INF = configFile >> "CfgGroups" >> "West" >> "BLU_F" >> "Infantry";
SAI_CFG_WEST_VEH = "BLU_F";
SAI_CFG_EAST_INF = configFile >> "CfgGroups" >> "East" >> "OPF_F" >> "Infantry";
SAI_CFG_EAST_VEH = "OPF_F";
SAI_CFG_BUNKERS = ["Land_BagBunker_Large_F", "Land_BagBunker_Small_F", "Land_BagBunker_Tower_F"];
SAI_SPAWNS = allMapMarkers select {(_x find "SAI_SPAWN_" == 0) && (markerAlpha _x == 1)};
{
	_position = getMarkerPos _x;
	_count = 10;
	if (getMarkerSize _x select 0 < 1) then {_count = 5};
	if (getMarkerSize _x select 0 > 1) then {_count = 15};
	_type = "Static";
	_side = SAI_EAST;
	_cfgINF = SAI_CFG_EAST_INF;
	_cfgVEH = SAI_CFG_EAST_VEH;
	switch (getMarkerType _x) do {
		case "b_inf": {_type = ["Static"]; _side = SAI_WEST};
		case "b_motor_inf": {_type = ["Car", "Artillery"]; _side = SAI_WEST};
		case "b_mech_inf": {_type = ["Armored", "Support"]; _side = SAI_WEST};
		case "b_recon": {_type = ["Car", "Air"]; _side = SAI_WEST};
		
		case "o_inf": {_type = ["Static"]; _side = SAI_EAST};
		case "o_motor_inf": {_type = ["Car", "Artillery"]; _side = SAI_EAST};
		case "o_mech_inf": {_type = ["Armored", "Support"]; _side = SAI_EAST};
		case "o_recon": {_type = ["Car", "Air"]; _side = SAI_EAST};
	};
	
	if (_side == SAI_WEST) then {_cfgINF = SAI_CFG_WEST_INF; _cfgVEH = SAI_CFG_WEST_VEH};

	_inf = [];
	_veh = [];
	
	for "_i" from 0 to (count _cfgINF) do {
		_entry = _cfgINF select _i;
		_subbies = count _entry;
		if (isClass _entry) then {for "_i" from 0 to (_subbies) do {_inf append [_entry]}};
	};
	
	for "_i" from 0 to (count (configFile >> "CfgVehicles")) do {
		_entry = (configFile >> "CfgVehicles") select _i;
		if (isClass _entry) then {
			_sco = getNumber (_entry >> "scope");
			_fac = getText (_entry >> "faction");
			_cls = getText (_entry >> "vehicleClass");
			_art = getNumber (_entry >> "artilleryScanner");
			_med = getNumber (_entry >> "attendant");
			_eng = getNumber (_entry >> "engineer");
			_tra = getNumber (_entry >> "transportSoldier");
			_amo = getNumber (_entry >> "transportAmmo");
			_plo = getNumber (_entry >> "transportFuel");
			_rep = getNumber (_entry >> "transportRepair");
			_sup = _med + _eng + _amo + _plo + _rep;
			if ("Support" in _type && _sup != 0) then {_sup = 0, _tra = 0};
			if ("Armored" in _type && _art != 0) then {_cls = "None"};
			if (_sco == 2 && _fac == _cfgVEH && (_cls in _type or ("Artillery" in _type && _art != 0 && _cls != "Autonomous")) && _sup == 0) then {
				for "_i" from 0 to (_tra min 3) do {
					_veh append [configName _entry];
				}
			}	
		}
	};

	_infCount = count _inf;
	for "_i" from 1 to _count do {
		_select = _inf select floor random _infCount;
		_pos = [_position, 0, SAI_DISTANCE/2, 5, 0, 0.5, 0, [], [_position]] call BIS_fnc_findSafePos;
		_group = [_pos, _side, _select] call BIS_fnc_spawnGroup;
	};

	_vehCount = count _veh;
	for "_i" from 1 to _count do {
		_select = _veh select floor random _vehCount;
		_pos = [_position, 0, SAI_DISTANCE/2, 5, 0, 0.5, 0, [], [_position]] call BIS_fnc_findSafePos;
		_unit = [_pos, random 360, _select, _side] call BIS_fnc_spawnVehicle;
	};
	
	for "_i" from 1 to _count do {
		_select = SAI_CFG_BUNKERS select floor random count SAI_CFG_BUNKERS;
		_pos = [_position, 0, SAI_DISTANCE/2, 5, 0, 0.5, 0, [], [_position]] call BIS_fnc_findSafePos;
		_bunker = _select createVehicle _pos;
		_bunker setDir random 360;
	};
}forEach SAI_SPAWNS