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
		class Title : RscText
		{
			text = "Universal RTS Version 1";
			idc = -1;
			x = GUI_GRID_CENTER_X + 0 * GUI_GRID_CENTER_W;
			y = GUI_GRID_CENTER_Y + 0 * GUI_GRID_CENTER_H;
			w = 30 * GUI_GRID_CENTER_W;
			h = 1 * GUI_GRID_CENTER_H;
		};
		
		class Author : RscText
		{
			text = "Made by Kosmokainen";
			idc = -1;
			x = GUI_GRID_CENTER_X + 30 * GUI_GRID_CENTER_W;
			y = GUI_GRID_CENTER_Y + 0 * GUI_GRID_CENTER_H;
			w = 10 * GUI_GRID_CENTER_W;
			h = 1 * GUI_GRID_CENTER_H;
		};
		
		class Description : RscStructuredText
		{
			text = " Select faction and then type. <br/> Select unit from list. <br/> Click west/east list. <br/> Click 'PLAY SCENARIO' to start.";
			idc = -1;
			x = GUI_GRID_CENTER_X + 0 * GUI_GRID_CENTER_W;
			y = GUI_GRID_CENTER_Y + 1 * GUI_GRID_CENTER_H;
			w = 40 * GUI_GRID_CENTER_W;
			h = 4 * GUI_GRID_CENTER_H;
		};
		
		class Faction : RscCombo
		{
			idc = 1001;
			x = GUI_GRID_CENTER_X + 0 * GUI_GRID_CENTER_W;
			y = GUI_GRID_CENTER_Y + 5 * GUI_GRID_CENTER_H;
			w = 20 * GUI_GRID_CENTER_W;
			h = 1 * GUI_GRID_CENTER_H;
		};
		
		class Type : RscCombo
		{
			idc = 1002;
			x = GUI_GRID_CENTER_X + 20 * GUI_GRID_CENTER_W;
			y = GUI_GRID_CENTER_Y + 5 * GUI_GRID_CENTER_H;
			w = 20 * GUI_GRID_CENTER_W;
			h = 1 * GUI_GRID_CENTER_H;
			onLBSelChanged = "_this call uRTS_FNC_LIST;";
		};
		
		class List_West : RscListbox
		{
			idc = 1003;
			x = GUI_GRID_CENTER_X + 0 * GUI_GRID_CENTER_W;
			y = GUI_GRID_CENTER_Y + 16 * GUI_GRID_CENTER_H;
			w = 20 * GUI_GRID_CENTER_W;
			h = 6 * GUI_GRID_CENTER_H;
			colorBackground[] = {0, 0.15, 0.3, 1};
			onLBSelChanged = "_this call uRTS_FNC_SELECT;";
		};
		
		class List_East : RscListbox
		{
			idc = 1004;
			x = GUI_GRID_CENTER_X + 20 * GUI_GRID_CENTER_W;
			y = GUI_GRID_CENTER_Y + 16 * GUI_GRID_CENTER_H;
			w = 20 * GUI_GRID_CENTER_W;
			h = 6 * GUI_GRID_CENTER_H;
			colorBackground[] = {0.25, 0, 0, 1};
			onLBSelChanged = "_this call uRTS_FNC_SELECT;";
		};
		
		class List : RscListbox
		{
			idc = 1005;
			x = GUI_GRID_CENTER_X + 0 * GUI_GRID_CENTER_W;
			y = GUI_GRID_CENTER_Y + 6 * GUI_GRID_CENTER_H;
			w = 31 * GUI_GRID_CENTER_W;
			h = 10 * GUI_GRID_CENTER_H;
			onLBSelChanged = "[] call uRTS_FNC_ICON;";
		};
		
		class Icon: RscPicture
		{
			idc = 1006;
			x = GUI_GRID_CENTER_X + 31 * GUI_GRID_CENTER_W;
			y = GUI_GRID_CENTER_Y + 6 * GUI_GRID_CENTER_H;
			w = 9 * GUI_GRID_CENTER_W;
			h = 5 * GUI_GRID_CENTER_H;
			text = "";
		};
		
		class Icon2: RscPicture
		{
			idc = 1007;
			x = GUI_GRID_CENTER_X + 31 * GUI_GRID_CENTER_W;
			y = GUI_GRID_CENTER_Y + 11 * GUI_GRID_CENTER_H;
			w = 9 * GUI_GRID_CENTER_W;
			h = 5 * GUI_GRID_CENTER_H;
			text = "";
		};
		
		class Time : RscCombo
		{
			idc = 1008;
			x = GUI_GRID_CENTER_X + 0 * GUI_GRID_CENTER_W;
			y = GUI_GRID_CENTER_Y + 22 * GUI_GRID_CENTER_H;
			w = 10 * GUI_GRID_CENTER_W;
			h = 1 * GUI_GRID_CENTER_H;
			onLBSelChanged = "_this call uRTS_FNC_SELECT;";
		};
		
		class Weather : RscCombo
		{
			idc = 1009;
			x = GUI_GRID_CENTER_X + 10 * GUI_GRID_CENTER_W;
			y = GUI_GRID_CENTER_Y + 22 * GUI_GRID_CENTER_H;
			w = 10 * GUI_GRID_CENTER_W;
			h = 1 * GUI_GRID_CENTER_H;
			onLBSelChanged = "_this call uRTS_FNC_SELECT;";
		};
		
		class Scale : RscCombo
		{
			idc = 1010;
			x = GUI_GRID_CENTER_X + 20 * GUI_GRID_CENTER_W;
			y = GUI_GRID_CENTER_Y + 22 * GUI_GRID_CENTER_H;
			w = 10 * GUI_GRID_CENTER_W;
			h = 1 * GUI_GRID_CENTER_H;
			onLBSelChanged = "_this call uRTS_FNC_SELECT;";
		};
		
		class Position: RscButton
		{
			idc = 1011;
			text = "Position: random";
			x = GUI_GRID_CENTER_X + 30 * GUI_GRID_CENTER_W;
			y = GUI_GRID_CENTER_Y + 22 * GUI_GRID_CENTER_H;
			w = 10 * GUI_GRID_CENTER_W;
			h = 1 * GUI_GRID_CENTER_H;
			colorBackground[] = {0, 0, 0, 1};
			onButtonClick = "[] call uRTS_FNC_POSITION;";
		};
		
		class AI_WEST : RscCombo
		{
			idc = 1012;
			x = GUI_GRID_CENTER_X + 0 * GUI_GRID_CENTER_W;
			y = GUI_GRID_CENTER_Y + 23 * GUI_GRID_CENTER_H;
			w = 10 * GUI_GRID_CENTER_W;
			h = 1 * GUI_GRID_CENTER_H;
			onLBSelChanged = "_this call uRTS_FNC_SELECT;";
		};
		
		class AI_EAST : RscCombo
		{
			idc = 1013;
			x = GUI_GRID_CENTER_X + 10 * GUI_GRID_CENTER_W;
			y = GUI_GRID_CENTER_Y + 23 * GUI_GRID_CENTER_H;
			w = 10 * GUI_GRID_CENTER_W;
			h = 1 * GUI_GRID_CENTER_H;
			onLBSelChanged = "_this call uRTS_FNC_SELECT;";
		};
		
		class Difficulty : RscCombo
		{
			idc = 1014;
			x = GUI_GRID_CENTER_X + 20 * GUI_GRID_CENTER_W;
			y = GUI_GRID_CENTER_Y + 23 * GUI_GRID_CENTER_H;
			w = 10 * GUI_GRID_CENTER_W;
			h = 1 * GUI_GRID_CENTER_H;
			onLBSelChanged = "_this call uRTS_FNC_SELECT;";
		};	
		
		class Play: RscButton
		{
			idc = 1015;
			x = GUI_GRID_CENTER_X + 30 * GUI_GRID_CENTER_W;
			y = GUI_GRID_CENTER_Y + 23 * GUI_GRID_CENTER_H;
			w = 10 * GUI_GRID_CENTER_W;
			h = 1 * GUI_GRID_CENTER_H;
			colorBackground[] = {0,1,0,0.2};
			onButtonClick = "[] call uRTS_FNC_READY;";
		};		
	};
};