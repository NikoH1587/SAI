[] call BIS_fnc_jukebox;

///call compile preprocessFile "UI\Command.sqf";

if (!isServer) exitWith {};

if (isDedicated) then {
	call compile preprocessFile "UI\Config.sqf";
	call compile preprocessFile "UI\Functions.sqf";
    [0] call SAI_FNC_SET_WEST;
    [0] call SAI_FNC_COM_WEST;
    [0] call SAI_FNC_SET_EAST;
    [0] call SAI_FNC_COM_EAST;
    [0] call SAI_FNC_SET_TIME;
    [0] call SAI_FNC_SET_WEATHER;
    [1] call SAI_FNC_SET_SCALE;
    [1] call SAI_FNC_SET_DIFFICULTY;
    [2] call SAI_FNC_SET_ROLE;
	
	diag_log "HIVE Battle Generator launched automatically on dedicated with default parameters.";
	execVM "SAI.sqf";
	true exitWith {};
};

if (!isServer) exitWith {};

sleep 0.1;
call compile preprocessFile "UI\Config.sqf";
call compile preprocessFile "UI\Functions.sqf";
call compile preprocessFile "UI\Settings.sqf";