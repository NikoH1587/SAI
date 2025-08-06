SAI_FORMATIONS = ["COLUMN","WEDGE","WEDGE","LINE"];

SAI_WP_CHK = {
	private _ldr = _this select 0;
	private _veh = _this select 1;
	private _plr = _this select 2;
	private _busy = false;

	private _grp = group _ldr;
	private _wpIdx = currentWaypoint _grp;
	private _wpTot = count (waypoints _grp);
	private _wpMax = (_wpIdx >= _wpTot);
	if (!_wpMax) then {_busy = true};
	
	if (_grp != group driver _veh) then {_busy = true};
	if (!alive _ldr) then {_busy = true};
	_busy
};

SAI_WP_LOG = {
	private _tra = _this select 0;
	private _inf = _this select 1;
	private _plr = _this select 2;
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
				
				if (_plr) then {
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
	private _ldr = leader _grp;
	private _obj = _this select 1;
	private _plr = _this select 2;
	private _pos = [[[_obj, SAI_DISTANCE]], ["water"]] call BIS_fnc_randomPos;
	private _nb = nearestBuilding _pos;
	private _isInf = vehicle leader _grp == vehicle leader _grp;
	
	if (_isInf && _nb distance _pos < SAI_DISTANCE/2) then {
		_pos = getPos _nb;
	};
	
	private _wp = _grp addWaypoint [_pos, 0];
	_wp setWaypointTimeout [60, 120, 180];
	
	if (_plr) then {
		[_ldr, "REC", ["Def Desc", "DEFEND", "marker"], _pos, "ASSIGNED", -1, true, "defend", false] remoteExec ["BIS_fnc_taskCreate", groupOwner _grp];
	} else {_grp setFormation (SAI_FORMATIONS select floor random 4)};
};

SAI_WP_REC = {
	private _grp = _this select 0;
	private _rec = _this select 1;
	private _plr = _this select 2;
	private _ldr = leader _grp;
	private _posLdr = getPos _ldr;
	private _pos = [((_posLdr select 0) + (_rec select 0))/2, ((_rec select 1) + (_rec select 1))/2];
	private _ldr = leader _grp;
	private _pos = [[[_pos, SAI_DISTANCE]], ["water"]] call BIS_fnc_randomPos;
	private _wp = _grp addWaypoint [_pos, 0];
	
	if (_plr) then {
		[_ldr, "REC", ["Reconnaissance desc", "RECON", "marker"], _pos, "ASSIGNED", -1, true, "scout", false] remoteExec ["BIS_fnc_taskCreate", groupOwner _grp];	
	} else {_grp setFormation (SAI_FORMATIONS select floor random 4)};
};

SAI_WP_QRF = {
	private _grp = _this select 0;
	private _trg = _this select 1;
	private _plr = _this select 2;
	private _ldr = leader _grp;
	if (_trg select 0 != 0 && _trg select 1 != 0) then {
		private _pos = [[[_trg, SAI_DISTANCE]], ["water"]] call BIS_fnc_randomPos;
		private _wp = _grp addWaypoint [_pos, 0];
		_wp setWaypointType "SAD";
		
		if (_plr) then {
			[_ldr, "QRF", ["QRF desc", "ATTACK", "marker"], _pos, "ASSIGNED", -1, true, "attack", false] remoteExec ["BIS_fnc_taskCreate", groupOwner _grp];	
		} else {_grp setFormation (SAI_FORMATIONS select floor random 4)};		
		
	} else {
		/// move to nearest building if no targets?
		/// set qrf wait task
	}
};

SAI_WP_ART = {
	/// MOVE becasue of counter battery?? (won't work with statics lol)
	/// return chat if firemission not possible?
	private _grp = _this select 0;
	private _trg = _this select 1;
	private _plr = _this select 2;
	private _ldr = leader _grp;
	if (_trg select 0 != 0 && _trg select 1 != 0) then {
		private _veh = vehicle _ldr;
		private _ammos = getArtilleryAmmo [_veh];
		private _near = _trg nearEntities 200;
		if (count _ammos > 0 && _ldr countFriendly _near == 0 && _plr == false) then {
			private _ammo = _ammos select 0;
			_ldr doArtilleryFire [_trg, _ammo, 3];
			/// add "waiting" waypoint to prevent spam
		};
		
		if (_plr && count _ammos > 0 && _ldr countFriendly _near == 0) then {
			[_ldr, "ART1", ["Artillery desc1", "ARTY", "marker"], _enypos, "ASSIGNED", -1, true, "destroy", false] remoteExec ["BIS_fnc_taskCreate", groupOwner _grp];
		};
		
	} else {
		if (_plr) then {
			[_ldr, "ART2", ["Artillery desc2", "ARTY", "marker"], _ldr, "ASSIGNED", -1, true, "wait", false] remoteExec ["BIS_fnc_taskCreate", groupOwner _grp];	
		}	
	}
};

SAI_WP_PLA = {
	private _grp = _this select 0;
	private _trg = _this select 1;
	private _plr = _this select 2;
	private _ldr = leader _grp;
	if (_trg select 0 != 0 && _trg select 1 != 0) then {
		private _pos = [[[_trg, SAI_DISTANCE]], ["water"]] call BIS_fnc_randomPos;
		private _wp = _grp addWaypoint [_pos, 0];
		_wp setWaypointType "SAD";
		
		if (_plr) then {
			[_ldr, "AIRSTRIKE", ["Airstrike desc", "AIRSTRIKE", "marker"], _pos, "ASSIGNED", -1, true, "target", false] remoteExec ["BIS_fnc_taskCreate", groupOwner _grp];	
		} else {_grp setFormation (SAI_FORMATIONS select floor random 4)};		
		
	} else {
		/// move to nearest building if no targets?
		/// set qrf wait task
	}
};

SAI_WP_SUP = {
	/// make cheaty any vehicle repair/ream/refuel/heal
	private _grp = _this select 0;
	private _plr = _this select 1;
	private _ldr = leader _grp;
	///private _wp = _grp addWaypoint [getPos leader _grp, 0];
	///_wp setWaypointType "SUPPORT";
	if (isPlayer _ldr) then {
		[_ldr, "SUP", ["Support desc", "SUPPORT", "marker"], _enypos, "ASSIGNED", -1, true, "heal", false] remoteExec ["BIS_fnc_taskCreate", groupOwner _grp];	
	}	
};

/// https://youtu.be/24iqQ5SOfvc?si=C-A5DJQ2Pwq5NOiv