createDialog "SCS_MENU1";
private _display = findDisplay 1000;
private _iconsWest = [
"\A3\ui_f\data\map\markers\nato\b_inf.paa",
"\A3\ui_f\data\map\markers\nato\b_motor_inf.paa",
"\A3\ui_f\data\map\markers\nato\b_mech_inf.paa",
"\A3\ui_f\data\map\markers\nato\b_recon.paa"
];

private _markersWest = [
"b_inf", "b_motor_inf", "b_mech_inf", "b_recon"
];
private _iconsEast = [
"\A3\ui_f\data\map\markers\nato\o_inf.paa",
"\A3\ui_f\data\map\markers\nato\o_motor_inf.paa",
"\A3\ui_f\data\map\markers\nato\o_mech_inf.paa",
" \A3\ui_f\data\map\markers\nato\o_recon.paa"
];

private _markersEast = [
"o_inf","o_motor_inf","o_mech_inf","o_recon"
];

SCS_CFG_FAC = ("getNumber (_x >> 'side') in [0, 1, 2]" configClasses (configFile >> "CfgFactionClasses")) apply {
	[configname _x, getText (_x >> "displayName")]
};
SCS_CFG_GRP = ([(configFile >> "cfgGroups"), 3, false] call BIS_fnc_returnChildren) apply {
	[getText (_x >> "faction"), _x, getText (_x >> "name"), getText (_x >> "icon")]
};
SCS_CFG_VEH = ("getNumber (_x >> 'side') in [0, 1, 2] && getNumber (_x >> 'scope') == 2 && getNumber (_x >> 'isMan') == 0" configClasses (configFile >> "CfgVehicles")) apply {
	[getText (_x >> "faction"), configName _x, getText (_x >> "displayName"), getText (_x >> "picture")]
};

SCS_CFG_FAC = SCS_CFG_FAC select {(_x select 0) in (SCS_CFG_GRP apply {_x select 0})};
///SCS_CFG_FAC = SCS_CFG_FAC arrayIntersect SCS_CFG_FAC;

SCS_CFG = [
	[[0, 0], [0, 0], {}],
	[
		[
			["Alpha","b_unknown", [0, 0], 0],
			["","","","","","","","",""],
			{}
		],
		[
			["Bravo","b_unknown", [0, 0], 0],
			["","","","","","","","",""],
			{}
		],
		[
			["Charlie","b_unknown", [0, 0], 0],
			["","","","","","","","",""],
			{}
		],
		[
			["Delta","b_unknown", [0, 0], 0],
			["","","","","","","","",""],
			{}
		],
		[
			["Echo","b_unknown", [0, 0], 0],
			["","","","","","","","",""],
			{}
		]
	],
	[
		[
			["1st","o_unknown", [0, 0], 0],
			["","","","","","","","",""],
			{}
		],
		[
			["2nd","o_unknown", [0, 0], 0],
			["","","","","","","","",""],
			{}
		],
		[
			["3rd","o_unknown", [0, 0], 0],
			["","","","","","","","",""],
			{}
		],
		[
			["4th","o_unknown", [0, 0], 0],
			["","","","","","","","",""],
			{}
		],
		[
			["5th","o_unknown", [0, 0], 0],
			["","","","","","","","",""],
			{}
		]
	]
];

/// CONFIG
for "_i" from 0 to ((count SCS_CFG_FAC) - 1) do {
	private _config = (SCS_CFG_FAC select _i) select 0;
	private _name = (SCS_CFG_FAC select _i) select 1;
	_display displayCtrl 1001 lbAdd (_name + " - " + _config);
};

/// West list
private _listWest = _display displayCtrl 1004;
private _cfgWest = SCS_CFG select 1;
{
	private _text = (_x select 0) select 0;
	private _current = _listWest lbAdd _text;
	_listWest lbsetColor [_current, [1,1,0,1]];
	{
		_listWest lbAdd _x;
	}forEach (_x select 1);
}ForEach _cfgWest;

/// East list
private _listEast = _display displayCtrl 1005;
private _cfgEast = SCS_CFG select 2;
{
	private _text = (_x select 0) select 0;
	private _current = _listEast lbAdd _text;
	_listEast lbsetColor [_current, [1,1,0,1]];
	{
		_listEast lbAdd _x;
	}forEach (_x select 1);
}ForEach _cfgEast;

SCS_MENU1_UPDATE = {
	private _display = findDisplay 1000;
	private _export = _display displayCtrl 1006;
	_export ctrlSEtText (str SCS_CFG);
};

