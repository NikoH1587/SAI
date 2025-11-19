HEX_MODE = "SELECT";
HEX_SELECTED = [];
HEX_MOVES = [];

HEX_CMD_SELECT = {
    private _pos = _this select 0;
    private _side = _this select 1;
    private _hex = _pos call HEX_FNC_GETHEX;
    private _units = if (_side == "WEST") then {HEX_WEST} else {HEX_EAST};

    {
        private _unitRowCol = [_x select 0, _x select 1];
        private _moves = _x select 4;
        if (_unitRowCol isEqualTo [_hex select 0, _hex select 1] && _moves > 0) exitWith {
            HEX_SELECTED = _x;
            HEX_CMD_MODE = "ORDER";
            hint format ["Selected %1", _x select 2];
        };
    } forEach _units;
};

HEX_CMD_ORDER = {
    private _pos = _this select 0;
    private _side = _this select 1;
    if (count HEX_SELECTED == 0) exitWith {HEX_CMD_MODE = "SELECT"};

    private _hex = _pos call HEX_FNC_GETHEX;
    private _markerName = HEX_SELECTED select 2;

    // Move the unit's marker
    getMarkerPos _markerName; // just for reference, not needed
    _markerName setMarkerPos (_hex select 2);

    // Update the unit array row/col and moves
    HEX_SELECTED set [0, _hex select 0];
    HEX_SELECTED set [1, _hex select 1];
    private _moves = (HEX_SELECTED select 4) - 1;
    HEX_SELECTED set [4, _moves];
    hint format ["%1 moves left", _moves];

    HEX_CMD_MODE = "SELECT";
    HEX_SELECTED = [];
};

onMapSingleClick {
    params ["_pos","_units","_shift","_alt"];
    private _side = str playerSide;
    if (HEX_CMD_MODE == "SELECT") then {[_pos, _side] call HEX_CMD_SELECT} else {
        if (HEX_CMD_MODE == "ORDER") then {[_pos, _side] call HEX_CMD_ORDER};
    };
    true
};

HEX_CMD_MODE = "SELECT";