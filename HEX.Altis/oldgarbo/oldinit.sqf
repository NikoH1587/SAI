SCS_WEST = "BLU_F";
SCS_EAST = "OPF_F";

private _cfgVehicles = (configFile >> "cfgVehicles");

private _w_antiair = [];
private _w_artillery = [];
private _w_support = [];

private _w_helicopter = [];
private _w_aircraft = [];
private _w_autonomous = [];

private _w_armor = [];
private _w_vehicle = [];
private _w_static = [];

private _banlist = ["B_Ship_MRLS_01_F", "Land_Pod_Heli_Transport_04_medevac_F", "Land_Pod_Heli_Transport_04_covered_F", "Land_Pod_Heli_Transport_04_bench_F"];
for "_i" from 0 to ((count _cfgVehicles) - 1) do {
	private _entry = _cfgVehicles select _i;
	if (isClass _entry) then {
		private _scope = getNumber (_entry >> "scope");
		private _side = getNumber (_entry >> "side");
		private _config = configName _entry;
		private _faction = getText (_entry >> "faction");
		
		if (_scope > 1 && _side in [0, 1, 2] && (_config in _banlist == false)) then {
			private _sim = toLower getText (_entry >> "simulation");
			private _threat = getArray (_entry >> "threat");
			private _aat = _threat select 2;

			private _arm = getNumber (_entry >> "armor");
			private _art = getNumber (_entry >> "artilleryScanner");
			private _cls = getText (_entry >> "vehicleClass");
			private _amo = getNumber (_entry >> "transportAmmo");
			private _plo = getNumber (_entry >> "transportFuel");
			private _rep = getNumber (_entry >> "transportRepair");
			private _sup = _amo + _plo + _rep;
			private _drv = getNumber (_entry >> "hasDriver");
			
			if (_aat == 1) then {_w_antiair append [_config]};
			if (_art == 1) then {_w_artillery append [_config]};
			if (_sup > 0) then {_w_support append [_config]};
			
			if (_sim == "helicopterrtd" && _cls != "Autonomous" && _sup == 0) then {_w_helicopter append [_config]};
			if (_sim in ["airplanex", "airplane"] && _cls != "Autonomous") then {_w_aircraft append [_config]};
			if (_sim in ["airplanex", "airplane", "helicopterrtd"] &&  _cls == "Autonomous") then {_w_autonomous append [_config]};
			if (_sim == "tankx" && _cls != "Autonomous" && _sup == 0 && _drv == 1 && _art == 0 && _aat < 1) then {_w_armor append [_config]};
			if (_sim == "carx" && _sup == 0 && _drv == 1 && _art == 0 && _aat < 1) then {_w_vehicle append [_config]};
			if (_sim == "tankx" && _sup == 0 && _drv == 0 && _art == 0 && _aat < 1) then {_w_static append [_config]};
		}
	}
};

private _spawn = [];
{
	private _marker = _x;
	private _pos = getMarkerPos _x;
	private _type = markerType _x;
	switch (_type) do {
		case "b_antiair": {_spawn = [_pos, _w_antiair]};
		case "b_art": {_spawn = [_pos, _w_artillery]};
		case "b_support": {_spawn = [_pos, _w_support]};
		
		case "b_air": {_spawn = [_pos, _w_helicopter]};
		case "b_plane": {_spawn = [_pos, _w_aircraft]};
		case "b_uav": {_spawn = [_pos, _w_autonomous]};
		
		case "b_armor": {_spawn = [_pos, _w_armor]};
		case "b_unknown": {_spawn = [_pos, _w_vehicle]};
		case "b_installation": {_spawn = [_pos, _w_static]};
	};
}forEach (allMapmarkers select {_x find "SCS_BTN_" == 0});

/// EVERY FORMATION GETS SOME INFANTRY!!!
/// 1/3 groups
/// 1/3 vehicles
/// 1/3 infantry groups

/// groups: filter out squads with AA and arty, boats, uav's

private _position = _spawn select 0;
private _select = _spawn select 1;

{
	_pos = [_position, 0, 100, 15, 0, 0.5] call BIS_fnc_findSafePos;
	[_pos, 0, _x, west] call BIS_fnc_spawnVehicle;
}forEach _select;

hint str ([(configFile >> "cfgGroups"), 3, false] call BIS_fnc_returnChildren);