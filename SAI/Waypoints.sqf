SAI_FORMATIONS = ["COLUMN","WEDGE","WEDGE","LINE"];

SAI_WP_CHK = {
	private _ldr = _this select 0;
	private _veh = _this select 1;
	private _sta = getUnitState _ldr;
	private _busy = false;
	if (_sta != "WAIT" && _sta != "OK") then {_busy = true};
	if (!unitReady _ldr) then {_busy = true};
	if (!unitReady commander _veh) then {_busy = true};
	if (!unitReady gunner _veh) then {_busy = true};
	if (!unitReady driver _veh) then {_busy = true};
	if (!unitReady _veh) then {_busy = true};
	if (!alive _ldr) then {_busy = true};
	/// add disable autotasking task check
	_busy
};

SAI_WP_LOG = {
	private _tra = _this select 0;
	private _inf = _this select 1;
	private _veh = vehicle leader _tra;
	private _seats = _veh emptyPositions "";
	private _found = false;
	if (_veh != leader _tra) then {
		{
			private _count = count units _x;
			private _index = currentWaypoint _x;
			private _obj = getWPPos [_x, currentWaypoint _x];
			private _pos = getPos leader _x;
			private _ldr = leader _x;
			private _crg = _x;
			if (_obj isEqualTo [0,0,0]) then {_obj = _pos};
			if (_seats >= _count && _pos distance _obj > SAI_DISTANCE && !_found && alive _ldr) then {
				_wpT = _tra addWaypoint [_pos, 10];
				if (isPlayer leader _tra) then {
					[leader _tra, "LOG", ["Transport desc", "LOAD", "marker"], _pos, "ASSIGNED", -1, true, "meet", false] remoteExec ["BIS_fnc_taskCreate", groupOwner _tra];
				};
				_wpT setWaypointType "LOAD";
				private _wpC = _crg addWaypoint [_pos, 10];
				_wpC setWaypointType "GETIN";
				_wpC synchronizeWaypoint [_wpT];
				_crg setCurrentWaypoint _wpC;
				
				if (isPlayer leader _crg) then {
					[leader _crg, "LOG", ["Cargo desc", "LOAD", "marker"], _veh, "ASSIGNED", -1, true, "getin", false] remoteExec ["BIS_fnc_taskCreate", groupOwner _tra];
				};				
				
				private _wpO = _tra addWaypoint [_obj, 0];
				_wpO setWaypointType "TR UNLOAD";
				_found = true;
			};
		}forEach _inf;
	};
	_found
};

SAI_WP_DEF = {
	private _grp = _this select 0;
	private _rtb = getMarkerPos (_this select 1);
	private _pos = [[[_rtb, SAI_DISTANCE]], ["water"]] call BIS_fnc_randomPos;
	private _ldr = leader _grp;
	private _veh = vehicle _ldr;
	private _inf = true;
	if (_veh != _ldr) then {_inf = false};
	
	if (_rtb distance _ldr > SAI_DISTANCE or _rtb distance _veh > SAI_DISTANCE) then {
		private _wp = _grp addWaypoint [_pos, 0];
		private _nb = nearestBuilding getWPPos _wp;
		if (getWPPos _wp distance _nb < SAI_DISTANCE/2) then {
			if (_inf) then {_wp setWaypointPosition [position _nb, 0]};
			};
	} else {
		if (_inf) then {
			private _nb = nearestBuilding _ldr;
			if (_nb distance _ldr > 10) then {
				_grp addWaypoint [position _nb, 0]
			};
		}
	};
	
	if (isPlayer _ldr) then {
		[_ldr, "DEF", ["Defend desc,", "DEFEND", "marker"], _pos, "ASSIGNED", -1, true, "defend", false] remoteExec ["BIS_fnc_taskCreate", groupOwner _grp];	
	}
};

