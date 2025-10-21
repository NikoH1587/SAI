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
	1 spawn uRTS_PLAYER_BEEPBOOP;
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
				if (uRTS_PLAYER_MODE == "POSITION") then {[_pos, _shift] call uRTS_PLAYER_POSITION};
			};
		};
		
		if (visiblemap) then {
			private _menu = findDisplay 1100;
			private _gameinfo = _menu displayCtrl 1102;
			lbClear _gameinfo;
			private _reserve = "0";
			private _capture = "0";
			private _destroy = "0";
			private _capture2 = "0";
			private _destroy2 = "0";
			if (playerSide == west) then {
				_reserve = str uRTS_RESERVE_WEST;
				_capture = uRTS_CAPTURE_WEST;
				_capture2 = uRTS_CAPTURE_EAST;
				_destroy = uRTS_DESTROY_WEST;
				_destroy2 = uRTS_DESTROY_EAST;
			};
			
			if (playerSide == east) then {
				_reserve = str uRTS_RESERVE_EAST;
				_capture = uRTS_CAPTURE_EAST;
				_capture2 = uRTS_CAPTURE_WEST;
				_destroy = uRTS_DESTROY_EAST;
				_destroy2 = uRTS_DESTROY_WEST;
			};
			
			_gameinfo lbAdd ("RESERVES AVAILABLE: " + _reserve + "¤");
			_gameinfo lbAdd ("CAPTURE WIN: " + str (round((_capture / uRTS_CAPTURE)*100)) + "% ENEMY: " + str (round((_capture2 / uRTS_CAPTURE)*100)) + "%");
			_gameinfo lbAdd ("DESTRUCTION: " + str (round((_destroy2 / uRTS_DESTROY)*100)) + "% ENEMY: " + str (round((_destroy / uRTS_DESTROY)*100)) + "%");
		};
		
		if (!visiblemap && _open) then {
			(findDisplay 1100) closedisplay 1;
			_open = false;
			uRTS_PLAYER_COMMANDS = [];
			uRTS_PLAYER_MODE = "SELECT";
			uRTS_PLAYER_GROUP = group player;
			
		};
		0 spawn uRTS_PLAYER_TRACKING;
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
	{
		private _d = _pos distance2D (getMarkerPos _x);
		private _type = markerType _x;
		if (_d < _dist) then {_dist = _d; _mrk = _x; _side2 = _type select [0, 1]};
	}forEach _markers;
	if (_mrk != "" && _dist <= 100 && _side == _side2) then {
		private _chars = count _mrk;
		private _netID = _mrk select [9, _chars];
		uRTS_PLAYER_GROUP = groupFromNetId _netID;
		[_mrk] spawn uRTS_PLAYER_LIST;
		0 spawn uRTS_PLAYER_BEEPBOOP;
	};
};

uRTS_PLAYER_LIST = {
	private _mrk = _this select 0;
	private _ord = [];
	_mrk = (markertype _mrk) select [2, (count _mrk) - 2];
	switch (_mrk) do {
		case "recon": {_ord = ["MOVE", "SNEAK", "SWITCH", "CANCEL"]}; /// swtich to "stealth" mode?
		case "inf": {_ord = ["MOVE", "GARRISON", "SWITCH", "CANCEL"]};
		case "installation": {_ord = ["MOVE", "REPOS", "SWITCH", "CANCEL"]}; /// cannot repos if in combat!
		case "unknown": {_ord = ["MOVE", "ATTACK", "SWITCH", "CANCEL"]};
		case "support": {_ord = ["MOVE", "SUPPORT", "SWITCH", "CANCEL"]};
		case "motor_inf": {_ord = ["MOVE", "DISMOUNT", "SWITCH", "CANCEL"]};
		case "mech_inf": {_ord = ["MOVE", "DISMOUNT", "SWITCH", "CANCEL"]};
		case "uav": {_ord = ["MOVE", "CONTROL", "SWITCH", "CANCEL"]};
		case "armor": {_ord = ["MOVE", "ATTACK", "SWITCH", "CANCEL"]};
		case "art": {_ord = ["MOVE", "FIRE", "SWITCH", "CANCEL"]}; /// fire
		case "air": {_ord = ["MOVE", "STRIKE", "SWITCH", "CANCEL"]}; /// strike?
		case "plane": {_ord = ["MOVE", "STRIKE", "SWITCH", "CANCEL"]}; /// strike?
		case "naval": {_ord = ["MOVE", "DISMOUNT", "SWITCH", "CANCEL"]};
	};
	
	private _cmd = (findDisplay 1100) displayCtrl 1103;
	lbClear _cmd;
	{_cmd lbAdd _x}forEach _ord;
	private _pos = getMousePosition;
	_cmd ctrlSetPosition [_pos select 0, _pos select 1, 0.15, 0.17];
	_cmd ctrlCommit 0;
	uRTS_PLAYER_MODE = "LIST";
	uRTS_PLAYER_COMMANDS = _ord;
};

