createDialog "SAI_GUI_SETTINGS";
_display = findDisplay 1000;

/// WEST FACTION SELECTION
private _setWest = _display displayCtrl 1001;
_setWest lbAdd "Default (NATO)";
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
_scenario lbAdd "Skirmish - Gambit";
_scenario lbAdd "Skirmish - Attack";
_scenario lbAdd "Skirmish - Defend";
_scenario lbAdd "Battle - Gambit";
_scenario lbAdd "Battle - Attack";
_scenario lbAdd "Battle - Defend";
_scenario lbSetCurSel 0;