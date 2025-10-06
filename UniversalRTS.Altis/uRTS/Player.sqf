uRTS_PLAYER_START = {
///	if (simulationEnabled player == false) then {
///		sleep 0.1;
///		private _side = side player;
///		private _cfg = uRTS_CFG select 2;
///		if (side player == east) then {_cfg = uRTS_CFG select 3};
///		private _select = _cfg select 0;
///		private _price = _select select 0;
///		private _marker = _select select 1;
///		private _name = _select select 2;
///		private _units = _select select 3;
///		[_side, _marker, _units, _price] remoteExec ["uRTS_FNC_SPAWN", 2, false];
///		private _group = groupFromNetId _netID;
///		private _leader = leader _group;
///		selectPlayer _leader;
///	}
/// this stuff is maybe uneeded because you can just switch?

};

uRTS_PLAYER_TRACKING = {
	{
		sleep 0.1;
		private _chars = (count _x) - 9;
		private _netID = _x select [9, _chars];
		private _grp = groupFromNetId _netID;
		private _ldr = leader _grp;
		private _veh = vehicle _ldr;
		private _mrk = "LOC_" + _x;
		createMarkerLocal [_mrk, getMarkerPos _x];
		_mrk setMarkerTypeLocal markertype _x;
		_mrk setMarkerPosLocal markerPos _x;
		_mrk setMarkerTextLocal markerText _x;
		_mrk setMarkerAlphaLocal 0;
		
		if (playerSide knowsAbout _veh > 0) then {_mrk setMarkerAlphaLocal 1};
	}forEach (allMapmarkers select {_x find "uRTS_GRP_" == 0});
	
	{
		sleep 0.1;
		private _mrk = _x;
		private _chars = (count _x) - 4;
		private _exists = (_mrk select [4, _chars]) in allMapmarkers;
		if (_exists == false) then {deleteMarkerLocal _mrk};
	}forEach (allMapmarkers select {_x find "LOC_uRTS_GRP_" == 0});
};

uRTS_PLAYER_PURCHASE = {
	private _selection = _this;
	private _side = "NONE";
	if (playerSide == west) then {_side = "WEST"};
	if (playerSide == east) then {_side = "EAST"};
	[_side, _selection] remoteExec ["uRTS_FNC_PURCHASE", 2, false];
};

uRTS_PLAYER_COMMANDS = [];
uRTS_PLAYER_MODE = "SELECT";
uRTS_PLAYER_GROUP = group player;

[] spawn {
	private _open = false;
	while {true} do {
		sleep 0.1;
		if (visibleMap && !_open) then {
			(findDisplay 46) createDisplay "uRTS_MENU";
			private _menu = findDisplay 1100;
			_open = true;
			private _purchase = _menu displayCtrl 1101;
			private _gameinfo = _menu displayCtrl 1102;
			private _commands = _menu displayCtrl 1103;

			private _color = [0, 0.3, 0.6, 0.5];
			private _cfg = uRTS_CFG_WEST;
			
			if (playerSide == east) then {
				_color = [0.5, 0, 0, 0.5];
				_cfg = uRTS_CFG_EAST;
			};
			
			{_purchase lbAdd (str (_x select 0) + "¤ - " + (_x select 2))}forEach _cfg;
			_purchase ctrlSetBackgroundColor _color;
			_gameinfo ctrlSetBackgroundColor _color;
			_commands ctrlSetBackgroundColor _color;
			_commands lbAdd "Select above to purchse units.";
			_commands lbAdd "Click on map icon to command.";
			
			onMapSingleClick {
				_side = str (playerSide);
				if (uRTS_PLAYER_MODE == "SELECT") then {[_pos, _side] call uRTS_PLAYER_SELECT};
				if (uRTS_PLAYER_MODE == "CANCEL") then {[_pos] call uRTS_PLAYER_RESUME};
				if (uRTS_PLAYER_MODE == "POSITION") then {[_pos, _shift] call uRTS_PLAYER_POSITION};
			};
		};		
		
///		publicVariable "uRTS_RESERVE_WEST";
///		publicVariable "uRTS_CAPTURE_WEST";
///		publicVariable "uRTS_DESTROY_WEST";
		
		if (visiblemap) then {
			private _menu = findDisplay 1100;
			private _gameinfo = _menu displayCtrl 1102;
			lbClear _gameinfo;
			private _reserve = "0";
			private _capture = "0";
			private _destroy = "0";
			if (playerSide == west) then {
				_reserve = str uRTS_RESERVE_WEST;
				_capture = uRTS_CAPTURE_WEST;
				_destroy = uRTS_DESTROY_WEST;
			};
			
			if (playerSide == east) then {
				_reserve = str uRTS_RESERVE_EAST;
				_capture = uRTS_CAPTURE_EAST;
				_destroy = uRTS_DESTROY_EAST;
			};
			
			_gameinfo lbAdd ("RESERVE: " + _reserve + "¤");
///			_gameinfo lbAdd ("CAPTURE: " + (str ((_capture/uRTS_CAPTURE) * 100)) + "%";
///				_gameinfo lbAdd ("DESTROY: " + (str ((_destroy/uRTS_DESTROY) * 100)) + "%";
		};
		
		if (!visiblemap && _open) then {
			(findDisplay 1100) closedisplay 1;
			_open = false;
			uRTS_PLAYER_COMMANDS = [];
			uRTS_PLAYER_MODE = "SELECT";
			uRTS_PLAYER_GROUP = group player;
			
		};
		call uRTS_PLAYER_TRACKING;
	}
};

uRTS_PLAYER_SELECT = {
	private _pos = _this select 0;
	private _side = _this select 1;
	private _side2 = "n";
	if (_side == "WEST") then {_side = "b"};
	if (_side == "EAST") then {_side = "o"};
	private _markers = allMapmarkers select {_x find "uRTS_GRP_" == 0};
	private _mrk = "";
	private _dist = 1000000;
	hint str _markers;
	{
		private _d = _pos distance2D (getMarkerPos _x);
		private _type = markerType _x;
		if (_d < _dist) then {_dist = _d; _mrk = _x; _side2 = _type select [0, 1]};
	}forEach _markers;
	if (_mrk != "" && _dist <= 100 && _side == _side2) then {
		hint str _mrk;
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
