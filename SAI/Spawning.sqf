SAI_CFG_WEST_INF = configFile >> "CfgGroups" >> "West" >> "BLU_F" >> "Infantry";
SAI_CFG_WEST_VEH = "BLU_F";
SAI_CFG_EAST_INF = configFile >> "CfgGroups" >> "East" >> "OPF_F" >> "Infantry";
SAI_CFG_EAST_VEH = "OPF_F";
SAI_SPAWNS = allMapMarkers select  {(_x find "SAI_" == 0) && (markerAlpha _x == 1)};
{
	_position = getMarkerPos _x;
	_count = 6;
	if (getMarkerSize _x select 0 < 1) then {_count = 3};
	if (getMarkerSize _x select 0 > 1) then {_count = 9};
	_type = "Static";
	_side = SAI_EAST;
	_cfgINF = SAI_CFG_EAST_INF;
	_cfgVEH = SAI_CFG_EAST_VEH;
	switch (getMarkerType _x) do {
		case "b_inf": {_type = "Static"; _side = SAI_WEST};
		case "b_motor_inf": {_type = "Car"; _side = SAI_WEST};
		case "b_mech_inf": {_type = "Armored"; _side = SAI_WEST};
		case "b_recon": {_type = "Air"; _side = SAI_WEST};
		
		case "o_inf": {_type = "Static"; _side = SAI_EAST};
		case "o_motor_inf": {_type = "Car"; _side = SAI_EAST};
		case "o_mech_inf": {_type = "Armored"; _side = SAI_EAST};
		case "o_recon": {_type = "Air"; _side = SAI_EAST};
	};
	
	if (_side == SAI_WEST) then {_cfgINF = SAI_CFG_WEST_INF; _cfgVEH = SAI_CFG_WEST_VEH};

	_inf = [];
	_veh = [];
	
	for "_i" from 0 to (count _cfgINF) do {
		_entry = _cfgINF select _i;
		if (isClass _entry) then {_inf append [_entry]};
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
			_amo = getNumber (_entry >> "transportAmmo");
			_plo = getNumber (_entry >> "transportFuel");
			_rep = getNumber (_entry >> "transportRepair");
			if (_sco == 2 && _fac == _cfgVEH && (_cls == _type or (_art == 1 && _cls == "Static")) && (_med + _eng + _amo + _plo + _rep) == 0) then {_veh append [configName _entry]};				
		}
	};
	
/// BALANCE THIS SHIT????
/// ARMOR = OP
/// MOT = USELESS???

	_infUsed = _inf;
	for "_i" from 1 to _count do {
		if (count _infUsed == 0) then {_infUsed = _inf};
		_select = _infUsed select floor random count _infUsed;
		_pos = [_position, 0, 100*_i, 5, 0, 0.5, 0, [], [_position]] call BIS_fnc_findSafePos;
		_group = [_pos, _side, _select] call BIS_fnc_spawnGroup;
		_infUsed = _infUsed - [_select];
	};
	
	_vehUsed = _veh;
	for "_i" from 1 to _count do {
		if (count _vehUsed == 0) then {_vehUsed = _veh};
		_select = _vehUsed select floor random count _vehUsed;
		_pos = [_position, 0, 100*_i, 5, 0, 0.5, 0, [], [_position]] call BIS_fnc_findSafePos;
		_unit = [_pos, random 360, _select, _side] call BIS_fnc_spawnVehicle;
		_vehUsed = _vehUsed - [_select];
	};
}forEach SAI_SPAWNS