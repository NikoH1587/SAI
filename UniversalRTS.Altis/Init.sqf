[] call BIS_fnc_jukebox;
call compile preprocessFile "uRTS\Player.sqf";
call compile preprocessFile "uRTS\Commands.sqf";
if (!isServer) exitWith {};

sleep 0.1;
call compile preprocessFile "uRTS\Config.sqf";
call compile preprocessFile "uRTS\Functions.sqf";

/// re-start uRTS loops if game is loaded from save

if ("uRTS_ACTIVE" in allMapMarkers) exitWith {};

/// Dedicated starts with default settings
/// sp/hosted starts with menu
if (isDedicated) then {
	[] call uRTS_FNC_PLAY;
} else {
	call compile preprocessFile "uRTS\GUI.sqf";
};