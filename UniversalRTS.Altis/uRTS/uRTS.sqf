uRTS_NEURONACTIVATION = {
	private _side = _this select 0;
	private _pos = _this select 1;
	private _price = _this select 2;
	private _color = "ColorBlack";
	if (_side == west) then {_color = "ColorEAST"};
	if (_side == east) then {_color = "ColorWEST"};
	private _mrk = createMarker [str time, _pos];
	_mrk setMarkerColor _color;
	_mrk setMarkerType "hd_dot";
	_mrk setMarkerText ("+" + (str _price));
	sleep 60;
	deleteMarker _mrk;
};

/// how to fix group dismounting the vehicle and "cheating" the destruction value this way?
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
			if (side _grp == west) then {uRTS_DESTROY_EAST = uRTS_DESTROY_EAST + _price; publicVariable "uRTS_DESTROY_EAST"};
			if (side _grp == east) then {uRTS_DESTROY_WEST = uRTS_DESTROY_WEST + _price; publicVariable "uRTS_DESTROY_WEST"};
			[side _grp, getMarkerPos _x, _price] call uRTS_NEURONACTIVATION;
			deleteMarker _x;
		};
	}forEach (allMapmarkers select {_x find "uRTS_GRP_" == 0});
};

uRTS_GAMELOGIC = {
	{
		private _mrk = _x;
		private _size = (getMarkerSize _x) select 0;
		private _west = 0;
		private _east = 0;
		{
			private _side = (getMarkerType _x) select [0, 1];
			if ((getMarkerPos _x) inArea _mrk) then {
				if (_side == "b") then {_west = _west + 1};
				if (_side == "o") then {_east = _east + 1};
			};
		}forEach (allMapmarkers select {_x find "uRTS_GRP_" == 0});
		
		if (_west > _east) then {
			_mrk setMarkercolor "ColorWEST"; 
			uRTS_CAPTURE_WEST = uRTS_CAPTURE_WEST + 1;
			uRTS_RESERVE_WEST = uRTS_RESERVE_WEST + 1;
			publicVariable "uRTS_CAPTURE_WEST";
			publicVariable "uRTS_RESERVE_WEST";			
		};
		
		if (_east > _west) then {
			_mrk setMarkercolor "ColorEAST"; 
			uRTS_CAPTURE_EAST = uRTS_CAPTURE_EAST + 1;
			uRTS_RESERVE_EAST = uRTS_RESERVE_EAST + 1;
			publicVariable "uRTS_CAPTURE_EAST";
			publicVariable "uRTS_RESERVE_EAST";			
		};
		
		if (_west == _east or (_west != 0 && _east != 0)) then {
			_mrk setMarkercolor "ColorBlack";	
		};
	}forEach uRTS_OBJECTIVES;

	if (uRTS_CAPTURE_WEST >= uRTS_CAPTURE) then {"end1" call BIS_fnc_endMission};
	if (uRTS_DESTROY_WEST >= uRTS_DESTROY) then {"end2" call BIS_fnc_endMission};
	if (uRTS_CAPTURE_EAST >= uRTS_CAPTURE) then {"end3" call BIS_fnc_endMission};
	if (uRTS_DESTROY_EAST >= uRTS_DESTROY) then {"end4" call BIS_fnc_endMission};
};

0 spawn {while {true} do {
	sleep uRTS_TIMER;
	_tracking = 0 spawn uRTS_GAMELOGIC;
	waituntil {scriptdone _tracking};
}};

0 spawn {while {true} do {
	_tracking = 0 spawn uRTS_TRACKING;
	waituntil {scriptdone _tracking};
}};