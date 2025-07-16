SAI_FORMATIONS = ["COLUMN","WEDGE","WEDGE","LINE"];

SAI_WP_INF = {
	_grp = _this select 0;
	_obj = _this select 1;
	_side = side leader _grp;
	_grp setFormation (SAI_FORMATIONS select floor random 3);
	_wp = _grp addWaypoint [_obj, SAI_DISTANCE];
	
	_nbl = nearestBuilding getWPPos _wp;
	if (_obj distance _nbl < SAI_DISTANCE/4) then {
		_wp setWaypointPosition [position _nbl, 0];
	}
};

SAI_WP_VEH = {
	_grp = _this select 0;
	_obj = _this select 1;
	_side = side leader _grp;
	_grp setFormation (SAI_FORMATIONS select floor random 3);
	_wp = _grp addWaypoint [_obj, SAI_DISTANCE];
	_wp setWaypointSpeed "LIMITED";
};

SAI_WP_AIR = {
	_grp = _this select 0;
	_obj = _this select 1;
	_base = _this select 2;
	_wp = _grp addWaypoint [_obj, SAI_DISTANCE];
	_wp setWaypointType "SAD";
	_wp2 = _grp addWaypoint [_base, SAI_DISTANCE];
};


SAI_WP_RTB = {
	_grp = _this select 0;
	_base = _this select 1;
	if (_base distance leader _grp > SAI_DISTANCE) then {
		_wp = _grp addWaypoint [_base, SAI_DISTANCE];
	}
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
	_grp = _this select 0;
	_inf = _this select 1;
	_obj = _this select 2;
	_base = _this select 3;
	_veh = vehicle leader _grp;
	_seats = _veh emptyPositions "";
	_found = false;
{
		_count = count units _x;
		_wp0 = [_x, currentWaypoint _x];
		_ldr = leader _x;

		if (_seats >= _count && _ldr distance getWPPos _wp0 > SAI_DISTANCE && !_found && alive _ldr) then {
			_pos = getPos _ldr;
			_wp0 setWPPos _pos;
			_wp0 setWaypointType "GETIN";
			
			_wp1 = _grp addWaypoint [_pos, 0];
			_wp1 setWaypointType "LOAD";
			_wp0 synchronizeWaypoint [_wp1];
			
			_wp2 = _grp addWaypoint [_obj, SAI_DISTANCE];
			_wp2 setWaypointType "TR UNLOAD";
			_wp3 = _grp addWaypoint [_base, SAI_DISTANCE];
			_found = true;
		};
	}forEach _inf;
};