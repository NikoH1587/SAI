uRTS_FNC_UPDATE = {
	private _display = findDisplay 1000;
	lbClear 1020;
	_display displayCtrl 1020 ctrlSetText "PLAY SCENARIO (READY: " + str uRTS_READY + "/" + str uRTS_PLAYERS + ")";
	lbClear 1003;
	for "_i" from 0 to (count uRTS_CFG_WEST) do {
		private _cfg = uRTS_CFG_WEST select _i;
		private _price = str (_cfg select 0) + "¤ - ";
		private _name = (_cfg select 2) + " - ";
		private _count = str (count (_cfg select 3)) + "x";
		_display displayCtrl 1003 lbAdd (_price + _name + _count);
	};
	
	lbClear 1004;
	for "_i" from 0 to (count uRTS_CFG_EAST) do {
		private _cfg = uRTS_CFG_EAST select _i;
		private _price = str (_cfg select 0) + "¤ - ";
		private _name = (_cfg select 2) + " - ";
		private _count = str (count (_cfg select 3)) + "x";
		_display displayCtrl 1004 lbAdd (_price + _name + _count);
	};
	
	if (lbCurSel 1008 != (uRTS_CFG_COND select 0)) then {_display displayCtrl 1008 lbSetCurSel (uRTS_CFG_COND select 0)};
	if (lbCurSel 1009 != (uRTS_CFG_COND select 1)) then {_display displayCtrl 1009 lbSetCurSel (uRTS_CFG_COND select 1)};
	if (lbCurSel 1010 != (uRTS_CFG_COND select 2)) then {_display displayCtrl 1010 lbSetCurSel (uRTS_CFG_COND select 2)};
	if (((uRTS_CFG_COND select 3) select 0) != 0) then {_display displayCtrl 1011 ctrlSetText ("Position: " + text nearestLocation [(uRTS_CFG_COND select 3), ""])};
	if (lbCurSel 1012 != (uRTS_CFG_COND select 4)) then {_display displayCtrl 1012 lbSetCurSel (uRTS_CFG_COND select 4)};
	if (lbCurSel 1013 != (uRTS_CFG_COND select 5)) then {_display displayCtrl 1013 lbSetCurSel (uRTS_CFG_COND select 5)};
	if (lbCurSel 1014 != (uRTS_CFG_COND select 6)) then {_display displayCtrl 1014 lbSetCurSel (uRTS_CFG_COND select 6)};
};

