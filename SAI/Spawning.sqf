SAI_FNC_SPAWN = {
	_marker = _this select 0;
	_faction = _this select 1;
	_cfg = _this select 2;
	_inf = _this select 3;
	_position = getMarkerPos _marker;
	_type = "NONE";
	_side = ["East", east];
	_amount = 7;
	if (markerSize _marker select 1 > 1) then {_amount = 9};
	if (markerSize _marker select 1 < 1) then {_amount = 5};
	
	if (markerAlpha _marker == 1) exitWith {};
	
	switch (getMarkerType _marker) do {
		case "b_inf": {_type = "INF"; _side = ["West", west]};
		case "b_motor_inf": {_type = "VEH"; _side = ["West", west]};	
		case "b_mech_inf": {_type = "ARM"; _side = ["West", west]};
		case "b_support": {_type = "SUP"; _side = ["West", west]};
		case "b_air": {_type = "AIR"; _side = ["West", west]};
		case "b_art": {_type = "ART"; _side = ["West", west]};
		
		case "o_inf": {_type = "INF"; _side = ["East", east]};
		case "o_motor_inf": {_type = "VEH"; _side = ["East", east]};	
		case "o_mech_inf": {_type = "ARM"; _side = ["East", east]};
		case "o_support": {_type = "SUP"; _side = ["East", east]};
		case "o_air": {_type = "AIR"; _side = ["East", east]};
		case "o_art": {_type = "ART"; _side = ["East", east]};

		case "n_inf": {_type = "INF"; _side = ["Indep", resistance]};
		case "n_motor_inf": {_type = "VEH"; _side = ["Indep", resistance]};	
		case "n_mech_inf": {_type = "ARM"; _side = ["Indep", resistance]};
		case "n_support": {_type = "SUP"; _side = ["Indep", resistance]};
		case "n_air": {_type = "AIR"; _side = ["Indep", resistance]};
		case "n_art": {_type = "ART"; _side = ["Indep", resistance]};	
	};
	
	_cfgGroups = (configFile >> "CfgGroups" >> _side select 0 >> _cfg >> _inf);
	_cfgVehicles = configFile >> "CfgVehicles";
	_infantry = [];
	_vehicles = [];
	_armor = [];
	_support = [];
	_air = [];
	_drones = [];
	_statics = [];
	_artillery = [];
	
	for "_i" from 0 to (count _cfgGroups) do {
		_entry = _cfgGroups select _i;
		if (isClass _entry) then {_infantry append [_entry]};
	};
	for "_i" from 0 to (count _cfgVehicles) do {
		_entry = _cfgVehicles select _i;
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
			
			_sup = false;
			if ((_art + _med + _eng + _amo + _plo + _rep) > 0) then {_sup = true};
			
			if (_sco == 2 && _fac == _faction && _cls == "Car" && _sup == false) then {_vehicles append [configName _entry]};
			if (_sco == 2 && _fac == _faction && _cls == "Armored" && _sup == false) then {_armor append [configName _entry]};
			if (_sco == 2 && _fac == _faction && _cls == "Support") then {_support append [configName _entry]};
			if (_sco == 2 && _fac == _faction && _cls == "Air" && _sup == false) then {_air append [configName _entry]};
			if (_sco == 2 && _fac == _faction && _art == 1) then {_artillery append [configName _entry]};
			if (_sco == 2 && _fac == _faction && _cls == "Autonomous" && _sup == false) then {_drones append [configName _entry]};
			if (_sco == 2 && _fac == _faction && _cls == "Static" && _sup == false) then {_statics append [configName _entry]};	
		}
	};

	for "_i" from 1 to _amount do {
		_spawn = _infantry;
		_infs = false;
		switch (_type) do {
			case "VEH": {_spawn = _vehicles; if (_i > _amount/2) then {_spawn = _infantry; _infs = true}};
			case "ARM": {_spawn = _armor;  if (_i > _amount/2) then {_spawn = _infantry; _infs = true}};
			case "AIR": {_spawn = _air; if (_i > _amount/2) then {_spawn = _infantry; _infs = true}};
			case "SUP": {_spawn = _support; if (_i > _amount/2) then {_spawn = _statics}};
			case "ART": {_spawn = _artillery; if (_i > _amount/2) then {_spawn = _drones}};
			default {_infs = true}
		};
		_tospawn = _spawn select floor random count _spawn;
		_pos = [_position, 0, 50*_i, 5, 0, 0.5, 0, [], [_position]] call BIS_fnc_findSafePos;
		if (_infs) then {_spawned = [_pos, _side select 1, _tospawn] call BIS_fnc_spawnGroup};
		if (_infs == false) then {_spawned = [_pos, random 360, _tospawn, _side select 1] call BIS_fnc_spawnVehicle};
	};
	_marker setMarkerAlpha 1;
};

["SAI_1", "BLU_F", "BLU_F", "Infantry"] call SAI_FNC_SPAWN;
["SAI_2", "BLU_F", "BLU_F", "Infantry"] call SAI_FNC_SPAWN;
["SAI_3", "OPF_F", "OPF_F", "Infantry"] call SAI_FNC_SPAWN;