uRTS_PLAYER_ORDER = {
	private _select = _this;
	if (uRTS_PLAYER_MODE == "SWITCH") then {
		private _old = player;
		private _new = units uRTS_PLAYER_GROUP select _select;
		selectPlayer _new;
		_old enableAI "TeamSwitch";
		openMap [false, false];
	};

	if (uRTS_PLAYER_MODE == "LIST") then {
		private _order = uRTS_PLAYER_COMMANDS select _select;
		switch (_order) do {
			case "MOVE": {0 call uRTS_PLAYER_POSITION};
			case "SWITCH": {0 call uRTS_PLAYER_SWITCH};	
			case "CANCEL": {0 call uRTS_PLAYER_CANCEL};
		}
	}
};

uRTS_PLAYER_SWITCH = {
	private _cmd = (findDisplay 1100) displayCtrl 1103;
	private _units = units uRTS_PLAYER_GROUP;
	lbClear _cmd;
	private _pos = ctrlPosition _cmd;
	_cmd ctrlSetPosition [_pos select 0, _pos select 1, 0.20, 0.20];
	_cmd ctrlCommit 0;
	
	{
		private _text = getText (configfile >> "CfgVehicles" >> typeOf _x >> "displayName");
		_cmd lbAdd _text;
	}forEach _units;
	
	uRTS_PLAYER_MODE = "SWITCH";
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

uRTS_PLAYER_POSITION = {
};

uRTS_PLAYER_BEEPBOOP = {
	private _mode = _this;
	private _sounds = ["a3\dubbing_radio_f\sfx\radionoise1.ogg", "a3\dubbing_radio_f\sfx\radionoise2.ogg", "a3\dubbing_radio_f\sfx\radionoise3.ogg"];
	private _sounds2 = [
		"a3\sounds_f\sfx\radio\ambient_radio1.wss",
		"a3\sounds_f\sfx\radio\ambient_radio10.wss",
		"a3\sounds_f\sfx\radio\ambient_radio11.wss",
		"a3\sounds_f\sfx\radio\ambient_radio12.wss",
		"a3\sounds_f\sfx\radio\ambient_radio13.wss",
		"a3\sounds_f\sfx\radio\ambient_radio14.wss",
		"a3\sounds_f\sfx\radio\ambient_radio15.wss",
		"a3\sounds_f\sfx\radio\ambient_radio16.wss",
		"a3\sounds_f\sfx\radio\ambient_radio17.wss",
		"a3\sounds_f\sfx\radio\ambient_radio18.wss",
		"a3\sounds_f\sfx\radio\ambient_radio19.wss",
		"a3\sounds_f\sfx\radio\ambient_radio2.wss",
		"a3\sounds_f\sfx\radio\ambient_radio20.wss",
		"a3\sounds_f\sfx\radio\ambient_radio21.wss",
		"a3\sounds_f\sfx\radio\ambient_radio22.wss",
		"a3\sounds_f\sfx\radio\ambient_radio23.wss",
		"a3\sounds_f\sfx\radio\ambient_radio24.wss",
		"a3\sounds_f\sfx\radio\ambient_radio25.wss",
		"a3\sounds_f\sfx\radio\ambient_radio26.wss",
		"a3\sounds_f\sfx\radio\ambient_radio27.wss",
		"a3\sounds_f\sfx\radio\ambient_radio28.wss",
		"a3\sounds_f\sfx\radio\ambient_radio29.wss",
		"a3\sounds_f\sfx\radio\ambient_radio3.wss",
		"a3\sounds_f\sfx\radio\ambient_radio30.wss",
		"a3\sounds_f\sfx\radio\ambient_radio4.wss",
		"a3\sounds_f\sfx\radio\ambient_radio5.wss",
		"a3\sounds_f\sfx\radio\ambient_radio6.wss",
		"a3\sounds_f\sfx\radio\ambient_radio7.wss",
		"a3\sounds_f\sfx\radio\ambient_radio8.wss",
		"a3\sounds_f\sfx\radio\ambient_radio9.wss"];
	_sound = _sounds select floor random 3;
	_sleep = 1;
	_volume = 1;
	if (_mode == 1) then {_sound = _sounds2 select floor random 30; _sleep = 2; _volume = 0.25};
	_snd = playSoundUI [_sound, _volume];
	sleep _sleep;
	stopSound _snd;
};
/// RESERVE: 0¤ (+10)
/// CAPTURE: 0 / 100
/// DESTROY: 0 / 100
