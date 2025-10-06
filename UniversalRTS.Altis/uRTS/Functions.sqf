uRTS_FNC_UPDATE = {
	private _display = findDisplay 1000;
	
	lbClear 1002;
	_display displayCtrl 1002 ctrlSetText str uRTS_CFG;
	
	lbClear 1008;
	for "_i" from 0 to (count (uRTS_CFG select 2)) do {
		private _cfg = (uRTS_CFG select 2) select _i;
		private _price = str (_cfg select 0) + "¤ - ";
		private _name = (_cfg select 2) + " - ";
		private _count = str (count (_cfg select 3)) + "x";
		_display displayCtrl 1008 lbAdd (_price + _name + _count);
	};
	
	lbClear 1009;
	for "_i" from 0 to (count (uRTS_CFG select 3)) do {
		private _cfg = (uRTS_CFG select 3) select _i;
		private _price = str (_cfg select 0) + "¤ - ";
		private _name = (_cfg select 2) + " - ";
		private _count = str (count (_cfg select 3)) + "x";
		_display displayCtrl 1009 lbAdd (_price + _name + _count);
	};
	
};

uRTS_FNC_LIST = {
	params ["_ctrl", "_value"];
	private _display = ctrlParent _ctrl;
	private _list = _display displayCtrl 1010;
	private _faction = uRTS_CFG_FACTIONS select (lbCurSel (_display displayCtrl 1006));
	private _types = uRTS_CFG_ALL select _value;
	_list lbSetCurSel -1;
	lbClear _list;

uRTS_CFG_LIST = [];
	{
		if ((_x select 0) isEqualTo _faction) then {
			private _icon = _x select 1;
			private _text = _x select 2;
			private _cfg = _x select 3;
			private _price = _x select 4;
			if (count _cfg > 1) then {
				_cfgTXT = str (count _cfg) +  "x";
				private _idx = _list lbAdd str _price + "¤ - " + _text + " - " + _cfgTXT;		
			} else {
				private _idx = _list lbAdd str _price + "¤ - " + _text + " - " + (_cfg select 0);				
			};
			uRTS_CFG_LIST append [[_price, _icon, _text, _cfg]];
		}
	}forEach _types;
};

uRTS_FNC_SELECT = {
	private _display = findDisplay 1000;
	private _selection = uRTS_CFG_LIST select (lbCurSel (_display displayCtrl 1010));
	(uRTS_CFG select 2) pushBack _selection;
	(uRTS_CFG select 2) deleteAt 0;
	[] call uRTS_FNC_UPDATE;
};

uRTS_FNC_ICON = {
	private _display = findDisplay 1000;
	private _picturePath = "";
	if ((lbCurSel (_display displayCtrl 1010)) >= 0) then {
		private _selection = (uRTS_CFG_LIST select (lbCurSel (_display displayCtrl 1010))) select 3;
		_picturePath = getText (configFile >> "CfgVehicles" >> (_selection select ((count _selection) - 1)) >> "editorPreview");
		(_display displayCtrl 1017) ctrlSetText _picturePath;
	}
};

uRTS_FNC_SETEAST = {
	private _display = findDisplay 1000;
	private _selection = uRTS_CFG_LIST select (lbCurSel (_display displayCtrl 1010));
	(uRTS_CFG select 3) pushBack _selection;
	(uRTS_CFG select 3) deleteAt 0;
	[] call uRTS_FNC_UPDATE;
};

uRTS_FNC_SELECT = {
	params ["_ctrl", "_value"];
	switch (ctrlIDC _ctrl) do {
		case 1008: {
			private _selection = uRTS_CFG_LIST select (lbCurSel (findDisplay 1000 displayCtrl 1010));
			if (isNil "_selection" == false) then {
				(uRTS_CFG select 2) set [_value, _selection];
			}
		};
		
		case 1009: {
			private _selection = uRTS_CFG_LIST select (lbCurSel (findDisplay 1000 displayCtrl 1010));
			if (isNil "_selection" == false) then {
				(uRTS_CFG select 3) set [_value, _selection];
			}
		};
		
		case 1013: {(uRTS_CFG select 1) set [0, _value]}; /// Time
		case 1014: {(uRTS_CFG select 1) set [1, _value]}; /// Weather
		case 1015: {(uRTS_CFG select 1) set [2, _value]}; /// Scale
		case 1016: {(uRTS_CFG select 1) set [3, _value]}; /// Scenario
	};
	
	[] call uRTS_FNC_UPDATE;
};

