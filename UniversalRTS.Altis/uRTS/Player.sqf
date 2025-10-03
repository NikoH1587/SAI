uRTS_PLAYER_START = {
	if (simulationEnabled player == false) then {
		sleep 0.1; /// add map animation instead!
		private _side = side player;
		private _cfg = uRTS_CFG select 2;
		if (side player == east) then {_cfg = uRTS_CFG select 3};
		private _select = _cfg select 0;
		private _price = _select select 0;
		private _marker = _select select 1;
		private _name = _select select 2;
		private _units = _select select 3;
		private _group = [_side, _marker, _units, _price] call uRTS_PLAYER_SPAWN;
		private _leader = leader _group;
///		{addSwitchableUnit _x} forEach units _group;
		selectPlayer _leader;
	}
};

/// [east, "o_unknown", ["O_Truck_02_covered_F"], 1] call uRTS_PLAYER_SPAWN;

uRTS_PLAYER_SPAWN = {
	private _side = _this select 0;
	private _marker = _this select 1;
	private _units = _this select 2;
	private _price = _this select 3;
	private _base = getMarkerPos "respawn_west";
	_marker = "b_" + _marker;	
	
	if (_side == east) then {
		_marker = "o_" + _marker;
		_base = getMarkerPos getMarkerPos "respawn_east";
	};
	
	private _pos = [_base, 0, 500, 10, 0, 0.5, 0, [], [_base]] call BIS_fnc_findsafepos;
	private _relpos = [];
	for "_i" from 0 to (count _units - 1) do {
		_relpos pushBack [_i * 3, 0];
	};
	
	if ((_units select 0) isKindOf "Air") then {
		_pos = [nil, ["water"]] call BIS_fnc_randomPos;
	};
	
	private _spawned = [_pos, _side, _units, _relpos] call BIS_fnc_spawnGroup;
	private _vehs = [_spawned, true] call BIS_fnc_groupVehicles;
	
	{
		private _unit = _x;
		if (count _vehs > 0) then {_unit moveInCargo (_vehs select 0)};
	}forEach units _spawned;
	
    _spawned setVariable ["uRTS_PRICE", _price, true];
	
	_grpMarker = createMarker ["uRTS_GRP_" + (netID _spawned), getPosASL leader _spawned];
	_grpMarker setMarkerType _marker;
	_grpMarker setMarkerAlpha 0;
	_spawned;
};

uRTS_PLAYER_PURCHASE = {
	params ["_ctrl", "_value"];
	private _side = side player;
	private _cfg = uRTS_CFG select 2;
	private _reserve = 0;
	if (side player == west) then {_reserve = uRTS_RESERVE_WEST};
	if (side player == east) then {_cfg = uRTS_CFG select 3; _reserve = uRTS_RESERVE_EAST};
	private _select = _cfg select _value;
	private _price = _select select 0;
	private _marker = _select select 1;
	private _name = _select select 2;
	private _units = _select select 3;
	private _owner = netID player;
	if (_reserve >= _price) then {
		_reserve = _reserve - _price;
		[_side, _marker, _units, _price] call uRTS_PLAYER_SPAWN;
		player sideChat ("Unit purchased: " + _name);
	} else {
		player sideChat ("Not enough ¤ reserve!");
	};
};

uRTS_PLAYER_TRACKING = {
	{
		sleep 0.1;
		private _side = side player;
		private _chars = (count _x) - 9;
		private _netID = _x select [9, _chars];
		private _grp = groupFromNetId _netID;
		private _ldr = leader _grp;
		private _veh = vehicle _ldr;
		if (_side knowsAbout _veh > 0) then {
			if (_side == side _grp && local _veh == false && markerAlpha _x != 0.5) then {_x setMarkerAlphaLocal 0.5};
			if (_side == side _grp && local _veh && markerAlpha _x != 1) then {_x setMarkerAlphaLocal 1};
			if (_side != side _grp && markerAlpha _x != 0.75) then {_x setMarkerAlphaLocal 0.75};	
		} else {
			if (markerAlpha _x != 0) then {_x setMarkerAlphaLocal 0};
		};
	}forEach (allMapmarkers select {_x find "uRTS_GRP_" == 0});
};

0 spawn {while {true} do {
	_tracking = 0 spawn uRTS_PLAYER_TRACKING;
	waituntil {scriptdone _tracking};
}};

uRTS_PLAYER_COMMANDS = [];
uRTS_PLAYER_MODE = "SELECT";
uRTS_PLAYER_GROUP = group player;

