uRTS_FNC_PLAY = {
	call compile preprocessFile "uRTS\Scenario.sqf";
};

uRTS_FNC_JOIN = {
	closeDialog 0;
	call compile preprocessFile "uRTS\Player.sqf";
	call compile preprocessFile "uRTS\Commands.sqf";
	if (playerSide == west) then {mapAnimAdd [0, 0.33, getMarkerPos "respawn_west"]; mapAnimCommit};
	if (playerSide == east) then {mapAnimAdd [0, 0.33, getMarkerPos "respawn_east"]; mapAnimCommit};
};

[] call BIS_fnc_jukebox;
enableTeamSwitch false;
call compile preprocessFile "uRTS\Config.sqf";
call compile preprocessFile "uRTS\Functions.sqf";
call compile preprocessFile "uRTS\GUI.sqf";