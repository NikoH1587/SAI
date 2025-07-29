SAI_SPAWN_WEST_INF = [];
SAI_SPAWN_WEST_MOT = [];
SAI_SPAWN_WEST_MEC = [];
SAI_SPAWN_WEST_ARM = [];
SAI_SPAWN_WEST_PLA = [];
SAI_SPAWN_WEST_HEL = [];
SAI_SPAWN_WEST_ART = [];
SAI_SPAWN_WEST_SUP = [];
SAI_SPAWN_WEST_STA = [];

SAI_SPAWN_EAST_INF = [];
SAI_SPAWN_EAST_MOT = [];
SAI_SPAWN_EAST_MEC = [];
SAI_SPAWN_EAST_ARM = [];
SAI_SPAWN_EAST_PLA = [];
SAI_SPAWN_EAST_HEL = [];
SAI_SPAWN_EAST_ART = [];
SAI_SPAWN_EAST_SUP = [];
SAI_SPAWN_EAST_STA = [];

for "_i" from 0 to (count SAI_CFG_WEST_INF) do {
	_entry = SAI_CFG_WEST_INF select _i;
	if (isClass _entry) then {
		_count = count _entry;
		_amount = 1;
		if (_count > 2) then {_amount = 2};
		if (_count > 4) then {_amount = 3};
		for "_i" from 1 to (_amount) do {
			SAI_SPAWN_WEST_INF append [_entry];
		}
	}
};

for "_i" from 0 to (count SAI_CFG_EAST_INF) do {
	_entry = SAI_CFG_EAST_INF select _i;
	if (isClass _entry) then {
		_count = count _entry;
		_amount = 1;
		if (_count > 2) then {_amount = 2};
		if (_count > 4) then {_amount = 3};
		for "_i" from 1 to (_amount) do {
			SAI_SPAWN_EAST_INF append [_entry];
		}
	}
};

for "_i" from 0 to (count (configFile >> "CfgVehicles")) do {
	_entry = (configFile >> "CfgVehicles") select _i;
	if (isClass _entry) then {
		_scope = getNumber (_entry >> "scope");
		if (_scope == 2) then {
			_sim = getText (_entry >> "simulation");
			_cls = getText (_entry >> "vehicleClass");
			_fac = getText (_entry >> "faction");
			_drv = getNumber (_entry >> "hasDriver");
			_art = getNumber (_entry >> "artilleryScanner");
			_med = getNumber (_entry >> "attendant");
			_eng = getNumber (_entry >> "engineer");
			_tra = getNumber (_entry >> "transportSoldier");
			_amo = getNumber (_entry >> "transportAmmo");
			_plo = getNumber (_entry >> "transportFuel");
			_rep = getNumber (_entry >> "transportRepair");
			_sup = _med + _eng + _amo + _plo + _rep;
			
			if (
				_sim == "carx" && 
				_sup == 0 && 
				_art == 0
				) then {
					if (_fac == SAI_CFG_WEST_VEH) then {SAI_SPAWN_WEST_MOT append [configName _entry]};
					if (_fac == SAI_CFG_EAST_VEH) then {SAI_SPAWN_EAST_MOT append [configName _entry]};
				};
			if (
				_sim == "tankx" && 
				_drv == 1 && 
				_sup == 0 && 
				_tra > 6 && 
				_art == 0
				) then {
					if (_fac == SAI_CFG_WEST_VEH) then {SAI_SPAWN_WEST_MEC append [configName _entry]};
					if (_fac == SAI_CFG_EAST_VEH) then {SAI_SPAWN_EAST_MEC append [configName _entry]};
				};
			if (
				_sim == "tankx" && 
				_drv == 1 && 
				_sup == 0 && 
				_cls != "Autonomous" && 
				_art == 0
				) then {
					if (_fac == SAI_CFG_WEST_VEH) then {SAI_SPAWN_WEST_ARM append [configName _entry]};
					if (_fac == SAI_CFG_EAST_VEH) then {SAI_SPAWN_EAST_ARM append [configName _entry]};
				};
			if (
				_sim == "tankx" && 
				_drv == 0 && 
				_art == 0
				) then {
					if (_fac == SAI_CFG_WEST_VEH) then {SAI_SPAWN_WEST_STA append [configName _entry]};
					if (_fac == SAI_CFG_EAST_VEH) then {SAI_SPAWN_EAST_STA append [configName _entry]};
				};
			if (
				_sim == "helicopterrtd" && 
				_sup == 0
				) then {
					if (_fac == SAI_CFG_WEST_VEH) then {SAI_SPAWN_WEST_HEL append [configName _entry]};
					if (_fac == SAI_CFG_EAST_VEH) then {SAI_SPAWN_EAST_HEL append [configName _entry]};
				};
			if (
				_sim == "airplanex" && 
				_sup == 0
				) then {
					if (_fac == SAI_CFG_WEST_VEH) then {SAI_SPAWN_WEST_PLA append [configName _entry]};
					if (_fac == SAI_CFG_EAST_VEH) then {SAI_SPAWN_EAST_PLA append [configName _entry]};
				};
			if (
				_art != 0
				) then {
					if (_fac == SAI_CFG_WEST_VEH) then {SAI_SPAWN_WEST_ART append [configName _entry]};
					if (_fac == SAI_CFG_EAST_VEH) then {SAI_SPAWN_EAST_ART append [configName _entry]};
				};
			if (
				_sim != "soldier" && 
				_sup != 0
				) then {
					if (_fac == SAI_CFG_WEST_VEH) then {SAI_SPAWN_WEST_SUP append [configName _entry]};
					if (_fac == SAI_CFG_EAST_VEH) then {SAI_SPAWN_EAST_SUP append [configName _entry]};
				};
		}
	}
};

/// IF MISSING PULL FROM AUX!