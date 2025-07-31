createDialog "SAI_GUI_VEHICLES";
_display = findDisplay 2000;

/// WEST CUSTOM SELECTION
_vehicles = _display displayCtrl 2001;
{
	_name = SAI_CFG_CFGVEHNAMES select _forEachIndex;
	_vehicles lbAdd _name;
}forEach SAI_CFG_CFGVEHNAMES;


