SAI_FNC_SET_WEATHER = {
	_overcast = 0;
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
	_date = date;
	_suntime = _date call BIS_fnc_sunriseSunsetTime;
	_sunrise = _suntime select 0;
	_sunset = _suntime select 1;
	_hour = 0;

	switch (_this select 0) do {
		case 0: {_hour = random 23};
		case 1: {_hour = _sunrise};
		case 2: {_hour = 12};
		case 3: {_hour = _sunset};
		case 4: {0};
	};

	_newDate = [_date select 0, _date select 1, _date select 2, _hour, random 59];
	setDate _newDate;
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
	_select = _this select 0;
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
	};
};

SAI_FNC_SET_EAST = {
	_select = _this select 0;
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
	};
};