uRTS_FNC_LIST = {
	params ["_ctrl", "_value"];
	private _display = ctrlParent _ctrl;
	private _list = _display displayCtrl 1005;
	private _faction = uRTS_CFG_FACTIONS select (lbCurSel (_display displayCtrl 1001));
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

uRTS_FNC_ICON = {
	private _display = findDisplay 1000;
	private _picturePath = "";
	if ((lbCurSel (_display displayCtrl 1005)) >= 0) then {
		private _selection = (uRTS_CFG_LIST select (lbCurSel (_display displayCtrl 1005))) select 3;
		_picturePath = getText (configFile >> "CfgVehicles" >> (_selection select ((count _selection) - 1)) >> "editorPreview");
		_picturePath2 = getText (configFile >> "CfgVehicles" >> (_selection select (((count _selection) - 2) min floor random count _selection)) >> "editorPreview");
		(_display displayCtrl 1006) ctrlSetText _picturePath;
		if (count _selection > 1) then {(_display displayCtrl 1007) ctrlSetText _picturePath2} else {(_display displayCtrl 1007) ctrlSetText ""};
	}
};

uRTS_FNC_SELECT = {
	params ["_ctrl", "_value"];
	switch (ctrlIDC _ctrl) do {
		case 1003: {
			if (playerSide == west or isServer) then {
				private _selection = uRTS_CFG_LIST select (lbCurSel (findDisplay 1000 displayCtrl 1005));
				if (isNil "_selection" == false) then {
					uRTS_CFG_WEST set [_value, _selection];
				}
			}
		};
		
		case 1004: {
			if (playerSide == east or isServer) then {
				private _selection = uRTS_CFG_LIST select (lbCurSel (findDisplay 1000 displayCtrl 1005));
				if (isNil "_selection" == false) then {
					uRTS_CFG_EAST set [_value, _selection];
				}
			}
		};
		
		case 1008: {uRTS_CFG_COND set [0, _value]}; /// Time
		case 1009: {uRTS_CFG_COND set [1, _value]}; /// Weather
		case 1010: {uRTS_CFG_COND set [2, _value]}; /// Scale
		case 1012: {uRTS_CFG_COND set [4, _value]}; /// AI West
		case 1013: {uRTS_CFG_COND set [5, _value]}; /// Ai East
		case 1014: {uRTS_CFG_COND set [6, _value]}; /// Difficulty
	};
	publicVariable "uRTS_CFG_COND";
	publicVariable "uRTS_CFG_WEST";
	publicVariable "uRTS_CFG_EAST";
	remoteExecCall ["uRTS_FNC_UPDATE", 0, false];
};


uRTS_FNC_POSITION = {
	openMap true;
	closeDialog 0;
	hint "Select position.";
	onMapSingleClick {
		(uRTS_CFG select 1) set [3, _pos];
		publicVariable "uRTS_CFG_COND";
		openMap false;
		execVM "uRTS\GUI.sqf";
		remoteExecCall ["uRTS_FNC_UPDATE", 0, false];
	};
};

uRTS_FNC_READY = {
	uRTS_READY = uRTS_READY + 1;
	publicVariable "uRTS_READY";
	remoteExecCall ["uRTS_FNC_UPDATE", 0, false];	
	if (uRTS_READY >= uRTS_PLAYERS) then {
		remoteExecCall ["uRTS_FNC_PLAY", 2, false];
		remoteExec ["uRTS_FNC_JOIN", 0, true];
	};
};

uRTS_FNC_SPAWN = {
	private _side = _this select 0;
	private _side2 = civilian;
	private _marker = _this select 1;
	private _units = _this select 2;
	private _price = _this select 3;
	private _base = getMarkerPos "respawn_west";
	private _prefix = "b_";	
	
	if (_side == "WEST") then {
		_side2 = west;
	};
	
	if (_side == "EAST") then {
		_side2 = east;
		_prefix = "o_";
		_base = getMarkerPos "respawn_east";
	};
	
	
	private _pos = [_base, 0, 500, 10, 0, 0.5, 0, [], [_base]] call BIS_fnc_findsafepos;
	private _relpos = [];
	for "_i" from 0 to (count _units - 1) do {
		_relpos pushBack [_i * 3, 0];
	};
	
	/// make support, artillery and air units spawn at map HQ position!
	
	if (_marker in ["plane", "UAV", "air"]) then {
		_pos = [[[_base, worldSize/3]], [[_base, worldSize/4]]] call BIS_fnc_randomPos;
	};
	
	if (_marker in ["naval"]) then {
		_pos = [[[_base, worldSize/4]], ["ground"]] call BIS_fnc_randomPos;
	};
	
	_marker = _prefix + _marker;
	
	private _spawned = [_pos, _side2, _units, _relpos, [], [1, 1], [1, 1]] call BIS_fnc_spawnGroup; /// REPLACE WITH creatvehicle?
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
		if (_side == "WEST") then {uRTS_RESERVE_WEST = uRTS_RESERVE_WEST - _price; [west, "base"] sideChat ("Reinforcements: " + _name); publicVariable "uRTS_RESERVE_WEST"};
		if (_side == "EAST") then {uRTS_RESERVE_EAST = uRTS_RESERVE_EAST - _price; [east, "base"] sideChat ("Reinforcements: " + _name); publicVariable "uRTS_RESERVE_EAST"};
		[_side, _marker, _units, _price] call uRTS_FNC_SPAWN;
		
	} else {
		if (_side == "WEST") then {[west, "BASE"] sideChat ("Not enough ¤ reserve!")};
		if (_side == "EAST") then {[east, "BASE"] sideChat ("Not enough ¤ reserve!")};
	};
};

