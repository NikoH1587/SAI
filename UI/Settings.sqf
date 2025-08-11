createDialog "SAI_GUI_SETTINGS";
_display = findDisplay 1000;

/// WEST FACTION SELECTION
private _setWest = _display displayCtrl 1001;
_setWest lbAdd "Default (NATO)";
{
	_cfg = SAI_CFG_FACNAMES select _forEachIndex;
	_setWest lbAdd (_cfg);
}forEach SAI_CFG_FACNAMES;
_setWest lbSetCurSel 0;

/// WEST COMPOSITION SELECTION
private _west_com = _display displayCtrl 1002;
_west_com lbAdd "Combined Arms";
_west_com lbAdd "Infantry";
_west_com lbAdd "Motorized";
_west_com lbAdd "Mechanized";
_west_com lbAdd "Airmobile";
_west_com lbAdd "CUSTOM";
_west_com lbSetCurSel 0;

/// EAST FACTION SELECTION
private _setEast = _display displayCtrl 1003;
_setEast lbAdd "Default (CSAT)";
{
	_cfg = SAI_CFG_FACNAMES select _forEachIndex;
	_setEast lbAdd (_cfg);
}forEach SAI_CFG_FACNAMES;
_setEast lbSetCurSel 0;

/// EAST COMPOSITION SELECTION
private _east_com = _display displayCtrl 1004;
_east_com lbAdd "Combined Arms";
_east_com lbAdd "Infantry";
_east_com lbAdd "Motorized";
_east_com lbAdd "Mechanized";
_east_com lbAdd "Airmobile";
_east_com lbAdd "CUSTOM";
_east_com lbSetCurSel 0;

/// CONDITIONS SETTINGS
private _conditions = _display displayCtrl 1011;
_conditions lbAdd "Random conditions";
_conditions lbAdd "Morning - Clear";
_conditions lbAdd "Day - Clear";
_conditions lbAdd "Evening - Clear";
_conditions lbAdd "Night - Clear";
_conditions lbAdd "Morning - Cloudy";
_conditions lbAdd "Day - Cloudy";
_conditions lbAdd "Evening - Cloudy";
_conditions lbAdd "Night - Cloudy";
_conditions lbAdd "Morning - Storm";
_conditions lbAdd "Day - Storm";
_conditions lbAdd "Evening - Storm";
_conditions lbAdd "Night - Storm";
_conditions lbSetCurSel 0;

/// SCENARIO SETTINGS
_scale = _display displayCtrl 1012;
_scale lbAdd "Random scenario";
_scale lbAdd "Skirmish - Gambit";
_scale lbAdd "Battle - Gambit";
_scale lbAdd "Campaign - Gambit";
_scale lbAdd "Skirmish - Attack";
_scale lbAdd "Battle - Attack";
_scale lbAdd "Campaign - Attack";
_scale lbAdd "Skirmish - Defend";
_scale lbAdd "Battle - Defend";
_scale lbAdd "Campaign - Defend";
_scale lbSetCurSel 0;