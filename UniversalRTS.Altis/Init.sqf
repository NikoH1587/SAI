uRTS_FNC_PLAY = {
	call compile preprocessFile "uRTS\Scenario.sqf";
};

uRTS_FNC_JOIN = {
	closeDialog 0;
	call compile preprocessFile "uRTS\Player.sqf";
	call compile preprocessFile "uRTS\Commands.sqf";
	openMap [true, true];
	if (playerSide == west) then {mapAnimAdd [0, 0.33, getMarkerPos "respawn_west"]; mapAnimCommit; player setPos getMarkerPos "respawn_west"};
	if (playerSide == east) then {mapAnimAdd [0, 0.33, getMarkerPos "respawn_east"]; mapAnimCommit; player setPos getMarkerPos "respawn_east"};
	{_x = nil}forEach uRTS_CFG_ALL;
	uRTS_CFG_ALL = nil;
	uRTS_CFG_FACTIONS = nil;
};

[] call BIS_fnc_jukebox;
enableTeamSwitch false;
call compile preprocessFile "uRTS\Config.sqf";
call compile preprocessFile "uRTS\Functions.sqf";
call compile preprocessFile "uRTS\GUI.sqf";