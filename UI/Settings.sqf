createDialog "SAI_GUI_SETTINGS";
_display = findDisplay 1000;
/// get date from save
/// get progress from save

/// WEST FACTION SELECTION
_setWest = _display displayCtrl 1001;
_setWest lbAdd "Default (NATO)";
{
	_cfg = SAI_CFG_FACNAMES select _forEachIndex;
	_setWest lbAdd (_cfg);
}forEach SAI_CFG_FACNAMES;
_setWest lbSetCurSel 0;
[0] call SAI_FNC_SET_WEST;

/// WEST COMPOSITION SELECTION
_west_com = _display displayCtrl 1002;
_west_com lbAdd "Combined Arms";
_west_com lbAdd "Infantry";
_west_com lbAdd "Motorized";
_west_com lbAdd "Mechanized";
_west_com lbAdd "Airmobile";
_west_com lbAdd "CUSTOM";
_west_com lbSetCurSel 0;
[0] call SAI_FNC_COM_WEST;

/// EAST FACTION SELECTION
_setEast = _display displayCtrl 1003;
_setEast lbAdd "Default (CSAT)";
{
	_cfg = SAI_CFG_FACNAMES select _forEachIndex;
	_setEast lbAdd (_cfg);
}forEach SAI_CFG_FACNAMES;
_setEast lbSetCurSel 0;
[0] call SAI_FNC_SET_EAST;

/// EAST COMPOSITION SELECTION
_east_com = _display displayCtrl 1004;
_east_com lbAdd "Combined Arms";
_east_com lbAdd "Infantry";
_east_com lbAdd "Motorized";
_east_com lbAdd "Mechanized";
_east_com lbAdd "Airmobile";
_east_com lbAdd "CUSTOM";
_east_com lbSetCurSel 0;
[0] call SAI_FNC_COM_EAST;

/// TIME SETTINGS
_time = _display displayCtrl 1011;
_time lbAdd "Random";
_time lbAdd "Morning";
_time lbAdd "Day";
_time lbAdd "Evening";
_time lbAdd "Night";
_time lbSetCurSel 0;
[0] call SAI_FNC_SET_TIME;

/// WEATHER SETTINGS
_weather = _display displayCtrl 1012;
_weather lbAdd "Random";
_weather lbAdd "Clear";
_weather lbAdd "Cloudy";
_weather lbAdd "Storm";
_weather lbSetCurSel 0;
[0] call SAI_FNC_SET_WEATHER;

/// SCALE SETTINGS
_scale = _display displayCtrl 1013;
_scale lbAdd "Skirmish";
_scale lbAdd "Battle";
_scale lbAdd "Campaign";
_scale lbSetCurSel 1;
[1] call SAI_FNC_SET_SCALE;

/// DIFFICULTY SETTINGS
_difficulty = _display displayCtrl 1021;
_difficulty lbAdd "Easy";
_difficulty lbAdd "Normal";
_difficulty lbAdd "Hard";
_difficulty lbSetCurSel 1;
[1] call SAI_FNC_SET_DIFFICULTY;

/// ROLE SETTINGS
_role = _display displayCtrl 1022;
_role lbAdd "Soldier";
_role lbAdd "Leader";
_role lbAdd "Commander";
_role lbSetCurSel 1;
[1] call SAI_FNC_SET_ROLE;