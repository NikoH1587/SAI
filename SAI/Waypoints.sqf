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

SAI_WP_TRA = {
	private _tra = _this select 0;
	private _inf = _this select 1;
	private _plr = _this select 2;
	private _veh = vehicle leader _tra;
	private _seats = _veh emptyPositions "";
	private _found = false;
	
	if (_veh != leader _tra) then {
	private _traPos = getPos _veh;
	
	private _sort = _inf apply {
		private _grp = _x select 0;
		private _pos = _x select 1;
		[_x, _pos distance _traPos]
	};
	_sort sort true;
	_inf = _sort apply {_x select 0};
	
		{
			private _grp = _x select 0;
			private _count = count units _grp;
			private _index = currentWaypoint _grp;
			private _obj = getWPPos [_grp, currentWaypoint _grp];
			private _pos = getPos leader _grp;
			private _ldr = leader _grp;
			if (_obj isEqualTo [0,0,0]) then {_obj = _pos};
			if (_seats >= _count && _pos distance _obj > 1000 && !_found && alive _ldr) then {
				_wpT = _tra addWaypoint [_pos, 10];
				
				if (_plr) then {
					[leader _tra, "TRA", ["Transport desc", "LOAD", "marker"], _pos, "ASSIGNED", -1, true, "meet", false] remoteExec ["BIS_fnc_taskCreate", groupOwner _tra];
				};
				
				_wpT setWaypointType "LOAD";
				private _wpC = _grp addWaypoint [_pos, 10];
				_wpC setWaypointType "GETIN";
				_wpC synchronizeWaypoint [_wpT];
				_grp setCurrentWaypoint _wpC;
				
				if (isPlayer leader _grp) then {
					[leader _grp, "TRA", ["Cargo desc", "LOAD", "marker"], _veh, "ASSIGNED", -1, true, "getin", false] remoteExec ["BIS_fnc_taskCreate", groupOwner _tra];
				};				
				
				private _wpO = _tra addWaypoint [_obj, 0];
				_wpO setWaypointType "TR UNLOAD";
				_found = true;
			};
		}forEach _inf;
	};
	_found
};

SAI_WP_REC = {
	private _grp = _this select 0;
	private _pos = _this select 1;
	private _plr = _this select 2;
	private _dir = _this select 3;
	private _ldr = leader _grp;
	private _wp = _grp addWaypoint [_pos, 0];
	_dir = _pos getDir _dir;
	_dir = _pos getPos [20, _dir];
	private _wpDir = _grp addWaypoint [_dir, 0];
	if (_plr) then {
		[_ldr, "REC", ["Reconnaissance desc", "RECON", "marker"], _pos, "ASSIGNED", -1, true, "scout", false] remoteExec ["BIS_fnc_taskCreate", groupOwner _grp];	
	} else {_grp setFormation (SAI_FORMATIONS select floor random 4)};		
};

SAI_WP_MOV = {
	private _grp = _this select 0;
	private _pos = _this select 1;
	private _plr = _this select 2;
	private _dir = _this select 3;
	
	private _ldr = leader _grp;
	private _wp = _grp addWaypoint [_pos, 0];
	_dir = _pos getDir _dir;
	_dir = _pos getPos [20, _dir];
	private _wpDir = _grp addWaypoint [_dir, 0];
	if (_plr) then {
		[_ldr, "MOV", ["Movement desc", "MOVE", "marker"], _pos, "ASSIGNED", -1, true, "default", false] remoteExec ["BIS_fnc_taskCreate", groupOwner _grp];	
	} else {_grp setFormation (SAI_FORMATIONS select floor random 4)};		
};

SAI_WP_DEF = {
	private _grp = _this select 0;
	private _pos = _this select 1;
	private _plr = _this select 2;
	private _ldr = leader _grp;
	private _nb = nearestBuilding _pos;
	private _isInf = false;
	if (vehicle _ldr == _ldr) then {_isInf = true};
	if (_isInf && _nb distance _pos < SAI_DISTANCE/4) then {_pos = getPos _nb};
	private _wp = _grp addWaypoint [_pos, 0];
	_wp setWaypointType "MOVE";
	_wp setWaypointTimeout [60, 120, 180];
		
	if (_plr) then {
		[_ldr, "DEF", ["DEF Desc", "DEFEND", "marker"], _pos, "ASSIGNED", -1, true, "defend", false] remoteExec ["BIS_fnc_taskCreate", groupOwner _grp];
	} else {_grp setFormation (SAI_FORMATIONS select floor random 4)};		
};

SAI_WP_ATK = {
	private _grp = _this select 0;
	private _pos = _this select 1;
	private _plr = _this select 2;
	private _ldr = leader _grp;
	private _wp = _grp addWaypoint [_pos, 0];
	_wp setWaypointType "SAD";
		
	if (_plr) then {
		[_ldr, "ATTACK", ["ATK desc", "ATK", "marker"], _pos, "ASSIGNED", -1, true, "attack", false] remoteExec ["BIS_fnc_taskCreate", groupOwner _grp];	
	} else {_grp setFormation (SAI_FORMATIONS select floor random 4)};		
};

SAI_WP_ART = {
	/// MOVE becasue of counter battery?? (won't work with statics lol)
	/// return chat if firemission not possible?
	private _grp = _this select 0;
	private _pos = _this select 1;
	private _plr = _this select 2;
	private _ldr = leader _grp;
	private _veh = vehicle _ldr;
	private _ammos = getArtilleryAmmo [_veh];
	private _near = _pos nearEntities 200;
	if (count _ammos > 0 && _ldr countFriendly _near == 0 && _plr == false) then {
		private _ammo = _ammos select 0;
		_ldr doArtilleryFire [_pos, _ammo, 3];
	};
		
	if (_plr && count _ammos > 0 && _ldr countFriendly _near == 0) then {
		[_ldr, "ART1", ["Artillery desc1", "ARTY", "marker"], _pos, "ASSIGNED", -1, true, "destroy", false] remoteExec ["BIS_fnc_taskCreate", groupOwner _grp];
	};
};

SAI_WP_PLA = {
	private _grp = _this select 0;
	private _pos = _this select 1;
	private _plr = _this select 2;
	private _wp = _grp addWaypoint [_pos, 0];
	_wp setWaypointType "SAD";
	if (_plr) then {
		[_ldr, "AIRSTRIKE", ["Airstrike desc", "AIRSTRIKE", "marker"], _pos, "ASSIGNED", -1, true, "target", false] remoteExec ["BIS_fnc_taskCreate", groupOwner _grp];	
	}
};

SAI_WP_UAV = {
	private _grp = _this select 0;
	private _pos = _this select 1;
	private _plr = _this select 2;
	private _ldr = leader _grp;
	private _wp = _grp addWaypoint [_pos, 0];
	_wp setWaypointType "SAD";
	if (_plr) then {
		[_ldr, "DRONE", ["Drone desc", "DRONE", "marker"], _trg, "ASSIGNED", -1, true, "scout", false] remoteExec ["BIS_fnc_taskCreate", groupOwner _grp];	
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

SAI_WP_LOG = {
	private _grp = _this select 0;
	private _pos = _this select 1;
	private _plr = _this select 2;

	/// make logistics rtb if not assigned
	
	if (isPlayer _ldr) then {
		[_ldr, "LOG", ["Logistics desc", "LOGISTICS", "marker"], _enypos, "ASSIGNED", -1, true, "default", false] remoteExec ["BIS_fnc_taskCreate", groupOwner _grp];	
	}	
};

/// https://youtu.be/24iqQ5SOfvc?si=C-A5DJQ2Pwq5NOiv