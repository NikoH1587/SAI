uRTS_TRACKING = {
	{
		sleep 0.1;
		private _chars = (count _x) - 9;
		private _netID = _x select [9, _chars];
		private _grp = groupFromNetId _netID;
		private _ldr = leader _grp;
		private _veh = vehicle _ldr;
		private _txt = [configOf _veh] call BIS_fnc_displayName;
		private _uni = str (count units _grp) + "x";
		if (markerText _x != _txt && _veh != _ldr) then {_x setMarkerText _txt};
		if (markerText _x != _uni && _veh == _ldr) then {_x setMarkerText _uni};
		if (alive _ldr) then {_x setMarkerPos getPosASL _ldr};
		if (count units _grp == 0) then {
			private _price = _grp getVariable "uRTS_PRICE";
			if (side _grp == west) then {uRTS_DESTROY_EAST = uRTS_DESTROY_EAST + _price};
			if (side _grp == east) then {uRTS_DESTROY_WEST = uRTS_DESTROY_WEST + _price};
			deleteMarker _x;
		};
	}forEach (allMapmarkers select {_x find "uRTS_GRP_" == 0});
};

0 spawn {while {true} do {
/// game logic
/// ai
}};

0 spawn {while {true} do {
	_tracking = 0 spawn uRTS_TRACKING;
	waituntil {scriptdone _tracking};
}};