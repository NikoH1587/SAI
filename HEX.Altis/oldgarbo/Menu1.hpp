class SCS_MENU1
{
	idd = 1000;
	class ControlsBackground
	{
		class Background : RscText
		{
			idc = -1;
			x = GUI_GRID_CENTER_X;
			y = GUI_GRID_CENTER_Y;
			w = 40 * GUI_GRID_CENTER_W;
			h = 24 * GUI_GRID_CENTER_H;
			colorBackground[] = {0.1,0.1,0.1,1};
		};
	};

	class Controls
	{			
		class Faction : RscCombo
		{
			idc = 1001;
			x = GUI_GRID_CENTER_X + 20 * GUI_GRID_CENTER_W;
			y = GUI_GRID_CENTER_Y + 0 * GUI_GRID_CENTER_H;
			w = 20 * GUI_GRID_CENTER_W;
			h = 1 * GUI_GRID_CENTER_H;
			onLBSelChanged = "_this call SCS_MENU1_LIST;";
		};
		
		class List : RscListbox
		{
			idc = 1002;
			x = GUI_GRID_CENTER_X + 20 * GUI_GRID_CENTER_W;
			y = GUI_GRID_CENTER_Y + 1 * GUI_GRID_CENTER_H;
			w = 10 * GUI_GRID_CENTER_W;
			h = 22 * GUI_GRID_CENTER_H;
			onLBSelChanged = "_this call SCS_MENU1_SELECT;";
		};
		
		class Preview : RscListbox
		{
			idc = 1003;
			x = GUI_GRID_CENTER_X + 30 * GUI_GRID_CENTER_W;
			y = GUI_GRID_CENTER_Y + 1 * GUI_GRID_CENTER_H;
			w = 10 * GUI_GRID_CENTER_W;
			h = 22 * GUI_GRID_CENTER_H;
			rowHeight = 6 * GUI_GRID_CENTER_H;
		};

		class West : RscListbox
		{
			idc = 1004;
			x = GUI_GRID_CENTER_X + 0 * GUI_GRID_CENTER_W;
			y = GUI_GRID_CENTER_Y + 0 * GUI_GRID_CENTER_H;
			w = 10 * GUI_GRID_CENTER_W;
			h = 23 * GUI_GRID_CENTER_H;
			colorBackground[] = {0,0.3,0.6,0.5};
			onLBSelChanged = "_this call SCS_MENU1_WEST_LIST;";
		};
		
		class East : RscListbox
		{
			idc = 1005;
			x = GUI_GRID_CENTER_X + 10 * GUI_GRID_CENTER_W;
			y = GUI_GRID_CENTER_Y + 0 * GUI_GRID_CENTER_H;
			w = 10 * GUI_GRID_CENTER_W;
			h = 23 * GUI_GRID_CENTER_H;
			colorBackground[] = {0.5,0,0,0.5};
			onLBSelChanged = "_this call SCS_MENU1_EAST_LIST;";
		};

		class Export : RscEdit
		{
			idc = 1006;
			x = GUI_GRID_CENTER_X + 0 * GUI_GRID_CENTER_W;
			y = GUI_GRID_CENTER_Y + 23 * GUI_GRID_CENTER_H;
			w = 40 * GUI_GRID_CENTER_W;
			h = 1 * GUI_GRID_CENTER_H;
		};			
	};
};