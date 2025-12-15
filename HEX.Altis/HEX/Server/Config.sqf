///HEX_GRID pushBack [[_row, _col], _name, [_x,_y], "Border", "ColorBLACK", []]
HEX_GRID = [];
HEX_LOCS = [];
HEX_COUNTERS = [];
HEX_SCENARIO = "S"; // N, S, R
HEX_SIDE = 1000;
HEX_OFFSET = 0;
HEX_EVEN = [[0,-1],[1,-1],[1,0],[0,1],[-1,0],[-1,-1]];
HEX_ODD = [[0,-1],[1,0],[1,1],[0,1],[-1,1],[-1,0]];
HEX_TURN = west;
HEX_WEST = "BLU_F";
HEX_EAST = "OPF_F";

HEX_CFG_WEST = ["b_hq", "b_plane", "b_air", "b_art", "b_support", "b_inf", "b_motor_inf", "b_mech_inf", "b_armor", "b_recon"];
HEX_CFG_EAST = ["o_hq", "o_plane", "o_air", "o_art", "o_support", "o_inf", "o_motor_inf", "o_mech_inf", "o_armor", "o_recon"];
HEX_CFG_LOCS = ["NameCityCapital", "NameCity", "NameVillage", "NameLocal", "Hill", "Invisible"];
