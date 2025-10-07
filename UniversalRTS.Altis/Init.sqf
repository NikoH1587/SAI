[] call BIS_fnc_jukebox;
if (!isServer) then {call compile preprocessFile "uRTS\Player.sqf"};
if (!isServer) then {call compile preprocessFile "uRTS\Commands.sqf"};
if (!isServer) exitWith {};

enableTeamSwitch false;
sleep 0.1;
call compile preprocessFile "uRTS\Config.sqf";
call compile preprocessFile "uRTS\Functions.sqf";

/// Dedicated starts with default settings
/// sp/hosted starts with menu
if (isDedicated) then {
	[] call uRTS_FNC_PLAY;
} else {
	call compile preprocessFile "uRTS\GUI.sqf";
};