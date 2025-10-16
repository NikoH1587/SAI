createDialog "uRTS_GUI";
private _display = findDisplay 1000;

/// CONFIG
for "_i" from 0 to (count uRTS_CFG_FACTIONS) do {
	_display displayCtrl 1001 lbAdd (uRTS_CFG_FACTIONS select _i);
};

_display displayCtrl 1002 lbAdd "Recon";
_display displayCtrl 1002 lbAdd "Infantry";
_display displayCtrl 1002 lbAdd "Statics";
_display displayCtrl 1002 lbAdd "Vehicle";
_display displayCtrl 1002 lbAdd "Support";
_display displayCtrl 1002 lbAdd "Motorized";
_display displayCtrl 1002 lbAdd "Mechanized";
_display displayCtrl 1002 lbAdd "Autonomous";
_display displayCtrl 1002 lbAdd "Armor";
_display displayCtrl 1002 lbAdd "Artillery";
_display displayCtrl 1002 lbAdd "Helicopter";
_display displayCtrl 1002 lbAdd "Plane";
_display displayCtrl 1002 lbAdd "Naval";

/// Scenario
_display displayCtrl 1008 lbAdd "Random Time";
_display displayCtrl 1008 lbAdd "Dawn";
_display displayCtrl 1008 lbAdd "Day";
_display displayCtrl 1008 lbAdd "Dusk";
_display displayCtrl 1008 lbAdd "Night";
_display displayCtrl 1008 lbSetCurSel 0;

_display displayCtrl 1009 lbAdd "Random Weather";
_display displayCtrl 1009 lbAdd "Clear";
_display displayCtrl 1009 lbAdd "Cloudy";
_display displayCtrl 1009 lbAdd "Storm";
_display displayCtrl 1009 lbSetCurSel 0;

_display displayCtrl 1010 lbAdd "Skirmish (5 objectives)";
_display displayCtrl 1010 lbAdd "Battle (7 Objectives)";
_display displayCtrl 1010 lbAdd "Campaign (9 Objectives)";
_display displayCtrl 1010 lbSetCurSel 0;

_display displayCtrl 1012 lbAdd "AI Commander WEST: ON";
_display displayCtrl 1012 lbAdd "AI Commander WEST: OFF";
_display displayCtrl 1012 lbSetCurSel 0;

_display displayCtrl 1013 lbAdd "AI Commander EAST: ON";
_display displayCtrl 1013 lbAdd "AI Commander EAST: OFF";
_display displayCtrl 1013 lbSetCurSel 0;

_display displayCtrl 1014 lbAdd "Normal (West = East)";
_display displayCtrl 1014 lbAdd "Easy (West > East)";
_display displayCtrl 1014 lbAdd "Hard (West < East)";
_display displayCtrl 1014 lbSetCurSel 0;