if (isDedicated) exitWith {};

private _mrk = createMarkerLocal ["uRTS_MARKER", [0, 0, 0]];
_mrk setMarkerShape "POLYLINE";

uRTS_PLAYER_MODE = "SELECT";

uRTS_PLAYER_TRACKING = {
	params ["_bluMarkers","_enyMarkers"];
	
	{if (markeralpha _x != 0) then {_x setMarkerAlpha 0}}forEach (allMapMarkers select {(_x find "uRTS_WEST_" == 0) or (_x find "uRTS_EAST_" == 0)});
	{if (markeralpha _x != 1) then {_x setMarkerAlpha 1}}forEach _bluMarkers;
	{if (markeralpha _x != 1) then {_x setMarkerAlpha 1}}forEach _enyMarkers;
};

uRTS_PLAYER_PREVIEW = {
	private _pos = _this select 0;
	private _side = side player;
	private _markers = [];
	if (_side == west) then {
		_markers = allMapMarkers select {(_x find "uRTS_WEST_" == 0)};
	};
	
	if (_side == east) then {
		_markers = allMapMarkers select {(_x find "uRTS_EAST_" == 0)};
	};
	
	private _nearest = "";
	private _dist = 1000000;
	
	{
		private _d = _pos distance2D (getMarkerPos _x);
		if (_d < _dist) then {_dist = _d; _nearest = _x};
	}forEach _markers;
	
	if (_nearest != "" && _dist <= 100) then {
		private _nid = _nearest select [10, count _nearest - 1];
		private _grp = _nid call BIS_fnc_groupFromNetId;
		
		if (!isNull _grp) then {
			private _grpPos = getMarkerPos _nearest;
			private _wps = waypoints _grp;
			
			if (count _wps == 1) then {
				private _polyline = [_grpPos select 0, _grpPos select 1];
				
				for "_i" from 0 to (count waypoints _grp) - 1 do {
					private _wpPos = getWPPos [_grp, _i];
					_polyline pushback (_wpPos select 0);
					_polyline pushback (_wpPos select 1);
				};
				
				"uRTS_MARKER" setMarkerPolylineLocal _polyline;
			};
			
			if (count _wps > 1) then {
				private _polyline = [];
				
				for "_i" from 0 to (count waypoints _grp) - 1 do {
					private _wpPos = getWPPos [_grp, _i];
					_polyline pushback (_wpPos select 0);
					_polyline pushback (_wpPos select 1);
				};
				
				"uRTS_MARKER" setMarkerPolylineLocal _polyline;
			}
		}
	}
};

uRTS_PLAYER_SELECT = {
	private _menu = findDisplay 1100;
	private _list = _menu displayCtrl 1102;
	private _side = side player;
	private _index = _this select 1;
	
	[_side, _index] remoteExecCall ["uRTS_FNC_PURCHASE", 2];
};

