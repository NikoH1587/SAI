openmap true;

HEX_CMD_SELECT = {
	private _side = _this select 0;
	private _pos = _this select 1;
	if (HEX_TURN == side player) then {
		
	};
};

onMapSingleClick {
	if (HEX_MODE == "SELECT") then {[side player, _pos] call HEX_CMD_SELECT};
	true;
};