uRTS_WEST_ALL = [];
uRTS_EAST_ALL = [];
{
	private _ldr = leader _x;
	if (simulationEnabled _ldr) then {
		private _pos = getPos _ldr;
		private _uni = count units _x;
		private _type = "inf";
		private _vehs = [_x, false] call BIS_fnc_groupVehicles;
		private _name = (str _uni) + "x";
		if (count _vehs != 0) then {
			_veh = _vehs select 0;
			_name = [configOf _veh] call BIS_fnc_displayName;
			private _cfg = configFile >> "CfgVehicles" >> typeOf _veh;
			private _drv = getNumber (_cfg >> "hasDriver");
			private _sim = getText (_cfg >> "simulation");
			private _tra = getNumber (_cfg >> "transportSoldier");
			private _gun = count (_cfg >> "turrets");
			private _cls = getText (_cfg >> "vehicleClass");
			if (_sim == "carx" && _tra > 6 && _gun > 0) then {_type = "motor_inf"};
			if (_sim == "carx" && _tra < 6 && _gun > 0) then {_type = "recon"};
			if (_sim == "carx" && _tra > 6 && _gun == 0) then {_type = "unknown"};
			if (_sim == "tankx") then {_type = "armor"};
			if (_sim == "tankx" && _tra > 6) then {_type = "mech_inf"};
			if (_sim == "helicopterrtd") then {_type = "air"};
			if (_sim == "airplanex") then {_type = "plane"};
			if (_cls == "Autonomous") then {_type = "uav"};
			if (_drv == 0) then {_type = "installation"};
			if (getNumber (_cfg >> "artilleryScanner") > 0) then {_type = "art"};
		};
	
		if (isPlayer leader _x) then {_type = "hq"};
		
		if (side _ldr == west) then {uRTS_WEST_ALL append [[_x call BIS_fnc_netID, "b_" + _type, _pos, _name]]};
		if (side _ldr == east) then {uRTS_EAST_ALL append [[_x call BIS_fnc_netID, "o_" + _type, _pos, _name]]};
	}
}forEach allgroups;

publicVariable "uRTS_WEST_ALL";
publicVariable "uRTS_EAST_ALL";