SAI_WP_REC = {
	private _grp = _this select 0;
	private _ldr = leader _grp;
	private _obj = _this select 1;
	private _posLdr = getPos _ldr;
	private _posObj = _obj;
	private _pos = [((_posLdr select 0) + (_posObj select 0))/2, ((_posLdr select 1) + (_posObj select 1))/2];
	private _ldr = leader _grp;
	private _pos = [[[_pos, SAI_DISTANCE]], ["water"]] call BIS_fnc_randomPos;
	private _wp = _grp addWaypoint [_pos, 0];
	
	if (isPlayer _ldr) then {
		[_ldr, "REC", ["Reconnaissance desc", "RECON", "marker"], _pos, "ASSIGNED", -1, true, "scout", false] remoteExec ["BIS_fnc_taskCreate", groupOwner _grp];	
	} else {_grp setFormation (SAI_FORMATIONS select floor random 4)};
};

SAI_WP_QRF = {
	private _grp = _this select 0;
	private _ldr = leader _grp;
	private _enys = _this select 1;
	if (count _enys > 0) then {
		private _eny = _enys select floor random count _enys;
		private _enypos = getPos _eny;
		private _pos = [[[_enypos, SAI_DISTANCE]], ["water"]] call BIS_fnc_randomPos;
		private _wp = _grp addWaypoint [_pos, 0];
		_wp setWaypointType "SAD";
		
		if (isPlayer _ldr) then {
			[_ldr, "QRF1", ["Attack desc1", "ATTACK", "marker"], _pos, "ASSIGNED", -1, true, "attack", false] remoteExec ["BIS_fnc_taskCreate", groupOwner _grp];	
		}
	} else {
		if (vehicle leader _grp == leader _grp) then {
			private _nb = nearestBuilding leader _grp;
			if (leader _grp distance _nb < SAI_DISTANCE/2 && leader _grp distance _nb > 10) then {
				private _wp = _grp addWaypoint [position _nb, 0];
			}
		};
		
		if (isPlayer _ldr) then {
			[_ldr, "QRF2", ["Attack desc2", "QRF", "marker"], _ldr, "ASSIGNED", -1, true, "wait", false] remoteExec ["BIS_fnc_taskCreate", groupOwner _grp];	
		}
	}
};

SAI_WP_ART = {
	private _grp = _this select 0;
	private _ldr = leader _grp;
	private _enys = _this select 1;
		if (count _enys > 0) then {
		private _eny = _enys select floor random count _enys;
		private _ldr = leader _grp;
		private _veh = vehicle _ldr;
		private _enypos = getPosASL _eny;
		private _ammos = getArtilleryAmmo [_veh];
		private _near = _enypos nearEntities 200;
		if (count _ammos > 0 && _ldr countFriendly _near == 0 && (isPlayer _ldr == false)) then {
			private _ammo = _ammos select 0;
			_ldr doArtilleryFire [_enypos, _ammo, 3];
			private _wp = _grp addWaypoint [position _ldr, 0];
			_wp setWaypointType "HOLD";
			sleep (60 + (random 120));
			deletewaypoint _wp;
		};
		
		if (isPlayer _ldr && count _ammos > 0 && _ldr countFriendly _near == 0) then {
			[_ldr, "ART1", ["Artillery desc1", "ARTY", "marker"], _enypos, "ASSIGNED", -1, true, "target", false] remoteExec ["BIS_fnc_taskCreate", groupOwner _grp];
		};
		
	} else {
		if (isPlayer _ldr) then {
			[_ldr, "ART2", ["Artillery desc2", "ARTY", "marker"], _ldr, "ASSIGNED", -1, true, "wait", false] remoteExec ["BIS_fnc_taskCreate", groupOwner _grp];	
		}	
	}
};

SAI_WP_SUP = {
	private _grp = _this select 0;
	private _ldr = leader _grp;
	///private _wp = _grp addWaypoint [getPos leader _grp, 0];
	///_wp setWaypointType "SUPPORT";
	if (isPlayer _ldr) then {
		[_ldr, "SUP", ["Support desc", "SUPPORT", "marker"], _enypos, "ASSIGNED", -1, true, "heal", false] remoteExec ["BIS_fnc_taskCreate", groupOwner _grp];	
	}	
};

/// https://youtu.be/24iqQ5SOfvc?si=C-A5DJQ2Pwq5NOiv