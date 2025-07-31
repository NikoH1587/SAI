SAI_POS_WEST = getMarkerPos "SAI_WEST";
SAI_POS_EAST = getMarkerPos "SAI_EAST";
SAI_POS_CENT = getMarkerPos "SAI_CENT";
SAI_DISTANCE = (SAI_POS_WEST distance SAI_POS_EAST) / 2;

SAI_TASK_LOG = {
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

SAI_TASK_DEF = {
	_grp = _this select 0;
	_rtb = getMarkerPos (_this select 1);
	_pos = [[[_rtb, SAI_DISTANCE]], ["water"]] call BIS_fnc_randomPos;
    [leader _grp, "DEF", ["description", "DEFEND", "marker"], _pos, "CREATED", -1, true, "defend", false] call BIS_fnc_taskCreate;
};

SAI_TASK_REC = {
	_grp = _this select 0;
	_obj = _this select 1;
	_pos = [[[_obj, SAI_DISTANCE]], ["water"]] call BIS_fnc_randomPos;
};

SAI_TASK_QRF = {
	_grp = _this select 0;
	_enys = _this select 1;
	if (count _enys > 0) then {
		_eny = _enys select floor random count _enys;
		_enypos = getPos _eny;
		_pos = [[[_enypos, SAI_DISTANCE / 2]], ["water"]] call BIS_fnc_randomPos;
		/// attack! on enemy
	} else {
		/// qrf wait task
	}
};

SAI_TASK_ART = {
	_grpA = _this select 0;
	_enys = _this select 1;
		if (count _enys > 0) then {
		_enyA = _enys select floor random count _enys;
		_ldrA = leader _grpA;
		_vehA = vehicle _ldrA;
		_enypos = getPosASL _enyA;
		_ammos = getArtilleryAmmo [_veh];
		_near = _enypos nearEntities 200;
		if (count _ammos > 0 && _ldrA countFriendly _near == 0) then {
			_ammo = _ammos select 0;
			_ldrA doArtilleryFire [_enypos, _ammo, 3];
		}
	}
};

SAI_TASK_SUP = {
	_grpS = _this select 0;
	_wpS = _grpS addWaypoint [getPos leader _grpS, 0];
	_wpS setWaypointType "SUPPORT";
	SAI_BLACKLIST append [_grpS];
};

/// https://youtu.be/24iqQ5SOfvc?si=C-A5DJQ2Pwq5NOiv