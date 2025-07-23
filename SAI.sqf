if (!isServer) exitWith {};

SAI_WEST = west;
SAI_EAST = east;

SAI_DEBUG = true;
SAI_ACTIVE = true;
SAI_BLACKLIST = [];
SAI_FORCE_WEST = 0;
SAI_FORCE_EAST = 0;

SAI_FNC_WAYPOINTS = compile preprocessFileLineNumbers "SAI\Waypoints.sqf";
SAI_FNC_SORTING = compile preprocessFileLineNumbers "SAI\Sorting.sqf";
SAI_FNC_STRATEGIC = compile preprocessFileLineNumbers "SAI\Strategic.sqf";
SAI_FNC_OPERATIONS = compile preprocessFileLineNumbers "SAI\Operations.sqf";
SAI_FNC_TACTICS = compile preprocessFileLineNumbers "SAI\Tactics.sqf";

execVM "SAI\Spawning.sqf";
execVM "SAI\Markers.sqf";
execVM "SAI\Waypoints.sqf";

0 spawn {while {SAI_ACTIVE} do {
	_sorting = 0 spawn SAI_FNC_SORTING;
	waitUntil {scriptDone _sorting};	
	_strategic = 0 spawn SAI_FNC_STRATEGIC;
	waitUntil {scriptDone _strategic};
	_operations = 0 spawn SAI_FNC_OPERATIONS;
	waitUntil {scriptDone _operations};
	_tactics = 0 spawn SAI_FNC_TACTICS;
	waitUntil {scriptDone _tactics};
	sleep 60;
}};