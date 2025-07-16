SAI_WEST_OBJECTIVE = "SAI_CENT";
SAI_EAST_OBJECTIVE = "SAI_CENT";
if (SAI_MODE_WEST == "ATTACK") then {SAI_WEST_OBJECTIVE = "SAI_EAST"};
if (SAI_MODE_WEST == "DEFEND") then {SAI_WEST_OBJECTIVE = "SAI_WEST"};
if (SAI_MODE_EAST == "ATTACK") then {SAI_EAST_OBJECTIVE = "SAI_WEST"};
if (SAI_MODE_EAST == "DEFEND") then {SAI_EAST_OBJECTIVE = "SAI_EAST"};

SAI_WEST_ENEMIES = [];
SAI_WEST_REC = [];
SAI_WEST_DEF = [];
SAI_EAST_QRF = [];

SAI_EAST_ENEMIES = [];
SAI_EAST_REC = [];
SAI_EAST_DEF = [];
SAI_EAST_QRF = [];
{
	if ((SAI_WEST knowsAbout _x) == 4 && (side _x == SAI_EAST)) then {
		SAI_WEST_ENEMIES append [_x];
	};
	
	if ((SAI_EAST knowsAbout _x) == 4 && (side _x == SAI_WEST)) then {
		SAI_EAST_ENEMIES append [_x];
	};
}forEach allUnits;

{
	_mod = (count SAI_WEST_ALL) / 3;
	if (_x in SAI_WEST_INF) then {_srt = "WEST_INF"};
	if (_x in SAI_WEST_VEH) then {_srt = "WEST_VEH"};
	if (_x in SAI_WEST_ARM) then {_srt = "WEST_ARM"};
	
	if (_x in SAI_WEST_INF) then {_srt = "EAST_INF"};
	if (_x in SAI_WEST_VEH) then {_srt = "EAST_VEH"};
	if (_x in SAI_WEST_ARM) then {_srt = "WEST_ARM"};
	
	if (count SAI_WEST_REC < _mod && _srt == "INF") then {_srt = "DEF"};
	if (count SAI_WEST_REC < _mod && _srt == "VEH") then {_srt = "REC"};
	if (count SAI_WEST_QRF < _mod && _srt == "ARM") then {_srt = "QRF"};
	
	switch (_srt) do {
		case "REC": {SAI_WEST_REC append [_x]; SAI_WEST_ALL = SAI_WEST_ALL - [_x]};	
		case "QRF": {SAI_WEST_QRF append [_x]; SAI_WEST_ALL = SAI_WEST_ALL - [_x]};	
		case "DEF": {SAI_WEST_DEF append [_x]; SAI_WEST_ALL = SAI_WEST_ALL - [_x]};
	}
}forEach SAI_ALL;

{
	_mod = (count SAI_WEST_ALL) / 3;
	if (count SAI_WEST_DEF < _mod) then {SAI_WEST_DEF append [_x]};
	if (count SAI_WEST_QRF < _mod) then {SAI_WEST_QRF append [_x]};
	if (count SAI_WEST_REC < _mod) then {SAI_WEST_REC append [_x]};
}forEach SAI_WEST_ALL;

