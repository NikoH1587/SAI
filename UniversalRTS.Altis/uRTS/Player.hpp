class uRTS_MENU {
	idd = 1100;
		
	class controls
	{		
		class Purchase: RscCombo
		{
			idc = 1101;
			x = GUI_GRID_TOPCENTER_X + 15 * GUI_GRID_CENTER_W;
			y = GUI_GRID_TOPCENTER_Y + 0 * GUI_GRID_CENTER_H;
			w = 10 * GUI_GRID_CENTER_W;
			h = 1.5 * GUI_GRID_CENTER_H;
			onLBSelChanged = "(_this select 1) call uRTS_PLAYER_PURCHASE;";
		};
		
		class Gameinfo: RscListbox
		{
			idc = 1102;
			x = GUI_GRID_TOPCENTER_X + 15 * GUI_GRID_CENTER_W;
			y = GUI_GRID_TOPCENTER_Y + 1.5 * GUI_GRID_CENTER_H;
			w = 10 * GUI_GRID_CENTER_W;
			h = 3 * GUI_GRID_CENTER_H;
		};		
		
		class Command: RscListbox
		{
			idc = 1103;
			x = GUI_GRID_TOPCENTER_X + 15 * GUI_GRID_CENTER_W;
			y = GUI_GRID_TOPCENTER_Y + 4.5 * GUI_GRID_CENTER_H;
			w = 10 * GUI_GRID_CENTER_W;
			h = 2 * GUI_GRID_CENTER_H;
			onLBSelChanged = "(_this select 1) call uRTS_PLAYER_ORDER;";
		};
	};
};
