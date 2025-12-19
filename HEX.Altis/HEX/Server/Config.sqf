///HEX_GRID pushBack [[_row, _col], _name, [_x,_y], "Border", "ColorBLACK", []]
HEX_GRID = [];
HEX_SCENARIO = "N"; // N, E, S, W
HEX_SIZE = 500; /// "Normal" = 500, "Experimental" = 750
HEX_GROUPS = 6; /// "Normal" = 6, "Experimental" = 9
HEX_VEHICLES = 2; /// "Normal" = 1, "Experimental" = 2
HEX_EVEN = [[0,-1],[1,-1],[1,0],[0,1],[-1,0],[-1,-1]];
HEX_ODD = [[0,-1],[1,0],[1,1],[0,1],[-1,1],[-1,0]];
HEX_TURN = west;
HEX_WEST = "BLU_F";
HEX_EAST = "OPF_F";
HEX_SOUNDS = ["a3\dubbing_radio_f\sfx\radionoise1.ogg", "a3\dubbing_radio_f\sfx\radionoise2.ogg", "a3\dubbing_radio_f\sfx\radionoise3.ogg"];
/// MAX 15+15 counters?
HEX_CFG_WEST = ["b_hq", "b_art", "b_support", "b_air", "b_plane", "b_inf", "b_inf", "b_inf", "b_inf", "b_inf", "b_inf", "b_mech_inf", "b_armor", "b_recon", "b_motor_inf", "b_mech_inf", "b_armor", "b_recon", "b_motor_inf", "b_inf"];
HEX_CFG_EAST = ["o_hq", "o_art", "o_support", "o_air", "o_plane", "o_inf", "o_inf", "o_inf", "o_inf", "o_inf", "o_inf", "o_mech_inf", "o_armor", "o_recon", "o_motor_inf", "o_mech_inf", "o_armor", "o_recon", "o_motor_inf", "o_inf"];
