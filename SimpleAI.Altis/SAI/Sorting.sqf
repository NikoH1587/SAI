SAI_ALL = allgroups;
SAI_WEST_ALL = [];
SAI_EAST_ALL = [];

{
	private _ldr = leader _x;
	private _pos = getPos _ldr;
	private _uni = count units _x;
	private _type = "INF";
	private _vehs = [_x, false] call BIS_fnc_groupVehicles;
	if (count _vehs != 0) then {
		_veh = _vehs select 0;
		private _cfg = configFile >> "CfgVehicles" >> typeOf _veh;
		private _drv = getNumber (_cfg >> "hasDriver");
		private _sim = getText (_cfg >> "simulation");
		private _tra = getNumber (_cfg >> "transportSoldier");
		private _cls = getText (_cfg >> "vehicleClass");
		if (_sim == "carx") then {_type = "MOT"};
		if (_sim == "tankx") then {_type = "ARM"};
		if (_sim == "tankx" && _tra > 6) then {_type = "MEC"};
		if (_sim == "helicopterrtd") then {_type = "HEL"};
		if (_sim == "airplanex") then {_type = "PLA"};
		if (_cls == "Autonomous") then {_type = "UAV"};

		if (_uni == 1 && _sim == "carx") then {_type = "LOG"};
		private _med = getNumber (_cfg >> "attendant");
		private _eng = getNumber (_cfg >> "engineer");
		private _amo = getNumber (_cfg >> "transportAmmo");
		private _plo = getNumber (_cfg >> "transportFuel");
		private _rep = getNumber (_cfg >> "transportRepair");
		private _sup = _med + _eng + _amo + _plo + _rep;
		if (_sup != 0) then {_type = "SUP"};
		if (_drv == 0) then {_type = "STA"};
		if (getNumber (_cfg >> "artilleryScanner") > 0) then {_type = "ART"};
	};
	
	if (groupID _x == "Alpha 1-1") then {_type = "COM"};
	
	if (side _ldr == SAI_WEST) then {SAI_WEST_ALL append [[_x, _type, _pos]]};
	if (side _ldr == SAI_EAST) then {SAI_EAST_ALL append [[_x, _type, _pos]]};

}forEach SAI_ALL;