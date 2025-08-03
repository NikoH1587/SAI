SAI_ALL = [];
{
	private _alive = false;
	{if (alive _x) then {_alive = true}}forEach units _x;
	if (_alive) then {SAI_ALL append [_x]};
}forEach allgroups;

SAI_WEST_ALL = [];
SAI_EAST_ALL = [];

SAI_WEST_INF = [];
SAI_WEST_MOT = [];
SAI_WEST_MEC = [];
SAI_WEST_ARM = [];
SAI_WEST_PLA = [];
SAI_WEST_HEL = [];
SAI_WEST_STA = [];
SAI_WEST_LOG = [];
SAI_WEST_SUP = [];
SAI_WEST_ART = [];

SAI_EAST_INF = [];
SAI_EAST_MOT = [];
SAI_EAST_MEC = [];
SAI_EAST_ARM = [];
SAI_EAST_PLA = [];
SAI_EAST_HEL = [];
SAI_EAST_STA = [];
SAI_EAST_LOG = [];
SAI_EAST_SUP = [];
SAI_EAST_ART = [];

{
	private _ldr = leader _x;
	private _type = "INF";
	private _veh = vehicle _ldr;
	private _cfg = configFile >> "CfgVehicles" >> typeOf _veh;
	private _drv = getNumber (_cfg >> "hasDriver");
	private _sim = getText (_cfg >> "simulation");
	private _tra = getNumber (_cfg >> "transportSoldier");
	if (_sim == "carx") then {_type = "MOT"};
	if (_sim == "tankx") then {_type = "ARM"};
	if (_sim == "tankx" && _tra > 6) then {_type = "MEC"};
	if (_sim == "helicopterrtd") then {_type = "HEL"};
	if (_sim == "airplanex") then {_type = "PLA"};
		
	if (count units _x == 1 && _sim == "carx") then {_type = "LOG"};
	private _med = getNumber (_cfg >> "attendant");
	private _eng = getNumber (_cfg >> "engineer");
	private _amo = getNumber (_cfg >> "transportAmmo");
	private _plo = getNumber (_cfg >> "transportFuel");
	private _rep = getNumber (_cfg >> "transportRepair");
	private _sup = _med + _eng + _amo + _plo + _rep;
	if (_sup != 0) then {_type = "SUP"};
	if (_drv == 0) then {_type = "STA"};
	if (getNumber (_cfg >> "artilleryScanner") > 0) then {_type = "ART"};
	
	if (side _ldr == SAI_WEST) then {_type = _type + "_WEST"; SAI_WEST_ALL append [_x]};
	if (side _ldr == SAI_EAST) then {_type = _type + "_EAST"; SAI_EAST_ALL append [_x]};
	
	switch (_type) do {
		case "INF_WEST": {SAI_WEST_INF append [_x]};
		case "MOT_WEST": {SAI_WEST_MOT append [_x]};
		case "MEC_WEST": {SAI_WEST_MEC append [_x]};
		case "ARM_WEST": {SAI_WEST_ARM append [_x]};
		case "PLA_WEST": {SAI_WEST_PLA append [_x]};
		case "HEL_WEST": {SAI_WEST_HEL append [_x]};
		case "LOG_WEST": {SAI_WEST_LOG append [_x]};
		case "SUP_WEST": {SAI_WEST_SUP append [_x]};
		case "STA_WEST": {SAI_WEST_STA append [_x]};
		case "ART_WEST": {SAI_WEST_ART append [_x]};
		
		case "INF_EAST": {SAI_EAST_INF append [_x]};
		case "MOT_EAST": {SAI_EAST_MOT append [_x]};
		case "MEC_EAST": {SAI_EAST_MEC append [_x]};
		case "ARM_EAST": {SAI_EAST_ARM append [_x]};
		case "PLA_EAST": {SAI_EAST_PLA append [_x]};
		case "HEL_EAST": {SAI_EAST_HEL append [_x]};
		case "LOG_EAST": {SAI_EAST_LOG append [_x]};
		case "SUP_EAST": {SAI_EAST_SUP append [_x]};
		case "STA_EAST": {SAI_EAST_STA append [_x]};
		case "ART_EAST": {SAI_EAST_ART append [_x]};		
		default {SAI_ALL = SAI_ALL - [_x]};
	}
}forEach SAI_ALL;