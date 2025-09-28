class uRTS_GUI
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
		class Import: RscButton
		{
			idc = 1001;
			text = "IMPORT / EXPORT:";
			x = GUI_GRID_CENTER_X + 0 * GUI_GRID_CENTER_W;
			y = GUI_GRID_CENTER_Y + 23 * GUI_GRID_CENTER_H;
			w = 10 * GUI_GRID_CENTER_W;
			h = 1 * GUI_GRID_CENTER_H;
			onButtonClick = "[] call uRTS_FNC_IMPORT;";
		};
		
		class Configuration: RscEdit
		{
			idc = 1002;
			x = GUI_GRID_CENTER_X + 10 * GUI_GRID_CENTER_W;
			y = GUI_GRID_CENTER_Y + 23 * GUI_GRID_CENTER_H;
			w = 20 * GUI_GRID_CENTER_W;
			h = 1 * GUI_GRID_CENTER_H;
		};
		
		class Title : RscText
		{
			idc = 1003;
			x = GUI_GRID_CENTER_X + 0 * GUI_GRID_CENTER_W;
			y = GUI_GRID_CENTER_Y + 0 * GUI_GRID_CENTER_H;
			w = 30 * GUI_GRID_CENTER_W;
			h = 1 * GUI_GRID_CENTER_H;
		};
		
		class Author : RscText
		{
			idc = 1004;
			x = GUI_GRID_CENTER_X + 30 * GUI_GRID_CENTER_W;
			y = GUI_GRID_CENTER_Y + 0 * GUI_GRID_CENTER_H;
			w = 10 * GUI_GRID_CENTER_W;
			h = 1 * GUI_GRID_CENTER_H;
		};
		
		class Description : RscListbox
		{
			idc = 1005;
			x = GUI_GRID_CENTER_X + 0 * GUI_GRID_CENTER_W;
			y = GUI_GRID_CENTER_Y + 1 * GUI_GRID_CENTER_H;
			w = 40 * GUI_GRID_CENTER_W;
			h = 4 * GUI_GRID_CENTER_H;
		};
		
		class Faction : RscCombo
		{
			idc = 1006;
			x = GUI_GRID_CENTER_X + 0 * GUI_GRID_CENTER_W;
			y = GUI_GRID_CENTER_Y + 5 * GUI_GRID_CENTER_H;
			w = 20 * GUI_GRID_CENTER_W;
			h = 1 * GUI_GRID_CENTER_H;
		};
		
		class Type : RscCombo
		{
			idc = 1007;
			x = GUI_GRID_CENTER_X + 20 * GUI_GRID_CENTER_W;
			y = GUI_GRID_CENTER_Y + 5 * GUI_GRID_CENTER_H;
			w = 20 * GUI_GRID_CENTER_W;
			h = 1 * GUI_GRID_CENTER_H;
			onLBSelChanged = "_this call uRTS_FNC_LIST;";
		};
		
		class List_West : RscListbox
		{
			idc = 1008;
			x = GUI_GRID_CENTER_X + 0 * GUI_GRID_CENTER_W;
			y = GUI_GRID_CENTER_Y + 13 * GUI_GRID_CENTER_H;
			w = 20 * GUI_GRID_CENTER_W;
			h = 9 * GUI_GRID_CENTER_H;
			colorBackground[] = {0,1,1,0.1};
			onLBSelChanged = "_this call uRTS_FNC_SELECT;";
		};
		
		class List_East : RscListbox
		{
			idc = 1009;
			x = GUI_GRID_CENTER_X + 20 * GUI_GRID_CENTER_W;
			y = GUI_GRID_CENTER_Y + 13 * GUI_GRID_CENTER_H;
			w = 20 * GUI_GRID_CENTER_W;
			h = 9 * GUI_GRID_CENTER_H;
			colorBackground[] = {1,1,0,0.1};
			onLBSelChanged = "_this call uRTS_FNC_SELECT;";
		};
		
		class List : RscListbox
		{
			idc = 1010;
			x = GUI_GRID_CENTER_X + 0 * GUI_GRID_CENTER_W;
			y = GUI_GRID_CENTER_Y + 6 * GUI_GRID_CENTER_H;
			w = 28 * GUI_GRID_CENTER_W;
			h = 7 * GUI_GRID_CENTER_H;
			onLBSelChanged = "[] call uRTS_FNC_ICON;";
		};
		
		class Time : RscCombo
		{
			idc = 1013;
			x = GUI_GRID_CENTER_X + 0 * GUI_GRID_CENTER_W;
			y = GUI_GRID_CENTER_Y + 22 * GUI_GRID_CENTER_H;
			w = 10 * GUI_GRID_CENTER_W;
			h = 1 * GUI_GRID_CENTER_H;
			onLBSelChanged = "_this call uRTS_FNC_SELECT;";
		};
		
		class Weather : RscCombo
		{
			idc = 1014;
			x = GUI_GRID_CENTER_X + 10 * GUI_GRID_CENTER_W;
			y = GUI_GRID_CENTER_Y + 22 * GUI_GRID_CENTER_H;
			w = 10 * GUI_GRID_CENTER_W;
			h = 1 * GUI_GRID_CENTER_H;
			onLBSelChanged = "_this call uRTS_FNC_SELECT;";
		};
		
		class Scale : RscCombo
		{
			idc = 1015;
			x = GUI_GRID_CENTER_X + 20 * GUI_GRID_CENTER_W;
			y = GUI_GRID_CENTER_Y + 22 * GUI_GRID_CENTER_H;
			w = 10 * GUI_GRID_CENTER_W;
			h = 1 * GUI_GRID_CENTER_H;
			onLBSelChanged = "_this call uRTS_FNC_SELECT;";
		};
		
		class Scenario : RscCombo
		{
			idc = 1016;
			x = GUI_GRID_CENTER_X + 30 * GUI_GRID_CENTER_W;
			y = GUI_GRID_CENTER_Y + 22 * GUI_GRID_CENTER_H;
			w = 10 * GUI_GRID_CENTER_W;
			h = 1 * GUI_GRID_CENTER_H;
			onLBSelChanged = "_this call uRTS_FNC_SELECT;";
		};
		
		class Icon: RscPicture
		{
			idc = 1017;
			x = GUI_GRID_CENTER_X + 28 * GUI_GRID_CENTER_W;
			y = GUI_GRID_CENTER_Y + 6 * GUI_GRID_CENTER_H;
			w = 12 * GUI_GRID_CENTER_W;
			h = 7 * GUI_GRID_CENTER_H;
			text = "";
		};
		
		class Play: RscButton
		{
			idc = 1020;
			text = "PLAY";
			x = GUI_GRID_CENTER_X + 30 * GUI_GRID_CENTER_W;
			y = GUI_GRID_CENTER_Y + 23 * GUI_GRID_CENTER_H;
			w = 10 * GUI_GRID_CENTER_W;
			h = 1 * GUI_GRID_CENTER_H;
			colorBackground[] = {0,1,0,0.2};
			onButtonClick = "[] call uRTS_FNC_PLAY;";
		};
	};
};