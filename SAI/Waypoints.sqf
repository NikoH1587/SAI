SAI_FORMATIONS = ["COLUMN","WEDGE","WEDGE","LINE"];

SAI_WP_DEF = {
	_grp = _this select 0;
	_base = _this select 1;
	_inf = true;
	if (vehicle leader _grp != leader _grp) then {_inf = false};
	_nbl = nearestBuilding leader _grp;
	if (_inf) then {_wp = _grp addWaypoint [position _nbl, 0]};	
	
	if (_base distance leader _grp > SAI_DISTANCE) then {
		_grp setFormation (SAI_FORMATIONS select floor random 3);
		_wp = _grp addWaypoint [_base, SAI_DISTANCE];
	
		_nbl = nearestBuilding getWPPos _wp;
		if (getWPPos _wp distance _nbl < SAI_DISTANCE/2) then {
		if (_inf) then {_wp setWaypointPosition [position _nbl, 0]};
		}
	}
};

SAI_WP_REC = {
	_grp = _this select 0;
	_obj = _this select 1;
	_grp setFormation (SAI_FORMATIONS select floor random 3);
	_wp = _grp addWaypoint [_obj, SAI_DISTANCE];
};

SAI_WP_QRF = {
	_grp = _this select 0;
	_enys = _this select 1;
	_eny = _enys select floor random count _enys;
	_enypos = getPos _eny;
	_wp = _grp addWaypoint [_enypos, SAI_DISTANCE/2];
	_wp setWaypointType "SAD";
};

SAI_WP_AIR = {
	_grp = _this select 0;
	_obj = _this select 1;
	_base = _this select 2;
	_wp = _grp addWaypoint [_obj, SAI_DISTANCE];
	_wp setWaypointType "SAD";
	_wp2 = _grp addWaypoint [_base, SAI_DISTANCE];
};

SAI_WP_ART = {
	_grp = _this select 0;
	_enys = _this select 1;
	_eny = _enys select floor random count _enys;
	_ldr = leader _grp;
	_veh = vehicle _ldr;
	_enypos = getPosASL _eny;
	_ammos = getArtilleryAmmo [_veh];
	_near = _enypos nearEntities 100;
	if (count _ammos > 0 && _ldr countFriendly _near == 0) then {
		_ammo = _ammos select 0;
		_ldr doArtilleryFire [_enypos, _ammo, 3];
	}
};

SAI_WP_LOG = {
	_tra = _this select 0;
	_inf = _this select 1;
	_base = _this select 2;
	_veh = vehicle leader _tra;
	_seats = _veh emptyPositions "";
	_found = false;
	{
		_count = count units _x;
		_index = currentWaypoint _x;
		_obj = getWPPos [_x, currentWaypoint _x];
		_pos = getPos leader _x;
		_ldr = leader _x;
		_crg = _x;
		if (_obj isEqualTo [0,0,0]) then {_obj = _pos};
		if (_seats >= _count && _pos distance _obj > SAI_DISTANCE && !_found && alive _ldr) then {
			_wpT = _tra addWaypoint [_pos, 10];
			_wpT setWaypointType "LOAD";

			_wpC = _crg addWaypoint [_pos, 10];
			_wpC setWaypointType "GETIN";
			_wpC synchronizeWaypoint [_wpT];
			_crg setCurrentWaypoint _wpC;

			_wpO = _tra addWaypoint [_obj, 0];
			_wpO setWaypointType "TR UNLOAD";
			_wpR = _tra addWaypoint [_base, SAI_DISTANCE];
			_found = true;
		};
	}forEach _inf;
	
	if (!_found) then {[_tra, _base] call SAI_WP_DEF};
};

/// https://youtu.be/24iqQ5SOfvc?si=C-A5DJQ2Pwq5NOiv