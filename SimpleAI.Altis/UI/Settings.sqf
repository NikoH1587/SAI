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
_conditions lbAdd "Random weather";
_conditions lbAdd "Clear";
_conditions lbAdd "Overcast";
_conditions lbAdd "Storm";
_conditions lbSetCurSel 0;

/// SCENARIO SETTINGS
_scenario = _display displayCtrl 1012;
_scenario lbAdd "Random scenario";
_scenario lbAdd "Gambit";
_scenario lbAdd "Attack";
_scenario lbAdd "Defend";
_scenario lbSetCurSel 0;