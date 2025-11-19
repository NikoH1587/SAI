///HEX_GRID pushBack [[_row, _col], _name, [_x,_y], "Border", "ColorBLACK", []]
HEX_GRID = [];
HEX_COUNT = 12;
HEX_SIDE = 1000;
HEX_OFFSET = 0;
HEX_EVEN = [[0,-1],[1,-1],[1,0],[0,1],[-1,0],[-1,-1]];
HEX_ODD = [[0,-1],[1,0],[1,1],[0,1],[-1,1],[-1,0]];

HEX_CFG = [
	["Alpha", "b_inf", west, 1, []],
	["Bravo", "b_recon", west, 1, []],
	["Charlie", "b_motor_inf", west, 1, []],
	["Delta", "b_mech_inf", west, 1, []],
	["Echo", "b_armor", west, 1, []],
	["1st", "o_inf", east, 1, []],
	["2nd", "o_recon", east, 1, []],
	["3rd", "o_motor_inf", east, 1, []],
	["4th", "o_mech_inf", east, 1, []],
	["5th", "o_armor", east, 1, []]	
];

