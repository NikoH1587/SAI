/// Configuration
private _cfg = uRTS_CFG select 1;

private _time = _cfg select 0;
private _weather = _cfg select 1;
private _objectives = _cfg select 2;
private _placeholder1 = _cfg select 3;
private _placeholder1 = _cfg select 4;
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
private _mod = 5;
if (_objectives == 1) then {_mod = 7};
if (_objectives == 2) then {_mod = 9};
uRTS_SIZE = 250;

/// Select objetives
private _randomPos = [] call BIS_fnc_randomPos;
private _locations = nearestLocations [_randomPos, ["NameCityCapital", "NameCity", "NameVillage", "NameLocal", "Hill"], worldSize];
{
	private _loc = _x;
	{
		if ((_x != _loc && _x distance _loc < 500)) then {_locations = _locations - [_x]};
	}forEach _locations;
}forEach _locations;

private _locations = _locations select [0, _mod];

uRTS_OBJECTIVES = [];
{
	private _mrk = createMarker ["uRTS_OBJ_" + (str _forEachIndex), position _x];
	_mrk setMarkerShape "RECTANGLE";
	_mrk setMarkerSize [uRTS_SIZE, uRTS_SIZE];
	_mrk setMarkerBrush "SolidBorder";
	_mrk setMarkerAlpha 0.5;
	uRTS_OBJECTIVES append [_mrk];
}forEach _locations;

/// Select bases

private _far = [0, "", ""];

{
	private _mrk = _x;
	private _pos = getMarkerPos _x;
	{
		private _dist = _pos distance (getMarkerPos _x);
		if (_dist > (_far select 0)) then {_far = [_dist, _mrk, _x]};
	}forEach uRTS_OBJECTIVES;
}forEach uRTS_OBJECTIVES;

private _rand = [[1, 2],[2, 1]] select floor random 2;
private _westBase = _far select (_rand select 0);
private _eastBase = _far select (_rand select 1);
_westbase setMarkerColor "ColorWEST";
_westbase setMarkerSize [uRTS_SIZE * 2, uRTS_SIZE * 2];
_eastbase setMarkerColor "ColorEAST";
_eastbase setMarkerSize [uRTS_SIZE * 2, uRTS_SIZE * 2];

/// Rotate markers
{
	private _dir = (getmarkerPos _westBase) getdir (getmarkerPos _eastBase);
	_x setMarkerDir _dir;
}forEach uRTS_OBJECTIVES;

/// Game variables
uRTS_RESERVE = 5 * _mod;
uRTS_CAPTURE = 15 * _mod;
uRTS_DESTROY = 10 * _mod;

publicVariable "uRTS_RESERVE";
publicVariable "uRTS_CAPTURE";
publicVariable "uRTS_DESTROY";
publicVariable "uRTS_RESPAWN";

uRTS_RESERVE_WEST = uRTS_RESERVE;
uRTS_CAPTURE_WEST = 0;
uRTS_DESTROY_WEST = 0;
publicVariable "uRTS_RESERVE_WEST";
publicVariable "uRTS_CAPTURE_WEST";
publicVariable "uRTS_DESTROY_WEST";

uRTS_RESERVE_EAST = uRTS_RESERVE;
uRTS_CAPTURE_EAST = 0;
uRTS_DESTROY_EAST = 0;
publicVariable "uRTS_RESERVE_EAST";
publicVariable "uRTS_CAPTURE_EAST";
publicVariable "uRTS_DESTROY_EAST";

uRTS_TIMER = 60;
publicVariable "uRTS_TIMER";

/// Run custom code
call _code;

/// reset the cfg variables
{_x = nil}forEach uRTS_CFG_ALL;

/// Start game!
createMarker ["respawn_west", getMarkerpos _westbase];
createMarker ["respawn_east", getMarkerpos _eastbase];
call compile preprocessFile "uRTS\uRTS.sqf";
[] remoteExec ["uRTS_PLAYER_START", 0, true];