uRTS_PLAYER_CLICK = {
	private _pos = _this select 0;
	private _side = _this select 1;
	private _markers = [];
	if (_side == west) then {_markers = allMapMarkers select {(_x find "uRTS_WEST_" == 0)}};
	if (_side == east) then {_markers = allMapMarkers select {(_x find "uRTS_EAST_" == 0)}};
	
	private _nearest = "";
	private _dist = 1000000;
	
	{
		private _d = _pos distance2D (getMarkerPos _x);
		if (_d < _dist) then {_dist = _d; _nearest = _x}
	} forEach _markers;
	
	if (_nearest != "" && _dist <= 100) then {
		private _menu = findDisplay 1100;
		private _info = _menu displayCtrl 1101;
		private _icon = _menu displayCtrl 1103;
		private _list = _menu displayCtrl 1105;
		
		private _mpos = getMousePosition;
		private _posx = _mpos select 0;
		private _posy = _mpos select 1;
		
		_list ctrlSetPosition [_posx, _posy, 0.15, 0.3];
		_list ctrlShow true;
		_list ctrlCommit 0;
		
		lbClear _list;
		
		private _mrkType = getMarkerType _nearest;
		private _cmdType = _mrkType select [1, count _mrkType - 1];
		
		private _nid = _nearest select [10, count _nearest - 1];
		private _grp = _nid call BIS_fnc_groupFromNetId;
		(findDisplay 1100) setVariable ["uRTS_SelectedNetID", _nid];
		
		lbClear _info;
		_info lbAdd str _grp + " " + str (count units _grp) + "x";
	
		private _vehs = [leader _grp, false] call BIS_fnc_groupVehicles;
		if (count _vehs > 0) then {
			_veh = _vehs select 0;
			_pic = getText (configFile >> "CfgVehicles" >> typeOf _veh >> "Picture");
			if (fileExists _pic) then {_icon ctrlSetText _pic} else {_icon ctrlSetText ""}
		} else {_icon ctrlSetText ""};
		
		_info lbAdd "";
		{_info lbAdd ([configOf _x] call BIS_fnc_displayName)}forEach _vehs;
		{_info lbAdd ([configOf _x] call BIS_fnc_displayName)}forEach units _grp;
		
		switch (_cmdType) do {
			case "_hq": {_list lbAdd "AI CMD ON"; _list lbAdd "AI CMD OFF"};
			case "_inf": {_list lbAdd "MOVE"; _list lbAdd "ATTACK", _list lbAdd "GARRISON"};
			case "_motor_inf": {_list lbAdd "MOVE"; _list lbAdd "ATTACK"; _list lbAdd "UNLOAD"};
			case "_recon": {_list lbAdd "MOVE"; _list lbAdd "ATTACK"};
			case "_armor": {_list lbAdd "MOVE"; _list lbAdd "ATTACK"};
			case "_mech_inf": {_list lbAdd "MOVE"; _list lbAdd "ATTACK"; _list lbAdd "UNLOAD"};
			case "_air": {_list lbAdd "MOVE"; _list lbAdd "ATTACK"};
		};
		
		_list lbAdd ""; _list lbAdd "STOP"; _list lbAdd "JOIN"; _list lbAdd "DISBAND";
		
		uRTS_PLAYER_MODE = "COMMAND";
	}
};

uRTS_PLAYER_COMMAND = {
	private _menu = findDisplay 1100;
	private _list = _menu displayCtrl 1105;
	private _info = _menu displayCtrl 1101;
	private _nid = (findDisplay 1100) getVariable ["uRTS_SelectedNetID", ""];

	private _index = _this select 1;
	private _cmd = _list lbText _index;
	
	(findDisplay 1100) setVariable ["uRTS_SelectedCommand", _cmd];
	
	lbClear _list;
	_list ctrlShow false;
	lbClear _info;
	
	if (_CMD in ["MOVE", "ATTACK", "UNLOAD", "GARRISON"]) then {
		_info lbAdd "SELECT " + str _CMD + " POSITION";
		private _text = "PRESS SHIFT FOR MULTI";
		if (_CMD == "UNLOAD") then {_text = "PRESS SHIFT TO LOAD"};
		if (_CMD == "GARRISON") then {_text = "PRESS SHIFT TO ENTRENCH"};
		_info lbAdd _text;
		(findDisplay 1100) setVariable ["uRTS_NEXTCLICK", true];
		uRTS_PLAYER_MODE = "POSITION";
	} else {
		switch (_cmd) do {
			case "STOP": {[_nid] remoteExecCall ["uRTS_CMD_STOP", 2]};
			case "JOIN": {[_nid, player] remoteExecCall ["uRTS_CMD_JOIN", 2]};
			case "DISBAND": {[_nid] remoteExecCall ["uRTS_CMD_DISBAND", 2]};

			case "AI CMD ON": {[side player] remoteExecCall ["uRTS_CMD_AI_CMD_0", 2]};
			case "AI CMD OFF": {[side player] remoteExecCall ["uRTS_CMD_AI_CMD_1", 2]};
		};
		uRTS_PLAYER_MODE = "SELECT";
	};
};

