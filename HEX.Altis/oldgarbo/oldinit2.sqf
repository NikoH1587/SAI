private _cfg = ([(configFile >> "cfgGroups" ), 3, false] call BIS_fnc_returnChildren);
SCS_WEST = "BLU_F";
SCS_EAST = "OPF_F";
SCS_CFG_WEST = [];
SCS_CFG_EAST = [];
{
	private _name = getText (_x >> "name");
	private _marker = getText (_x >> "icon");
	private _faction = getText (_x >> "faction");
    _marker = _marker splitString "\/.";
	_marker = _marker select ((count _marker) - 2);
	_marker = _marker select [2, count _marker - 2];
	
	private _price = 1;
	private _units = [];
	
	{
		private _veh = getText (_x >> "vehicle");
		private _cost = getNumber (configFile >> "CfgVehicles" >> _veh >> "cost");
		private _threats = getArray (configFile >> "CfgVehicles" >> _veh >> "threat");
		private _at = _threats select 1;
		private _aa = _threats select 2;
		private _threat = _at max _aa;
		_price = _price + ((_cost / 100000) ^ _threat);
		_units append [_veh];
	}forEach ("true" configClasses _x);
	
	if (_faction == SCS_WEST) then {SCS_CFG_WEST append [[round _price, _name, _marker, _units]]};
	if (_faction == SCS_EAST) then {SCS_CFG_EAST append [[round _price, _name, _marker, _units]]};
}forEach _cfg;

SCS_CFG_WEST = [SCS_CFG_WEST, [], {_x select 0}] call BIS_fnc_sortBy;
SCS_CFG_EAST = [SCS_CFG_EAST, [], {_x select 0}] call BIS_fnc_sortBy;

hint str SCS_CFG_WEST;
copyToClipBoard str SCS_CFG_WEST;


private _groups_west = [];
private _groups_east = [];
{
	private _faction = getText (_x >> "faction");	
	if (_faction == SCS_WEST) then {_groups_west append [_x]};
	if (_faction == SCS_EAST) then {_groups_east append [_x]};
}forEach _cfgGroups;

private _cfgVehicles = "getNumber (_x >> 'scope') == 2 && getNumber (_x >> 'side') in [0, 1, 2]" configClasses (configFile >> "CfgVehicles");
private _vehicles_west = [];
private _vehicles_east = [];

{
	private _cfg = configName _x;
	private _man = getNumber (_x >> "isman");
	private _fac = getText (_x >> "faction");

	if (_man == 0 && _fac == SCS_WEST) then {_vehicles_west append [_cfg]};
	if (_man == 0 && _fac == SCS_EAST) then {_vehicles_east append [_cfg]};
}forEach _cfgVehicles;

_grp = [];
_veh = [];
for "_i" from 1 to 9 do {_grp append [_groups_west select floor random count _groups_west]};
for "_i" from 1 to 3 do {_veh append [_vehicles_west select floor random count _vehicles_west]};

private _icons = [];
{
	private _ico = getText (_x >> "icon");
    _ico = _ico splitString "\/.";	
	_ico = _ico select ((count _ico) - 2);
	_icons append [_ico];
}forEach _grp;

private _common = "b_unknown";
private _count = 2;

{
	private _ico = _x;
	private _cnt = 0;
	{if (_x == _ico) then {_cnt = _cnt + 1}}forEach _icons;
	if (_cnt > _count) then {_common = _x; _count = _cnt};
}forEach _icons;

"respawn_west" setMarkerType _common;


///{
///	private _base = getMarkerPos "respawn_west";
///	private _eny = getMarkerPos "respawn_east";
///	_pos = [_base, 0, 500, 10, 0, 0.5] call BIS_fnc_findSafePos;
///	_spawned = [_pos, west, _x] call BIS_fnc_spawnGroup;
///	_spawned addWaypoint [_eny, 500];
///	{_x moveinCargo vehicle leader _spawned}forEach units _spawned;
///}forEach _grp;

///{
///	private _base = getMarkerPos "respawn_west";
///	private _eny = getMarkerPos "respawn_east";
///	_pos = [_base, 0, 500, 10, 0, 0.5] call BIS_fnc_findSafePos;
///	_spawned = [_pos, _base getdir _eny, _x, west] call BIS_fnc_spawnVehicle;
///	(_spawned select 2) addWaypoint [_eny, 500];
///}forEach _veh;