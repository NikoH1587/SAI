SAI_FORMATIONS = ["COLUMN","WEDGE","WEDGE","LINE"];

SAI_WP_CHK = {
	_ldr = _this select 0;
	_veh = _this select 1;
	_sta = getUnitState _ldr;
	_busy = false;
	if (_sta != "WAIT" && _sta != "OK") then {_busy = true};
	if (!unitReady _ldr) then {_busy = true};
	if (!unitReady commander _veh) then {_busy = true};
	if (!unitReady gunner _veh) then {_busy = true};
	if (!unitReady driver _veh) then {_busy = true};
	_busy
};

SAI_WP_LOG = {
	_tra = _this select 0;
	_inf = _this select 1;
	_veh = vehicle leader _tra;
	_seats = _veh emptyPositions "";
	_found = false;
	if (_veh != leader _tra) then {
		{
			_count = count units _x;
			_index = currentWaypoint _x;
			_objL = getWPPos [_x, currentWaypoint _x];
			_pos = getPos leader _x;
			_ldr = leader _x;
			_crg = _x;
			if (_objL isEqualTo [0,0,0]) then {_objL = _pos};
			if (_seats >= _count && _pos distance _objL > SAI_DISTANCE && !_found && alive _ldr) then {
				_wpT = _tra addWaypoint [_pos, 10];
				_wpT setWaypointType "LOAD";

				_wpC = _crg addWaypoint [_pos, 10];
				_wpC setWaypointType "GETIN";
				_wpC synchronizeWaypoint [_wpT];
				_crg setCurrentWaypoint _wpC;

				_wpO = _tra addWaypoint [_objL, 0];
				_wpO setWaypointType "TR UNLOAD";
				_found = true;
			};
		}forEach _inf;
	};
	_found
};

SAI_WP_DEF = {
	_grpD = _this select 0;
	_rtbD = getMarkerPos (_this select 1);
	_posD = [[[_rtbD, SAI_DISTANCE]], ["water"]] call BIS_fnc_randomPos;
	_ldr = leader _grpD;
	_veh = vehicle _ldr;
	_inf = true;
	if (_veh != _ldr) then {_inf = false};
	_nbD = nearestBuilding _ldr;
	if (_inf) then {
		_wpn = _grpD addWaypoint [position _nbD, 0]};	
	
	if (_rtbD distance _ldr > SAI_DISTANCE or _rtbD distance _veh > SAI_DISTANCE) then {
		_grpD setFormation (SAI_FORMATIONS select floor random 4);
		_wpn = _grpD addWaypoint [_posD, 0];
	
		_nbD = nearestBuilding getWPPos _wpn;
		if (getWPPos _wpn distance _nbD < SAI_DISTANCE/2) then {
		if (_inf) then {_wpn setWaypointPosition [position _nbD, 0]};
		}
	}
};

SAI_WP_REC = {
	_grpR = _this select 0;
	_objR = _this select 1;
	_posR = [[[_objR, SAI_DISTANCE]], ["water"]] call BIS_fnc_randomPos;
	_grpR setFormation (SAI_FORMATIONS select floor random 4);
	_wpR = _grpR addWaypoint [_posR, 0];
};

SAI_WP_QRF = {
	_grpQ = _this select 0;
	_enys = _this select 1;
	if (count _enys > 0) then {
		_eny = _enys select floor random count _enys;
		_enypos = getPos _eny;
		_posQ = [[[_enypos, SAI_DISTANCE / 2]], ["water"]] call BIS_fnc_randomPos;
		_wpq = _grpQ addWaypoint [_posQ, 0];
		_wpq setWaypointType "SAD";
	} else {
		if (vehicle leader _grpQ == leader _grpQ) then {
			_nbQ = nearestBuilding leader _grpQ;
			_wpq = _grpQ addWaypoint [position _nbQ, 0];
		}
	}
};

SAI_WP_ART = {
	_grpA = _this select 0;
	_enys = _this select 1;
		if (count _enys > 0) then {
		_enyA = _enys select floor random count _enys;
		_ldrA = leader _grpA;
		_vehA = vehicle _ldrA;
		_enypos = getPosASL _enyA;
		_ammos = getArtilleryAmmo [_veh];
		_near = _enypos nearEntities 100;
		if (count _ammos > 0 && _ldrA countFriendly _near == 0) then {
			_ammo = _ammos select 0;
			_ldrA doArtilleryFire [_enypos, _ammo, 3];
		}
	}
};

/// https://youtu.be/24iqQ5SOfvc?si=C-A5DJQ2Pwq5NOiv