uRTS_PLAYER_POSITION = {
	private _pos = _this select 0;
	private _shift = _this select 1;
	
	private _display = findDisplay 1100;
	(findDisplay 1100) setVariable ["uRTS_SelectedPos", _pos];
	
	private _info = (findDisplay 1100) displayCtrl 1101;
	lbClear _info;
	
	private _nid = _display getVariable ["uRTS_SelectedNetID", ""];
	private _cmd = _display getVariable ["uRTS_SelectedCommand", ""];
	
	switch (_cmd) do {
		case "MOVE": {[_nid, _pos, _shift] remoteExecCall ["uRTS_CMD_MOVE", 2]};
		case "ATTACK": {[_nid, _pos, _shift] remoteExecCall ["uRTS_CMD_ATTACK", 2]};
		case "UNLOAD": {[_nid, _pos, _shift] remoteExecCall ["uRTS_CMD_UNLOAD", 2]};
		case "GARRISON": {[_nid, _pos, _shift] remoteExecCall ["uRTS_CMD_GARRISON", 2]};
		
		/// fire mission
		/// airstrike?
	};
	
	uRTS_PLAYER_MODE = "SELECT";
};

[] spawn {
	private _open = false;

	while {true} do {
		sleep 0.2;
		
		if (visibleMap && !_open) then {
			(findDisplay 46) createDisplay "uRTS_MENU";
			private _menu = findDisplay 1100;
			_open = true;
			
			private _back = _menu displayCtrl 1100;
			private _info = _menu displayCtrl 1101;
			private _list = _menu displayCtrl 1102;
			private _icon = _menu displayCtrl 1103;
			
			lbClear _info;
			lbClear _list;
			if (side player == west) then {
				_back ctrlSetBackgroundColor [0.00, 0.30, 0.60, 0.5];
				_info lbAdd (profilename + " - WEST");
				{_list lbAdd (str (_x select 0) + "¤ - " + (_x select 1))}forEach uRTS_WEST;
			};
				
			if (side player == east) then {
				_back ctrlSetBackgroundColor [0.50, 0.00, 0.00, 0.5];
				_info lbAdd (profilename + " - EAST");
				{_list lbAdd (str (_x select 0) + "¤ - " + (_x select 1))}forEach uRTS_EAST;				
			};
			
			_back ctrlCommit 0;
			_info lbAdd "Select from list to purchase.";				
			_info lbAdd "Click group icon to command.";
			_info lbAdd "Click HQ icon for options.";
			
			uRTS_PLAYER_MODE = "SELECT";

			onMapSingleClick {
				params ["_pos", "_units", "_shift", "_alt"];
				if (uRTS_PLAYER_MODE == "SELECT") then {[_pos, side player] call uRTS_PLAYER_CLICK};
				if (uRTS_PLAYER_MODE == "POSITION") then {
					private _nextClick = (findDisplay 1100) getVariable ["uRTS_NEXTCLICK", false];
					if (_nextClick) then {
						(findDisplay 1100) setVariable ["uRTS_NEXTCLICK", false];
					} else {
						[_pos, _shift] call uRTS_PLAYER_POSITION;
					};
				};
				true;
			};
		};
		
		if (!visiblemap && _open) then {
			(findDisplay 1100) closeDisplay 1;
			"uRTS_MARKER" setMarkerPolylineLocal [0, 0, 0, 0];
			_open = false;
			
		};
		
		if (visiblemap && _open && uRTS_PLAYER_MODE == "SELECT") then {
			"uRTS_MARKER" setMarkerPolylineLocal [0, 0, 0, 0];		
			private _mapCtrl = (findDisplay 12) displayCtrl 51;
			private _mousePos = _mapCtrl ctrlMapScreenToWorld getMousePosition;
			[_mousePos] call uRTS_PLAYER_PREVIEW;
		};
		
		if (visiblemap && _open) then {
			private _menu = findDisplay 1100;
			private _points = _menu displayCtrl 1104;				
			if (side player == west) then {_points ctrlSetText ("Points Available: " + str uRTS_POINTS_WEST + "¤")};
			if (side player == east) then {_points ctrlSetText ("Points Available: " + str uRTS_POINTS_EAST + "¤")};	
		}
	};
};