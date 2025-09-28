if (!isServer) exitWith {};

SAI_WEST = west;
SAI_EAST = east;

SAI_DEBUG = true;
SAI_ACTIVE = true;
SAI_BLACKLIST = [];
SAI_FORCE_WEST = 0;
SAI_FORCE_EAST = 0;

SAI_FNC_MARKERS = compile preprocessFileLineNumbers "SAI\Markers.sqf";
SAI_FNC_SPAWNING = compile preprocessFileLineNumbers "SAI\Spawning.sqf";
SAI_FNC_WAYPOINTS = compile preprocessFileLineNumbers "SAI\Waypoints.sqf";
SAI_FNC_SORTING = compile preprocessFileLineNumbers "SAI\Sorting.sqf";
SAI_FNC_TRACKING = compile preprocessFileLineNumbers "SAI\Tracking.sqf";
SAI_FNC_STRATEGIC = compile preprocessFileLineNumbers "SAI\Strategic.sqf";
SAI_FNC_OPERATIONS = compile preprocessFileLineNumbers "SAI\Operations.sqf";
SAI_FNC_TACTICS = compile preprocessFileLineNumbers "SAI\Tactics.sqf";

cutText [SAI_CFG_TITLE + " \n" + " \n" + SAI_CFG_DESCRIPTION, "BLACK IN", 10];

_markers = 0 spawn SAI_FNC_MARKERS;
waituntil {scriptDone _markers};
_spawn = 0 spawn SAI_FNC_SPAWNING;
waituntil {scriptDone _spawn};
_waypoints = 0 spawn SAI_FNC_WAYPOINTS;
waituntil {scriptDone _waypoints};

0 spawn {while {SAI_ACTIVE} do {
	_sorting = 0 spawn SAI_FNC_SORTING;
	waitUntil {scriptDone _sorting};
	_tracking = 0 spawn SAI_FNC_TRACKING;
	waitUntil {scriptDone _tracking};
	_strategic = 0 spawn SAI_FNC_STRATEGIC;
	waitUntil {scriptDone _strategic};
	_operations = 0 spawn SAI_FNC_OPERATIONS;
	waitUntil {scriptDone _operations};
	_tactics = 0 spawn SAI_FNC_TACTICS;
	waitUntil {scriptDone _tactics};
	sleep 10;
}};

sleep 1;

0 spawn {while {SAI_ACTIVE} do {
	_tracking = 0 spawn SAI_FNC_TRACKING;
	waitUntil {scriptDone _tracking};
	sleep 0.1;
}};

/// for future: getUnitLoadout, setUnitLoadout
/// add respawns (50%?) - replace squads invididually