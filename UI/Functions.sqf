SAI_FNC_CONDITIONS = {
	private _suntime = SAI_CFG_DATE call BIS_fnc_sunriseSunsetTime;
	private _sunrise = _suntime select 0;
	private _sunset = _suntime select 1;
	
	switch (_this select 0) do {
		case 0: {SAI_CFG_TIME = random [0, 11.5, 23]; 	SAI_CFG_CAST = random 1};
		case 1: {SAI_CFG_TIME = _sunrise + (random 1); 	SAI_CFG_CAST = 0};
		case 2: {SAI_CFG_TIME = random [9, 12, 15];		SAI_CFG_CAST = 0};
		case 3: {SAI_CFG_TIME = _sunset - (random 1);	SAI_CFG_CAST = 0};
		case 4: {SAI_CFG_TIME = random 4; 				SAI_CFG_CAST = 0};
		case 5: {SAI_CFG_TIME = _sunrise + (random 1); 	SAI_CFG_CAST = 0.5};
		case 6: {SAI_CFG_TIME = random [9, 12, 15]; 	SAI_CFG_CAST = 0.5};
		case 7: {SAI_CFG_TIME = _sunset - (random 1); 	SAI_CFG_CAST = 0.5};
		case 8: {SAI_CFG_TIME = random 4;				SAI_CFG_CAST = 0.5};
		case 9: {SAI_CFG_TIME = _sunrise + (random 1);	SAI_CFG_CAST = 1};
		case 10: {SAI_CFG_TIME = random [9, 12, 15]; 	SAI_CFG_CAST = 1};
		case 11: {SAI_CFG_TIME = _sunset - (random 1);	SAI_CFG_CAST = 1};
		case 12: {SAI_CFG_TIME = random 4;				SAI_CFG_CAST = 1};
	};
	
	0 setOverCast SAI_CFG_CAST;
	forceWeatherChange;
	private _date = [SAI_CFG_DATE select 0, SAI_CFG_DATE  select 1, SAI_CFG_DATE  select 2, SAI_CFG_TIME, SAI_CFG_DATE  select 4];
	setDate _date;
	skipTime 0;
};

SAI_FNC_SCENARIO = {
	switch (_this select 0) do {
		case 0: {SAI_CFG_SCALE = 1};
		case 1: {SAI_CFG_SCALE = 2};
		case 2: {SAI_CFG_SCALE = 3};
	};
};

SAI_FNC_SET_DIFFICULTY = {
	switch (_this select 0) do {
		case 0: {SAI_CFG_DIFFICULTY = -1};
		case 1: {SAI_CFG_DIFFICULTY = 0};
		case 2: {SAI_CFG_DIFFICULTY = 1};
	};
};

SAI_FNC_SET_ROLE = {
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
	};
};

SAI_FNC_COM_WEST = {
	switch (_this select 0) do {
		case 0: {SAI_CFG_WEST_COM = 0};
		case 1: {SAI_CFG_WEST_COM = 1};
		case 2: {SAI_CFG_WEST_COM = 2};
		case 3: {SAI_CFG_WEST_COM = 3};
		case 4: {SAI_CFG_WEST_COM = 4};
		case 5: {SAI_CFG_WEST_COM = 5; };
	};
};

SAI_FNC_SET_EAST = {
	private _select = _this select 0;
	if (_select > 0) then {
		SAI_CFG_EAST = SAI_CFG_FACTIONS select (_select - 1);
	} else {
	};
};

SAI_FNC_COM_EAST = {
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