createDialog "uRTS_GUI";
private _display = findDisplay 1000;

/// TEXT
_display displayCtrl 1002 ctrlSetText str uRTS_CFG;

if (uRTS_CFG_IMPORT == false) then {
	_display displayCtrl 1003 ctrlSetText "Universal RTS Version 1";
	_display displayCtrl 1004 ctrlSetText "Made by Kosmokainen";

	_display displayCtrl 1005 lbAdd "Creating a deck:";
	_display displayCtrl 1005 lbAdd "Select faction and then type.";
	_display displayCtrl 1005 lbAdd "Select unit from list.";
	_display displayCtrl 1005 lbAdd "Click west/east list.";
	_display displayCtrl 1005 lbAdd "";
	_display displayCtrl 1005 lbAdd "Importing scenarios:";
	_display displayCtrl 1005 lbAdd "Select array next to 'IMPORT/EXPORT' with ctrl+a.";
	_display displayCtrl 1005 lbAdd "Clear array with backspace.";
	_display displayCtrl 1005 lbAdd "Paste deck/scenario with ctrl+v.";
	_display displayCtrl 1005 lbAdd "Click 'IMPORT/EXPORT' to load.";
	_display displayCtrl 1005 lbAdd "";
	_display displayCtrl 1005 lbAdd "Exporting decks:";
	_display displayCtrl 1005 lbAdd "Select array next to 'IMPORT/EXPORT' with ctrl+a.";
	_display displayCtrl 1005 lbAdd "Copy with ctrl+c.";
	_display displayCtrl 1005 lbAdd "Check out workshop discussions thread!";
	
} else {

	_display displayCtrl 1003 ctrlSetText ((uRTS_CFG select 0) select 0);
	_display displayCtrl 1004 ctrlSetText ((uRTS_CFG select 0) select 1);
	
	{
		_display displayCtrl 1005 lbAdd _x;
	}forEach ((uRTS_CFG select 0) select 2);
};

/// CONFIG
for "_i" from 0 to (count uRTS_CFG_FACTIONS) do {
	_display displayCtrl 1006 lbAdd (uRTS_CFG_FACTIONS select _i);
};

_display displayCtrl 1007 lbAdd "Recon";
_display displayCtrl 1007 lbAdd "Infantry";
_display displayCtrl 1007 lbAdd "Statics";
_display displayCtrl 1007 lbAdd "Vehicle";
_display displayCtrl 1007 lbAdd "Support";
_display displayCtrl 1007 lbAdd "Motorized";
_display displayCtrl 1007 lbAdd "Mechanized";
_display displayCtrl 1007 lbAdd "Autonomous";
_display displayCtrl 1007 lbAdd "Armor";
_display displayCtrl 1007 lbAdd "Artillery";
_display displayCtrl 1007 lbAdd "Helicopter";
_display displayCtrl 1007 lbAdd "Plane";

/// Scenario
_display displayCtrl 1013 lbAdd "Random Time";
_display displayCtrl 1013 lbAdd "Dawn";
_display displayCtrl 1013 lbAdd "Day";
_display displayCtrl 1013 lbAdd "Dusk";
_display displayCtrl 1013 lbAdd "Night";
_display displayCtrl 1013 lbSetCurSel 0;

_display displayCtrl 1014 lbAdd "Random Weather";
_display displayCtrl 1014 lbAdd "Clear";
_display displayCtrl 1014 lbAdd "Cloudy";
_display displayCtrl 1014 lbAdd "Storm";
_display displayCtrl 1014 lbSetCurSel 0;

_display displayCtrl 1015 lbAdd "5 Objectives";
_display displayCtrl 1015 lbAdd "7 Objectives";
_display displayCtrl 1015 lbAdd "9 Objectives";
_display displayCtrl 1015 lbSetCurSel 0;

_display displayCtrl 1016 lbAdd "Placeholder";
_display displayCtrl 1016 lbSetCurSel 0;