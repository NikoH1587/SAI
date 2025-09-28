class uRTS_MENU {
	idd = 1100;
	movingEnable = 0;
	enableSimulation = 1;
		
	class controls
	{
		class Backround: RscText
		{
			idc = 1100;
			x = GUI_GRID_TOPCENTER_X + 10 * GUI_GRID_CENTER_W;
			y = GUI_GRID_TOPCENTER_Y + 2 * GUI_GRID_CENTER_W;
			w = 20 * GUI_GRID_CENTER_W;
			h = 5 * GUI_GRID_CENTER_H;
		};
				
		class Info: RscListbox
		{
			idc = 1101;
			x = GUI_GRID_TOPCENTER_X + 10 * GUI_GRID_CENTER_W;
			y = GUI_GRID_TOPCENTER_Y + 2.5 * GUI_GRID_CENTER_H;
			w = 10 * GUI_GRID_CENTER_W;
			h = 4 * GUI_GRID_CENTER_H;
		};
			
		class Select: RscCombo
		{
			idc = 1102;
			x = GUI_GRID_TOPCENTER_X + 20 * GUI_GRID_CENTER_W;
			y = GUI_GRID_TOPCENTER_Y + 1.5 * GUI_GRID_CENTER_H;
			w = 10 * GUI_GRID_CENTER_W;
			h = 1 * GUI_GRID_CENTER_H;
			onLBSelChanged = "_this call uRTS_PLAYER_SELECT;";
		};
			
		class Icon: RscPicture
		{
			idc = 1103;
			x = GUI_GRID_TOPCENTER_X + 22 * GUI_GRID_CENTER_W;
			y = GUI_GRID_TOPCENTER_Y + 3.5 * GUI_GRID_CENTER_H;
			w = 6 * GUI_GRID_CENTER_W;
			h = 3 * GUI_GRID_CENTER_H;
			text = "";
		};
		
		class Points: RscText
		{
			idc = 1104;
			x = GUI_GRID_TOPCENTER_X + 10 * GUI_GRID_CENTER_W;
			y = GUI_GRID_TOPCENTER_Y + 1.5 * GUI_GRID_CENTER_H;
			w = 10 * GUI_GRID_CENTER_W;
			h = 1 * GUI_GRID_CENTER_H;
			colorBackground[] = {0,0,0,1};
			text = "Points Available: ";
		}
		
		class List: RscListbox
		{
			idc = 1105;
			x = GUI_GRID_TOPCENTER_X + 20 * GUI_GRID_CENTER_W;
			y = GUI_GRID_TOPCENTER_Y + 2.5 * GUI_GRID_CENTER_H;
			w = 10 * GUI_GRID_CENTER_W;
			h = 4 * GUI_GRID_CENTER_H;
			onLBSelChanged = "_this call uRTS_PLAYER_COMMAND";
		};
	};
};
