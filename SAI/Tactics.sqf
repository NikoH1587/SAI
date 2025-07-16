{
	_ldr = leader _x;
	_veh = vehicle leader _x;
	_ord = "NONE";
	_sta = getUnitState _ldr;
	_srv = needService _veh;
	_obj = getMarkerPos SAI_WEST_OBJECTIVE;
	_base = getMarkerPos "SAI_WEST";
	_eny = SAI_WEST_ENEMIES;
	_inf = SAI_WEST_INF;
	_side = side _ldr;
	if (_side == SAI_EAST) then {
		_obj = getMarkerPos SAI_EAST_OBJECTIVE;
		_base = getMarkerPos "SAI_EAST";
		_eny = SAI_EAST_ENEMIES;
		_inf = SAI_EAST_INF;
	};
	
	if (_x in (SAI_WEST_REC + SAI_EAST_REC)) then {_ord = "REC"};
	if (_x in (SAI_WEST_QRF + SAI_EAST_QRF)) then {_ord = "QRF"};
	if (_x in (SAI_WEST_DEF + SAI_EAST_DEF)) then {_ord = "DEF"};
	if (_x in (SAI_WEST_AIR + SAI_EAST_AIR)) then {_ord = "AIR"};
	if (_x in (SAI_WEST_LOG + SAI_EAST_LOG)) then {_ord = "LOG"};
	if (_x in (SAI_WEST_SUP + SAI_EAST_SUP)) then {_ord = "RTB"};
	
	if (_srv findIf {_x > 0.50} > -1) then {_ord = "RTB"};
	if (fleeing _ldr) then {_ord = "RTB"};
	if (_x in (SAI_WEST_ART + SAI_EAST_ART)) then {_ord = "ART"};
	if (_sta != "WAIT" && _sta != "OK") then {_ord = "BUSY"};
	if (isPlayer _ldr) then {_ord = "PLAYER"};
	if (behaviour _ldr == "COMBAT") then {_ord = "COMBAT"};
	if (count _eny == 0 && _ord == "ART") then {_ord = "NONE"};
	if (count _eny == 0 && _ord == "QRF") then {_ord = "RTB"};
	switch (_ord) do {
		case "REC": {[_x, _obj] call SAI_WP_REC};	
		case "QRF": {[_x, _eny] call SAI_WP_QRF};
		case "DEF": {[_x, _base] call SAI_WP_DEF};
		case "AIR": {[_x, _obj, _base] call SAI_WP_AIR};
		case "LOG": {[_x, _inf, _obj, _base] call SAI_WP_LOG};
		case "RTB": {[_x, _base] call SAI_WP_RTB};
		case "ART": {[_x, _eny] call SAI_WP_ART};
	}
}forEach (SAI_ALL);