///createDialog "SCS_MENU2";
private _display = findDisplay 1100;
openmap true;
(findDisplay 46) createDisplay "SCS_MENU2";

SCS_MENU2_MODE = "SELECT";
SCS_MENU2_SELECTED = "NONE";
SCS_MENU2_RADIUS = "NONE";
SCS_MENU2_TURN = "WEST";

SCS_MENU2_SELECT = {
	private _pos = _this select 0;
	private _side = _this select 1;
	private _nearest = "NONE";
	private _distance = 100000;
	{
		private _mrk = _x select [0, 8];
		private _dist = (getMarkerPos _x) distance _pos;
		if (_dist < _distance && _mrk == "SCS_WEST" && _side == west && _dist < 500) then {_nearest = _x};
	}forEach allMapMarkers;
	if (_nearest != "NONE") then {
		SCS_MENU2_SELECTED = _nearest;
		private _radius = createMarker ["SCS_RADIUS_" + str _side, getMarkerPos _nearest];
		SCS_MENU2_RADIUS = _radius;
		_radius setMarkerShape "ELLIPSE";
		_radius setMarkerSize [2000, 2000];
		_radius setMarkerBrush "Border";
		if (_side == west) then {_radius setMarkerColor "ColorBLUFOR"};
		if (_side == east) then {_radius setMarkerColor "ColorOPFOR"};
		SCS_MENU2_MODE = "MOVE";
	};
};

SCS_MENU2_MOVE = {
	private _pos = _this select 0;
	private _dist = _pos distance (getMarkerPos SCS_MENU2_SELECTED);
	if (_pos inArea SCS_MENU2_RADIUS && surfaceIsWater _pos == false) then {
		SCS_MENU2_SELECTED setMarkerPos _pos;
		deleteMarker SCS_MENU2_RADIUS;
		SCS_MENU2_RADIUS = "NONE";
		SCS_MENU2_SELECTED = "NONE";
		SCS_MENU2_MODE = "DONE";
	};
};

onMapSingleClick {
	if (SCS_MENU2_MODE == "SELECT") exitWith {[_pos, playerside] call SCS_MENU2_SELECT; true};
	if (SCS_MENU2_MODE == "MOVE") exitWith {[_pos] call SCS_MENU2_MOVE; true};
	false
};




/// for helo spawning?: [position, radius, random, types] call BIS_fnc_nearestHelipad


///createDialog "SCS_MENU2";
private _display = findDisplay 1100;
openmap true;
(findDisplay 46) createDisplay "SCS_MENU2";

SCS_MENU2_MODE = "SELECT";
SCS_MENU2_SELECTED = "NONE";
SCS_MENU2_RADIUS = "NONE";
SCS_MENU2_TURN = "WEST";

SCS_MENU2_SELECT = {
	private _pos = _this select 0;
	private _side = _this select 1;
	private _nearest = "NONE";
	private _distance = 100000;
	{
		private _mrk = _x select [0, 8];
		private _dist = (getMarkerPos _x) distance _pos;
		if (_dist < _distance && _mrk == "SCS_WEST" && _side == west && _dist < 500) then {_nearest = _x};
	}forEach allMapMarkers;
	if (_nearest != "NONE") then {
		SCS_MENU2_SELECTED = _nearest;
		private _radius = createMarker ["SCS_RADIUS_" + str _side, getMarkerPos _nearest];
		SCS_MENU2_RADIUS = _radius;
		_radius setMarkerShape "ELLIPSE";
		_radius setMarkerSize [2000, 2000];
		_radius setMarkerBrush "Border";
		if (_side == west) then {_radius setMarkerColor "ColorBLUFOR"};
		if (_side == east) then {_radius setMarkerColor "ColorOPFOR"};
		SCS_MENU2_MODE = "MOVE";
	};
};

SCS_MENU2_MOVE = {
	private _pos = _this select 0;
	private _dist = _pos distance (getMarkerPos SCS_MENU2_SELECTED);
	if (_pos inArea SCS_MENU2_RADIUS && surfaceIsWater _pos == false) then {
		SCS_MENU2_SELECTED setMarkerPos _pos;
		deleteMarker SCS_MENU2_RADIUS;
		SCS_MENU2_RADIUS = "NONE";
		SCS_MENU2_SELECTED = "NONE";
		SCS_MENU2_MODE = "DONE";
	};
};

onMapSingleClick {
	if (SCS_MENU2_MODE == "SELECT") exitWith {[_pos, playerside] call SCS_MENU2_SELECT; true};
	if (SCS_MENU2_MODE == "MOVE") exitWith {[_pos] call SCS_MENU2_MOVE; true};
	false
};




/// for helo spawning?: [position, radius, random, types] call BIS_fnc_nearestHelipad