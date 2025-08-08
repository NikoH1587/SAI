SAI_FNC_SET_WEATHER = {
	private _overcast = 0;
	switch (_this select 0) do {
		case 0: {_overcast = random 1};
		case 1: {_overcast = 0};
		case 2: {_overcast = 0.5};
		case 3: {_overcast = 1};
	};
	0 setOverCast _overcast;
	forceWeatherChange;
};

SAI_FNC_SET_TIME = {
	private _date = date;
	private _suntime = _date call BIS_fnc_sunriseSunsetTime;
	private _sunrise = _suntime select 0;
	private _sunset = _suntime select 1;
	private _hour = 0;

	switch (_this select 0) do {
		case 0: {_hour = random [0, 11.5, 23]};
		case 1: {_hour = _sunrise + 1};
		case 2: {_hour = random [9, 12, 15]};
		case 3: {_hour = _sunset - 1};
		case 4: {random 4};
	};

	_newDate = [_date select 0, _date select 1, _date select 2, _hour, random 59];
	setDate _newDate;
	skipTime 0;
};

SAI_FNC_SET_DATE = {
	private _date = _this select 0;
	setDate _date;
	skipTime 0;
};

SAI_FNC_SET_SCALE = {
	SAI_CFG_SCALE = 2;
	switch (_this select 0) do {
		case 0: {SAI_CFG_SCALE = 1};
		case 1: {SAI_CFG_SCALE = 2};
		case 2: {SAI_CFG_SCALE = 3};
	};
};

SAI_FNC_SET_DIFFICULTY = {
	SAI_CFG_DIFFICULTY = 0;
	switch (_this select 0) do {
		case 0: {SAI_CFG_DIFFICULTY = -1};
		case 1: {SAI_CFG_DIFFICULTY = 0};
		case 2: {SAI_CFG_DIFFICULTY = 1};
	};
};

SAI_FNC_SET_ROLE = {
	SAI_CFG_ROLE = 1;
	switch (_this select 0) do {
		case 0: {SAI_CFG_ROLE = 0};
		case 1: {SAI_CFG_ROLE = 1};
		case 2: {SAI_CFG_ROLE = 2};
	};
};

SAI_FNC_SET_WEST = {
	private _select = _this select 0;
	if (_select > 0) then {
		SAI_CFG_WEST = SAI_CFG_FACTIONS select (_select - 1);
	} else {
		SAI_CFG_WEST = ["West", "BLU_F", "Infantry", "BLU_F"];
	};
};

SAI_FNC_COM_WEST = {
	SAI_CFG_WEST_COM = 0;
	switch (_this select 0) do {
		case 0: {SAI_CFG_WEST_COM = 0};
		case 1: {SAI_CFG_WEST_COM = 1};
		case 2: {SAI_CFG_WEST_COM = 2};
		case 3: {SAI_CFG_WEST_COM = 3};
		case 4: {SAI_CFG_WEST_COM = 4};
		case 5: {SAI_CFG_WEST_COM = 5};
	};
};

SAI_FNC_SET_EAST = {
	private _select = _this select 0;
	if (_select > 0) then {
		SAI_CFG_EAST = SAI_CFG_FACTIONS select (_select - 1);
	} else {
		SAI_CFG_EAST = ["East", "OPF_F", "Infantry", "OPF_F"];
	};
};

SAI_FNC_COM_EAST = {
	SAI_CFG_EAST_COM = 0;
	switch (_this select 0) do {
		case 0: {SAI_CFG_EAST_COM = 0};
		case 1: {SAI_CFG_EAST_COM = 1};
		case 2: {SAI_CFG_EAST_COM = 2};
		case 3: {SAI_CFG_EAST_COM = 3};
		case 4: {SAI_CFG_EAST_COM = 4};
		case 5: {SAI_CFG_EAST_COM = 5};
	};
};

SAI_FNC_SET_VEH = {
	private _select = _this select 0;
	SAI_CFG_SET_VEH = SAI_CFG_CFGVEHICLES select _select;
};

SAI_FNC_SET_VEH_WEST = {
	SAI_CFG_CUSTOM_WEST append [SAI_CFG_SET_VEH];
	call SAI_FNC_NEW_VEH_LIST;
};

SAI_FNC_SET_VEH_EAST = {
	SAI_CFG_CUSTOM_EAST append [SAI_CFG_SET_VEH];
	call SAI_FNC_NEW_VEH_LIST;
};

SAI_FNC_NEW_VEH_LIST = {
	private _display = findDisplay 2000;
	if (isNull _display) exitWith {};
	
	private _list_west = _display displayCtrl 2002;
	private _list_east = _display displayCtrl 2003;
	
	lbClear _list_west;
	lbClear _list_east;
	
	{_list_west lbAdd _x}forEach SAI_CFG_CUSTOM_WEST;
	{_list_east lbAdd _x}forEach SAI_CFG_CUSTOM_EAST;
};

SAI_FNC_RST_VEH_LIST = {
	private _display = findDisplay 2000;
	if (isNull _display) exitWith {};
	
	private _list_west = _display displayCtrl 2002;
	private _list_east = _display displayCtrl 2003;
	
	lbClear _list_west;
	lbClear _list_east;
	
	SAI_CFG_CUSTOM_WEST = [];
	SAI_CFG_CUSTOM_EAST = [];
};

/// onMapSingleClick {
/// 	params ["_pos", "_alt", "_shift", "_ctrl"];
/// 	// Example: only create marker if CTRL is held down
/// 	if (_ctrl) then {
/// 		[_pos, 1] call SAI_fnc_addObjectiveMarker;
/// 	};
/// 	true  // Ensures map click does not move player
///};

SAI_FNC_SET_MARKER = {
	private _position = _this select 0;
	private _side = _this select 1;
	private _markers = allMapmarkers select {_x find "SAI_OBJ_" == 0};
	private _index = count _markers;
	private _name = format ["SAI_OBJ_%1", _index];
	
	private _marker = createMarker [_name, _position];
	switch (_side) do {
		case 0: {_marker setMarkerColor "ColorWEST"};
		case 1: {_marker setMarkerColor "ColorBlack"};
		case 2: {_marker setMarkerColor "ColorEAST"};
	};
};

SAI_FNC_SELECT_SCENARIO = {
	private _select = _this select 0;
	SAI_CFG_SCENARIO = SAI_CFG_SCENARIOS select _select;
};