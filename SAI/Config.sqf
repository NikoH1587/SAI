SAI_SPAWN_WEST_INF = [];
SAI_SPAWN_WEST_MOT = [];
SAI_SPAWN_WEST_ARM = [];
SAI_SPAWN_WEST_MEC = [];
SAI_SPAWN_WEST_HEL = [];
SAI_SPAWN_WEST_PLA = [];
SAI_SPAWN_WEST_ART = [];
SAI_SPAWN_WEST_SUP = [];
SAI_SPAWN_WEST_STA = [];

SAI_SPAWN_EAST_INF = [];
SAI_SPAWN_EAST_MOT = [];
SAI_SPAWN_EAST_ARM = [];
SAI_SPAWN_EAST_MEC = [];
SAI_SPAWN_EAST_HEL = [];
SAI_SPAWN_EAST_PLA = [];
SAI_SPAWN_EAST_ART = [];
SAI_SPAWN_EAST_SUP = [];
SAI_SPAWN_EAST_STA = [];

private _west_side = SAI_CFG_WEST select 0;
private _west_faction = SAI_CFG_WEST select 1;
private _west_category = SAI_CFG_WEST select 2;
SAI_CFG_WEST_VEH = SAI_CFG_WEST select 3;
SAI_CFG_WEST_INF = (configFile >> "CfgGroups" >> _west_side >> _west_faction >> _west_category);

private _east_side = SAI_CFG_EAST select 0;
private _east_faction = SAI_CFG_EAST select 1;
private _east_category = SAI_CFG_EAST select 2;
SAI_CFG_EAST_VEH = SAI_CFG_EAST select 3;
SAI_CFG_EAST_INF = (configFile >> "CfgGroups" >> _east_side >> _east_faction >> _east_category);

for "_i" from 0 to (count SAI_CFG_WEST_INF) do {
	private _entry = SAI_CFG_WEST_INF select _i;
	if (isClass _entry) then {
		private _count = count _entry;
		private _amount = 1;
		if (_count > 2) then {_amount = 2};
		if (_count > 4) then {_amount = 3};
		for "_i" from 1 to (_amount) do {
			SAI_SPAWN_WEST_INF append [_entry];
		}
	}
};

for "_i" from 0 to (count SAI_CFG_EAST_INF) do {
	private _entry = SAI_CFG_EAST_INF select _i;
	if (isClass _entry) then {
		private _count = count _entry;
		private _amount = 1;
		if (_count > 2) then {_amount = 2};
		if (_count > 4) then {_amount = 3};
		for "_i" from 1 to (_amount) do {
			SAI_SPAWN_EAST_INF append [_entry];
		}
	}
};

for "_i" from 0 to (count (configFile >> "CfgVehicles")) do {
	private _entry = (configFile >> "CfgVehicles") select _i;
	if (isClass _entry) then {
		private _scope = getNumber (_entry >> "scope");
		if (_scope == 2) then {
			private _sim = getText (_entry >> "simulation");
			private _cls = getText (_entry >> "vehicleClass");
			private _fac = getText (_entry >> "faction");
			private _drv = getNumber (_entry >> "hasDriver");
			private _gun = count (_entry >> "turrets");
			private _arm = getNumber (_entry >> "armor");
			private _art = getNumber (_entry >> "artilleryScanner");
			private _med = getNumber (_entry >> "attendant");
			private _eng = getNumber (_entry >> "engineer");
			private _tra = getNumber (_entry >> "transportSoldier");
			private _amo = getNumber (_entry >> "transportAmmo");
			private _plo = getNumber (_entry >> "transportFuel");
			private _rep = getNumber (_entry >> "transportRepair");
			private _sup = _med + _eng + _amo + _plo + _rep;
			
			if (
				_sim == "carx" && 
				_cls != "Autonomous" &&
				(_gun > 0 or _tra > 2) &&
				_sup == 0 && 
				_art == 0
				) then {
					if (_fac == SAI_CFG_WEST_VEH) then {SAI_SPAWN_WEST_MOT append [configName _entry]};
					if (_fac == SAI_CFG_EAST_VEH) then {SAI_SPAWN_EAST_MOT append [configName _entry]};
				};
	
			if (
				_sim == "carx" && 
				(_gun > 0 && _tra > 6 && _arm > 200) &&
				_sup == 0 && 
				_art == 0
				) then {
					if (_fac == SAI_CFG_WEST_VEH) then {SAI_SPAWN_WEST_MEC append [configName _entry]};
					if (_fac == SAI_CFG_EAST_VEH) then {SAI_SPAWN_EAST_MEC append [configName _entry]};
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
				_cls != "Autonomous" &&
				_cls != "Support" &&
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
				_art != 0 &&
				_cls != "Autonomous"
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

SAI_SPAWN_WEST = [SAI_SPAWN_WEST_MOT, SAI_SPAWN_WEST_MEC, SAI_SPAWN_WEST_ARM, SAI_SPAWN_WEST_HEL];
switch (SAI_CFG_WEST_COM) do {
	case 1: {SAI_SPAWN_WEST = []};
	case 2: {SAI_SPAWN_WEST = [SAI_SPAWN_WEST_MOT]};
	case 3: {SAI_SPAWN_WEST = [SAI_SPAWN_WEST_MEC, SAI_SPAWN_WEST_MEC, SAI_SPAWN_WEST_ARM]};
	case 4: {SAI_SPAWN_WEST = [SAI_SPAWN_WEST_HEL]};
	case 5: {SAI_SPAWN_WEST = [SAI_CFG_CUSTOM_WEST]};
};

SAI_SPAWN_EAST = [SAI_SPAWN_EAST_MOT, SAI_SPAWN_EAST_MEC, SAI_SPAWN_EAST_ARM, SAI_SPAWN_EAST_HEL];
switch (SAI_CFG_EAST_COM) do {
	case 1: {SAI_SPAWN_EAST = []};
	case 2: {SAI_SPAWN_EAST = [SAI_SPAWN_EAST_MOT]};
	case 3: {SAI_SPAWN_EAST = [SAI_SPAWN_EAST_MEC, SAI_SPAWN_EAST_MEC, SAI_SPAWN_EAST_ARM]};
	case 4: {SAI_SPAWN_EAST = [SAI_SPAWN_EAST_HEL]};
	case 5: {SAI_SPAWN_EAST = [SAI_CFG_CUSTOM_EAST]};
};