uRTS_FNC_IMPORT = {
	private _display = findDisplay 1000;
	private _config = _display displayCtrl 1002;
	private _text = ctrlText _config;

	private _result = call compile _text;
	
	if (typeName _result == "ARRAY" && count _result == 4) then {
		uRTS_CFG = _result;
		closeDialog 0;
		uRTS_CFG_IMPORT = true;
		execVM "uRTS\GUI.sqf";
		hint "Configuration imported";	
	} else {
		hint "Invalid configuration!";
	};
};

uRTS_FNC_PLAY = {
	closeDialog 0;
	call compile preprocessFile "uRTS\Scenario.sqf";
};

/// [east, "o_unknown", ["O_Truck_02_covered_F"], 1] call uRTS_FNC_SPAWN;
/// [east, "unknown", ["O_Truck_02_covered_F"], 1] remoteExec ["uRTS_FNC_SPAWN", 2, false];
uRTS_FNC_SPAWN = {
	private _side = _this select 0;
	private _side2 = civilian;
	private _marker = _this select 1;
	private _units = _this select 2;
	private _price = _this select 3;
	private _base = getMarkerPos "respawn_west";
	private _morale = uRTS_MORALE_WEST;
	private _supply = uRTS_SUPPLY_WEST;
	private _prefix = "b_";	
	
	if (_side == "WEST") then {
		_side2 = west;
	};
	
	if (_side == "EAST") then {
		_side2 = east;
		_prefix = "o_";
		_base = getMarkerPos "respawn_east";
		_morale = uRTS_MORALE_EAST;
		_supply = uRTS_SUPPLY_EAST;
	};
	
	_marker = _prefix + _marker;
	
	private _pos = [_base, 0, 500, 10, 0, 0.5, 0, [], [_base]] call BIS_fnc_findsafepos;
	private _relpos = [];
	for "_i" from 0 to (count _units - 1) do {
		_relpos pushBack [_i * 3, 0];
	};
	
	if ((_units select 0) isKindOf "Air") then {
		_pos = [nil, ["water"]] call BIS_fnc_randomPos;
	};
	
	private _spawned = [_pos, _side2, _units, _relpos, [], [_morale, _morale], [_supply, _supply]] call BIS_fnc_spawnGroup; /// REPLACE WITH creatvehicle?
	private _vehs = [_spawned, true] call BIS_fnc_groupVehicles;
	
	{
		private _unit = _x;
		if (count _vehs > 0) then {_unit moveInCargo (_vehs select 0)};
	}forEach units _spawned;
	
    _spawned setVariable ["uRTS_PRICE", _price, true];
	_spawned deleteGroupWhenEmpty true;
	_grpMarker = createMarker ["uRTS_GRP_" + (netID _spawned), getPosASL leader _spawned];
	_grpMarker setMarkerType _marker;
	_grpMarker setMarkerAlpha 0.5;
	_spawned;
};

uRTS_FNC_PURCHASE = {
	private _side = _this select 0;
	private _value = _this select 1;
	private _cfg = uRTS_CFG_WEST;
	private _reserve = 0;
	if (_side == "WEST") then {_reserve = uRTS_RESERVE_WEST};
	if (_side == "EAST") then {_cfg = uRTS_CFG_EAST; _reserve = uRTS_RESERVE_EAST};
	private _select = _cfg select _value;
	private _price = _select select 0;
	private _marker = _select select 1;
	private _name = _select select 2;
	private _units = _select select 3;
	private _owner = netID player;
	if (_reserve >= _price) then {
		if (_side == "WEST") then {uRTS_RESERVE_WEST = uRTS_RESERVE_WEST - _price; [west, "BLU"] sideChat ("Reinforcements: " + _name)};
		if (_side == "EAST") then {uRTS_RESERVE_EAST = uRTS_RESERVE_EAST - _price; [east, "OPF"] sideChat ("Reinforcements: " + _name)};
		[_side, _marker, _units, _price] call uRTS_FNC_SPAWN;
	} else {
		if (_side == "WEST") then {[west, "BLU"] sideChat ("Not enough ¤ reserve!")};
		if (_side == "EAST") then {[east, "OPF"] sideChat ("Not enough ¤ reserve!")};
	};
};