[] spawn {
	private _open = false;
	private _side = side player;
	while {true} do {
		if (visibleMap && !_open) then {
			(findDisplay 46) createDisplay "uRTS_MENU";
			private _menu = findDisplay 1100;
			_open = true;
			private _purchase = _menu displayCtrl 1101;
			private _gameinfo = _menu displayCtrl 1102;
			private _commands = _menu displayCtrl 1103;

			private _color = [0, 0.3, 0.6, 0.5];
			private _cfg = uRTS_WEST;
			
			if (_side == east) then {
				_color = [0.5, 0, 0, 0.5];
				_cfg = uRTS_EAST;
			};
			
			{_purchase lbAdd (str (_x select 0) + "¤ - " + (_x select 2))}forEach _cfg;
			_purchase ctrlSetBackgroundColor _color;
			_gameinfo ctrlSetBackgroundColor _color;
			_commands ctrlSetBackgroundColor _color;
			_commands lbAdd "Select above to purchse units.";
			_commands lbAdd "Click on map icon to command.";
			
			onMapSingleClick {
				if (uRTS_PLAYER_MODE == "SELECT") then {[_pos] call uRTS_PLAYER_SELECT};
				if (uRTS_PLAYER_MODE == "CANCEL") then {[_pos] call uRTS_PLAYER_RESUME};
				if (uRTS_PLAYER_MODE == "POSITION") then {[_pos, _shift] call uRTS_PLAYER_POSITION};
			};
		};		
		
		if (!visiblemap && _open) then {
			(findDisplay 1100) closedisplay 1;
			_open = false;
			uRTS_PLAYER_COMMANDS = [];
			uRTS_PLAYER_MODE = "SELECT";
			uRTS_PLAYER_GROUP = group player;
			
		};
		sleep 1;
	}
};

uRTS_PLAYER_SELECT = {
	private _pos = _this select 0;
	private _side = _this select 1;
	private _markers = allMapmarkers select {_x find "uRTS_GRP_" == 0 && markerAlpha _x == 1};
	private _mrk = "";
	private _dist = 1000000;
	
	{
		private _d = _pos distance2D (getMarkerPos _x);
		if (_d < _dist && markerAlpha _x == 1) then {_dist = _d; _mrk = _x};
	}forEach _markers;

	if (_mrk != "" && _dist <= 100) then {
		private _chars = count _mrk;
		private _netID = _mrk select [9, _chars];
		uRTS_PLAYER_GROUP = groupFromNetId _netID;
		[_mrk] call uRTS_PLAYER_LIST;
	};
};

uRTS_PLAYER_LIST = {
	private _mrk = _this select 0;
	private _ord = [];
	_mrk = (markertype _mrk) select [2, (count _mrk) - 2];
	switch (_mrk) do {
		case "recon": {_ord = ["MOVE", "STEALTH", "SWITCH", "CANCEL"]}; /// swtich to "stealth" mode?
		case "inf": {_ord = ["MOVE", "GARRISON", "SWITCH", "CANCEL"]};
		case "installation": {_ord = ["MOVE", "REPOS", "SWITCH", "CANCEL"]}; /// cannot repos if in combat!
		case "unknown": {_ord = ["MOVE", "ATTACK", "SWITCH", "CANCEL"]};
		case "support": {_ord = ["MOVE", "AUTO", "SWITCH", "CANCEL"]};
		case "motor_inf": {_ord = ["MOVE", "DISMOUNT", "SWITCH", "CANCEL"]};
		case "mech_inf": {_ord = ["MOVE", "DISMOUNT", "SWITCH", "CANCEL"]};
		case "uav": {_ord = ["MOVE", "CONTROL", "SWITCH", "CANCEL"]};
		case "armor": {_ord = ["MOVE", "ATTACK", "SWITCH", "CANCEL"]};
		case "art": {_ord = ["MOVE", "FIRE", "SWITCH", "CANCEL"]}; /// fire
		case "air": {_ord = ["MOVE", "STRIKE", "SWITCH", "CANCEL"]}; /// strike?
		case "plane": {_ord = ["MOVE", "STRIKE", "SWITCH", "CANCEL"]}; /// strike?
	};
	
	private _cmd = (findDisplay 1100) displayCtrl 1103;
	lbClear _cmd;
	{_cmd lbAdd _x}forEach _ord;
	private _pos = getMousePosition;
	_cmd ctrlSetPosition [_pos select 0, _pos select 1, 0.15, 0.17];
	_cmd ctrlCommit 0;
	uRTS_PLAYER_MODE = "LIST";
	uRTS_PLAYER_COMMANDs = _ord;
};

uRTS_PLAYER_ORDER = {
	private _order = uRTS_PLAYER_COMMANDs select _this;
	switch (_order) do {
		case "SWITCH": {0 call uRTS_PLAYER_SWITCH};	
		case "CANCEL": {0 call uRTS_PLAYER_CANCEL};
	};
};

uRTS_PLAYER_SWITCH = {
	hint str uRTS_PLAYER_GROUP;
	private _grp = uRTS_PLAYER_GROUP;
	private _ldr = leader _grp;
	if (alive _ldr) then {
		_old = player;
		selectPlayer _ldr;
		_old enableAI "TeamSwitch";
	}
};

uRTS_PLAYER_CANCEL = {
	private _cmd = (findDisplay 1100) displayCtrl 1103;
	lbClear _cmd;
	_cmd ctrlSetPosition [0, 0, 0, 0];
	_cmd ctrlCommit 0;
	uRTS_PLAYER_COMMANDS = [];
	uRTS_PLAYER_GROUP = group player;
	uRTS_PLAYER_MODE = "CANCEL";
};

uRTS_PLAYER_RESUME = {
	uRTS_PLAYER_MODE = "SELECT";
};

uRTS_PLAYER_POSITION = {};

/// RESERVE: 0¤ (+10)
/// CAPTURE: 0 / 100
/// DESTROY: 0 / 100