SCS_MENU1_LIST = {
	params ["_ctrl", "_value"];
	private _display = ctrlParent _ctrl;
	private _list = _display displayCtrl 1002;
	private _preview = _display displayCtrl 1003;
	lbClear _list;
	_list lbSetCurSel 0;
	lbClear _preview;
	_preview lbSetCurSel 0;
	private _faction = (SCS_CFG_FAC select _value) select 0;
	SCS_MENU1_SELECTIONS = [];
	
	{
		private _config = _x select 1;
		private _name = _x select 2;
		private _picture = _x select 3;
		private _vehicles = 0;
		
		{
			private _vehicle = getText (_x >> "vehicle");
			private _isMan = getNumber (configFile >> "cfgVehicles" >> _vehicle >> "isMan");
			if (_isMan == 0) then {_vehicles = _vehicles + 1};
		}forEach ("true" configClasses _config);
		
		if (_x select 0 == _faction && _vehicles < 3) then {
			SCS_MENU1_SELECTIONS append [_config];
			private _current = _list lbAdd _name;
			_list lbSetPicture [_current, _picture];
		};
	}forEach SCS_CFG_GRP;
	
	{
		private _config = _x select 1;
		private _name = _x select 2;
		private _picture = _x select 3;
		if (_x select 0 == _faction) then {
			SCS_MENU1_SELECTIONS append [[_config]];
			private _current = _list lbAdd _name;
			_list lbSetPicture [_current, _picture];
		};
	}forEach SCS_CFG_VEH;
};

SCS_MENU1_SELECT = {
	params ["_ctrl", "_value"];
	private _display = ctrlParent _ctrl;
	private _preview = _display displayCtrl 1003;
	lbClear _preview;
	
	SCS_MENU1_SELEC = SCS_MENU1_SELECTIONS select _value;
	
	if (SCS_MENU1_SELEC isEqualType []) then {
		private _vehicle = SCS_MENU1_SELEC select 0;
		private _picture = getText (configFile >> "cfgVehicles" >> _vehicle >> "editorPreview");
///		private _seats = getNumber (configFile >> "cfgVehicles" >> _vehicle >> "transportSoldier");
		private _current = _preview lbAdd "";
///		_preview lbAdd ("Cargo seats: " + str _seats);
		_preview lbSetPicture [_current, _picture];
	} else {
		private _group = SCS_MENU1_SELEC;
		private _configs = "true" configClasses _group;
		_pictures = [];	
		
		{
			private _vehicle = getText (_x >> "vehicle");
			private _picture = getText (configFile >> "cfgVehicles" >> _vehicle >> "editorPreview");
			private _current = _preview lbAdd "";
			_preview lbSetPicture [_current, _picture];
		}forEach _configs;
		_preview lbSetCurSel 0;
	};
};

SCS_MENU1_WEST_LIST = {
	params ["_ctrl", "_value"];
	private _display = ctrlParent _ctrl;
	private _list = _display displayCtrl 1002;
	private _select = lbCurSel _list;
	private _text = lbText [1002, _select];
	private _icon = lbPicture [1002, _select];
	
	if (_value in [0, 10, 20, 30, 40] == false) then {
		private _section = 0;
		private _mod = 1;
		_ctrl lbSetText [_value,  _text];
		_ctrl lbSetPicture [_value, _icon];
		if (_value > 10) then {_section = 1; _mod = 10 + 1};
		if (_value > 20) then {_section = 2; _mod = 20 + 1};
		if (_value > 30) then {_section = 2; _mod = 30 + 1};
		if (_value > 40) then {_section = 2; _mod = 40 + 1};
		private _cfg = ((SCS_CFG select 1) select _section) select 1;
		
		if (SCS_MENU1_SELEC isEqualType []) then {
			_cfg set [_value - _mod, SCS_MENU1_SELEC];
		} else {
			private _config = configHierarchy SCS_MENU1_SELEC;
			private _config = _config apply {configName _x};
			_config deleteAt [0, 1];
			_cfg set [_value - _mod, _config];
			hint str _cfg;
		}
	};
	0 call SCS_MENU1_UPDATE;
};

SCS_MENU1_EAST_LIST = {
	params ["_ctrl", "_value"];
	private _display = ctrlParent _ctrl;
	private _list = _display displayCtrl 1002;
	private _select = lbCurSel _list;
	private _text = lbText [1002, _select];
	private _icon = lbPicture [1002, _select];
	
	if (_value in [0, 10, 20, 30, 40] == false) then {
		private _section = 0;
		private _mod = 1;
		_ctrl lbSetText [_value,  _text];
		_ctrl lbSetPicture [_value, _icon];
		if (_value > 10) then {_section = 1; _mod = 10 + 1};
		if (_value > 20) then {_section = 2; _mod = 20 + 1};
		if (_value > 30) then {_section = 2; _mod = 30 + 1};
		if (_value > 40) then {_section = 2; _mod = 40 + 1};
		private _cfg = ((SCS_CFG select 2) select _section) select 1;
		
		if (SCS_MENU1_SELEC isEqualType []) then {
			_cfg set [_value - _mod, SCS_MENU1_SELEC];
		} else {
			private _config = configHierarchy SCS_MENU1_SELEC;
			private _config = _config apply {configName _x};
			_config deleteAt [0, 1];
			_cfg set [_value - _mod, _config];
			hint str _cfg;
		}
	};
	0 call SCS_MENU1_UPDATE;
};