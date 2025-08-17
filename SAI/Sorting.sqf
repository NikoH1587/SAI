SAI_ALL = allgroups;
SAI_WEST_ALL = [];
SAI_EAST_ALL = [];

{
	private _ldr = leader _x;
	private _pos = getPos _ldr;
	private _uni = count units _x;
	private _type = "INF";
	private _val = 1;
	private _veh = vehicle _ldr;
	private _cfg = configFile >> "CfgVehicles" >> typeOf _veh;
	private _drv = getNumber (_cfg >> "hasDriver");
	private _sim = getText (_cfg >> "simulation");
	private _tra = getNumber (_cfg >> "transportSoldier");
	private _cls = getText (_cfg >> "vehicleClass");
///	private _com = groupId _x == "B Alpha 1-1";
	if (_sim == "carx") then {_type = "MOT"; _val = 2};
	if (_sim == "tankx") then {_type = "ARM"; _val = 4};
	if (_sim == "tankx" && _tra > 6) then {_type = "MEC"; _val = 3};
	if (_sim == "helicopterrtd") then {_type = "HEL"; _val = 3};
	if (_sim == "airplanex") then {_type = "PLA"; _val = 4};
	if (_cls == "Autonomous") then {_type = "UAV"; _val = 2};
		
	if (_uni == 1 && _sim == "carx") then {_type = "LOG"; _val = 1};
	private _med = getNumber (_cfg >> "attendant");
	private _eng = getNumber (_cfg >> "engineer");
	private _amo = getNumber (_cfg >> "transportAmmo");
	private _plo = getNumber (_cfg >> "transportFuel");
	private _rep = getNumber (_cfg >> "transportRepair");
	private _sup = _med + _eng + _amo + _plo + _rep;
	if (_sup != 0) then {_type = "SUP"; _val = 1};
	if (_drv == 0) then {_type = "STA"; _val = 1};
	if (getNumber (_cfg >> "artilleryScanner") > 0) then {_type = "ART"; _val = 5};
	
	if (side _ldr == SAI_WEST) then {SAI_WEST_ALL append [[_x, _type, _pos, _val]]};
	if (side _ldr == SAI_EAST) then {SAI_EAST_ALL append [[_x, _type, _pos, _val]]};

}forEach SAI_ALL;