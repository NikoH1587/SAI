SAI_ALL = [];
{
	SAI_ALL append [_x];
}forEach allgroups;

SAI_WEST_INF = [];
SAI_WEST_CAR = [];
SAI_WEST_ARM = [];
SAI_WEST_HEL = [];
SAI_WEST_PLA = [];
SAI_WEST_LOG = [];
SAI_WEST_SUP = [];
SAI_WEST_ART = [];

SAI_EAST_INF = [];
SAI_EAST_CAR = [];
SAI_EAST_ARM = [];
SAI_EAST_HEL = [];
SAI_EAST_PLA = [];
SAI_EAST_LOG = [];
SAI_EAST_SUP = [];
SAI_EAST_ART = [];

{
	_ldr = leader _x;
	_type = "INF";
	if (count assignedVehicles _x != 0 or vehicle _ldr != _ldr) then {
		_veh = (assignedVehicles _x) select 0;
		if (vehicle _ldr != _ldr) then {_veh = vehicle _ldr};
		_cfg = configFile >> "CfgVehicles" >> typeOf _veh;
		_typ = getNumber (_cfg >> "type");
		_sim = getText (_cfg >> "simulation");
		if (_sim == "carx") then {_type = "CAR"};
		if (_sim == "tankx") then {_type = "ARM"};
		if (_sim == "helicopterrtd") then {_type = "HEL"};
		if (_sim == "planex") then {_type = "PLA"};
		
		if (count units _x == 1) then {_type = "LOG"};
		_med = getNumber (_cfg >> "attendant");
		_eng = getNumber (_cfg >> "engineer");
		_amo = getNumber (_cfg >> "transportAmmo");
		_plo = getNumber (_cfg >> "transportFuel");
		_rep = getNumber (_cfg >> "transportRepair");
		_sup = _med + _eng + _amo + _plo + _rep;
		if (_sup != 0) then {_type = "SUP"};
		if (getNumber (_cfg >> "artilleryScanner") > 0) then {_type = "ART"};
	};
	
	if (side _ldr == SAI_WEST) then {_type = _type + "_WEST"};
	if (side _ldr == SAI_EAST) then {_type = _type + "_EAST"};
	
	switch (_type) do {
		case "INF_WEST": {SAI_WEST_INF append [_x]};
		case "CAR_WEST": {SAI_WEST_CAR append [_x]};
		case "ARM_WEST": {SAI_WEST_ARM append [_x]};
		case "AIR_WEST": {SAI_WEST_AIR append [_x]};
		case "LOG_WEST": {SAI_WEST_LOG append [_x]};
		case "SUP_WEST": {SAI_WEST_SUP append [_x]};
		case "ART_WEST": {SAI_WEST_ART append [_x]};
		
		case "INF_EAST": {SAI_EAST_INF append [_x]};
		case "CAR_EAST": {SAI_EAST_CAR append [_x]};
		case "ARM_EAST": {SAI_EAST_ARM append [_x]};
		case "AIR_EAST": {SAI_EAST_AIR append [_x]};
		case "LOG_EAST": {SAI_EAST_LOG append [_x]};
		case "SUP_EAST": {SAI_EAST_SUP append [_x]};
		case "ART_EAST": {SAI_EAST_ART append [_x]};	
	}
}forEach SAI_ALL;