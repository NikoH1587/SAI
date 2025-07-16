SAI_ALL = [];
{
	SAI_ALL append [_x];
}forEach allgroups;

SAI_WEST_ALL = [];
SAI_WEST_INF = [];
SAI_WEST_VEH = [];
SAI_WEST_ARM = [];
SAI_WEST_AIR = [];
SAI_WEST_LOG = [];
SAI_WEST_SUP = [];
SAI_WEST_ART = [];

SAI_EAST_ALL = [];
SAI_EAST_INF = [];
SAI_EAST_VEH = [];
SAI_EAST_ARM = [];
SAI_EAST_AIR = [];
SAI_EAST_LOG = [];
SAI_EAST_SUP = [];
SAI_EAST_ART = [];

{
	_ldr = leader _x;
	_type = "INF";
	if (count assignedVehicles _x != 0) then {
		_veh = (assignedVehicles _x) select 0;
		_cfg = configFile >> "CfgVehicles" >> typeOf _veh;
		_cls = getText (_cfg >> "vehicleClass");
		if (_cls == "Car") then {_type = "VEH"};
		if (_cls == "Armored") then {_type = "ARM"};
		if (_cls in ["Air", "Autonomous"]) then {_type = "AIR"};
		if (count units _x == 1) then {_type = "LOG"};
		if (_cls == "Support") then {_type = "SUP"};
		if (getNumber (_cfg >> "artilleryScanner") > 0) then {_type = "ART"};
	};
	
	if (side _ldr == SAI_WEST) then {_type = _type + "_WEST"};
	if (side _ldr == SAI_EAST) then {_type = _type + "_EAST"};
	
	switch (_type) do {
		case "INF_WEST": {SAI_WEST_INF append [_x]};
		case "VEH_WEST": {SAI_WEST_VEH append [_x]};
		case "ARM_WEST": {SAI_WEST_ARM append [_x]};
		case "AIR_WEST": {SAI_WEST_AIR append [_x]};
		case "LOG_WEST": {SAI_WEST_LOG append [_x]};
		case "SUP_WEST": {SAI_WEST_SUP append [_x]};
		case "ART_WEST": {SAI_WEST_ART append [_x]};
		
		case "INF_EAST": {SAI_EAST_INF append [_x]};
		case "VEH_EAST": {SAI_EAST_VEH append [_x]};
		case "ARM_EAST": {SAI_EAST_ARM append [_x]};
		case "AIR_EAST": {SAI_EAST_AIR append [_x]};
		case "LOG_EAST": {SAI_EAST_LOG append [_x]};
		case "SUP_EAST": {SAI_EAST_SUP append [_x]};
		case "ART_EAST": {SAI_EAST_ART append [_x]};		
	}
}forEach SAI_ALL;