uRTS_SORTING = compile preprocessFileLineNumbers "uRTS\Sorting.sqf";
uRTS_TRACKING = compile preprocessFileLineNumbers "uRTS\Tracking.sqf";
uRTS_START = compile preprocessFileLineNumbers "uRTS\Start.sqf";
call compile preprocessFileLineNumbers "uRTS\Commands.sqf";

0 spawn {while {true} do {
	_start = 0 spawn uRTS_START;
	waituntil {scriptdone _start};
	_sorting = 0 spawn uRTS_SORTING;
	waituntil {scriptdone _sorting};
	_tracking = 0 spawn uRTS_TRACKING;
	waitUntil {scriptdone _tracking};
	sleep 5;
}};