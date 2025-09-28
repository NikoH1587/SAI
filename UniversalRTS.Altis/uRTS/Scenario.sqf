/// Configuration
private _cfg = uRTS_CFG select 1;

private _time = _cfg select 0;
private _weather = _cfg select 1;
private _objectives = _cfg select 2;
private _scenario = _cfg select 3;
private _side = _cfg select 4; /// Can be left as placeholder for future
private _code = _cfg select 5;

uRTS_WEST = uRTS_CFG select 2;
uRTS_EAST = uRTS_CFG select 3;

publicVariable "uRTS_WEST";
publicVariable "uRTS_EAST";

/// Weather
switch (_weather) do {
	case 1: {0 setOvercast 0};
	case 2: {0 setOvercast 0.5};
	case 3: {0 setOvercast 1};
	default {0 setOvercast (random 1)};
};

forceWeatherChange;

/// Time
private _suntime = date call BIS_fnc_sunriseSunsetTime;
private _sunrise = _suntime select 0;
private _sunset = _suntime select 1;
private _day = random [_sunrise, (_sunrise + _sunset) / 2, _sunset];
private _night = random _sunrise;

switch (_time) do {
	case 1: {_time = _sunrise};
	case 2: {_time = _day};
	case 3: {_time = _sunset};
	case 4: {_time = _night};
	default {_time = random [0, 11.5, 23]};
};

[[date select 0, date select 1, date select 2, _time, 0]] remoteExec ["setDate"];

/// Size

uRTS_SIZE = 250;

/// Objectives
switch (_objectives) do {
	case 1: {_objectives = 7};
	case 2: {_objectives = 9};
	default {_objectives = 5};
};

private _randomPos = [] call BIS_fnc_randomPos;
private _locations = nearestLocations [_randomPos, ["NameCityCapital", "NameCity", "NameVillage", "NameLocal", "Hill"], worldSize];
private _locations = _locations select [0, _objectives];

private _randomDir = _randomPos getPos [worldSize, random 360];
_locations = [_locations, [], {(position _x) distance _randomDir}, "ASCEND"] call BIS_fnc_sortBy;

uRTS_OBJECTIVES = [];

{
	private _mrk = createMarker ["uRTS_OBJ_" + (str _forEachIndex), position _x];
	_mrk setMarkerShape "RECTANGLE";
///	_mrk setMarkerSize [(size _x select 0) max uRTS_SIZE, (size _x select 1) max uRTS_SIZE];
	_mrk setMarkerSize [uRTS_SIZE, uRTS_SIZE];
	_mrk setMarkerBrush "SolidBorder";
	_mrk setMarkerAlpha 0.5;
	_mrk setMarkerDir (position _x getDir _randomDir);
	uRTS_OBJECTIVES append [_mrk];
}forEach _locations;

/// Scenario
private _westbase = (uRTS_OBJECTIVES select 0);
private _eastbase = (uRTS_OBJECTIVES select ((count uRTS_OBJECTIVES) - 1));
_westbase setMarkerColor "ColorWEST";
_eastbase setMarkerColor "ColorEAST";

private _neutrals = uRTS_OBJECTIVES - ([_westbase] + [_eastbase]);

switch (_scenario) do {
	case 1: {{_x setMarkerColor "ColorEAST"}forEach _neutrals};
	case 2: {{_x setMarkerColor "ColorWEST"}forEach _neutrals};
	default {{_x setMarkerColor "ColorBLACK"}forEach _neutrals};
};

/// Loadouts
private _westSLD = "B_Soldier_F";
private _eastSLD = "O_Soldier_F";

{
	{
		if (_x isKindOf "Man" && _westSLD == "B_Soldier_F") then {_westSLD = _x};
	}forEach (_x select 2);
}forEach uRTS_WEST;

{
	{
		if (_x isKindOf "Man" && _eastSLD == "O_Soldier_F") then {_eastSLD = _x};
	}forEach (_x select 2);
}forEach uRTS_EAST;

uRTS_LOAD_WEST = getUnitLoadout _westSLD;
uRTS_LOAD_EAST = getUnitLoadout _eastSLD;

/// Starting points
uRTS_POINTS_WEST = 5;
uRTS_POINTS_EAST = 5;
publicVariable "uRTS_POINTS_WEST";
publicVariable "uRTS_POINTS_EAST";

/// Run custom code
call _code;

/// Start game!
private _rspW = createMarker ["respawn_west", getMarkerpos _westbase];
private _rspE = createMarker ["respawn_east", getMarkerpos _eastbase];
private _uRTS = createMarker ["uRTS_ACTIVE", [0, 0, 0]];
call compile preprocessFile "uRTS\uRTS.sqf";