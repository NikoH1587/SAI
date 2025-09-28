uRTS_CMD_MOVE = {
	private _nid = _this select 0;
	private _pos = _this select 1;
	private _shift = _this select 2;
	private _grp = _nid call BIS_fnc_groupFromNetId;
	
	systemChat format ["CMD_MOVE called: netID=%1, pos=%2, grp=%3", _nid, _pos, _grp, _shift];
	if (!_shift) then {
		for "_i" from 0 to (count waypoints _grp) - 1 do {
			deleteWaypoint [_grp, 0];
		};
	};
	_grp addWaypoint [_pos, 0];
};

///		case "MOVE": {[_nid, _pos] remoteExecCall ["uRTS_CMD_MOVE", 2]};
///		case "ATTACK": {[_nid, _pos] remoteExecCall ["uRTS_CMD_ATTACK", 2]};
///		case "DEFEND": {[_nid, _pos] remoteExecCall ["uRTS_CMD_DEFEND", 2]};
///		case "STOP": {[_nid] remoteExecCall ["uRTS_CMD_STOP", 2]};
///		case "LEAD": {[_nid, player] remoteExecCall ["uRTS_CMD_LEAD", 2]};
///		case "DISBAND": {[_nid] remoteExecCall ["uRTS_CMD_DISBAND", 2]};
///		case "AI CMD 0": {[side player] remoteExecCall ["uRTS_CMD_AI_CMD_0", 2]};
///		case "AI CMD 1": {[side player] remoteExecCall ["uRTS_CMD_AI_CMD_1", 2]};
///		case "LEAVE SQUAD": {[player] remoteExecCall ["uRTS_CMD_LEAVE", 2]};