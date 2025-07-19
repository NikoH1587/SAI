SAI_FNC_SPAWN = {
	_marker = _this select 0;
	_faction = _this select 1;
	_infantry = _this select 2;
	_position = getMarkerPos _marker;
	_type = "NONE";
	_side = ["East", east];
	_amount = 7;
	if (markerSize _marker select 1 > 1) then {_amount = 9};
	if (markerSize _marker select 1 < 1) then {_amount = 5};
	
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
	
	_cfgGroups = (configFile >> "CfgGroups" >> _side select 0 >> _faction >> _infantry);
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
			
			if (_sco == 2 && _fac == _faction && _cls == "Car" && _art == 0) then {_vehicles append [configName _entry]};
			if (_sco == 2 && _fac == _faction && _cls == "Armored" && _art == 0) then {_armor append [configName _entry]};
			if (_sco == 2 && _fac == _faction && _cls == "Support") then {_support append [configName _entry]};
			if (_sco == 2 && _fac == _faction && _cls == "Air") then {_air append [configName _entry]};
			if (_sco == 2 && _fac == _faction && _art == 1) then {_artillery append [configName _entry]};
			if (_sco == 2 && _fac == _faction && _cls == "Autonomous" && _art == 0) then {_drones append [configName _entry]};
			if (_sco == 2 && _fac == _faction && _cls == "Static" && _art == 0) then {_statics append [configName _entry]};	
		}
	};

	for "_i" from 1 to _amount do {
		_spawn = _infantry;
		_brackets = true;
		switch (_type) do {
			case "VEH": {_spawn = _vehicles; if (_i > _amount/2) then {_spawn = _infantry; _brackets = false}};
			case "ARM": {_spawn = _armor;  if (_i > _amount/2) then {_spawn = _infantry; _brackets = false}};
			case "AIR": {_spawn = _air; if (_i > _amount/2) then {_spawn = _infantry; _brackets = false}};
			case "SUP": {_spawn = _support; if (_i > _amount/2) then {_spawn = _statics}};
			case "ART": {_spawn = _artillery; if (_i > _amount/2) then {_spawn = _drones}};
			default {_brackets = false}
		};
		_spawn = _spawn select floor random count _spawn;
		if (_brackets) then {_spawn = [_spawn]};
		_pos = [_position, 0, 50*_i, 5, 0, 0.5, 0, [], [_position]] call BIS_fnc_findSafePos;
		_spawned = [_pos, _side select 1, _spawn] call BIS_fnc_spawnGroup;
	};
};

["SAI_1", "BLU_F", "Infantry"] call SAI_FNC_SPAWN;
["SAI_2", "BLU_F", "Infantry"] call SAI_FNC_SPAWN;
["SAI_3", "BLU_F", "Infantry"] call SAI_FNC_SPAWN;
["SAI_4", "OPF_F", "Infantry"] call SAI_FNC_SPAWN;
["SAI_5", "OPF_F", "Infantry"] call SAI_FNC_SPAWN;
["SAI_6", "OPF_F", "Infantry"] call SAI_FNC_SPAWN;
