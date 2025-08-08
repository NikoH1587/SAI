class SAI_GUI_MENU
{
	idd = 5000;
	class ControlsBackground
	{
		class Background : RscText
		{
			idc = -1;
			x = GUI_GRID_CENTER_X + 10 * GUI_GRID_CENTER_W;
			y = GUI_GRID_CENTER_Y + 0 * GUI_GRID_CENTER_H;
			w = 20 * GUI_GRID_CENTER_W;
			h = 20 * GUI_GRID_CENTER_H;
			colorBackground[] = {0.1,0.1,0.1,1};
		};
	};
	class Controls
	{	
		class SAI_GUI_MENU_TITLE: RscText
		{
			idc = -1;
			text = "UNIVERSAL SCENARIO GENERATOR";
			x = GUI_GRID_CENTER_X + 10 * GUI_GRID_CENTER_W;
			y = GUI_GRID_CENTER_Y + 0 * GUI_GRID_CENTER_H;
			w = 20 * GUI_GRID_CENTER_W;
			h = 2 * GUI_GRID_CENTER_H;
		};
		
		class SAI_GUI_MENU_VERSION: RscText
		{
			idc = -1;
			text = "VERSION 1";
			x = GUI_GRID_CENTER_X + 10 * GUI_GRID_CENTER_W;
			y = GUI_GRID_CENTER_Y + 6 * GUI_GRID_CENTER_H;
			w = 10 * GUI_GRID_CENTER_W;
			h = 2 * GUI_GRID_CENTER_H;
		};
		
		class SAI_GUI_MENU_CREDITS: RscText
		{
			idc = -1;
			text = "MADE BY KOSMOKAINEN";
			x = GUI_GRID_CENTER_X + 10 * GUI_GRID_CENTER_W;
			y = GUI_GRID_CENTER_Y + 8 * GUI_GRID_CENTER_H;
			w = 10 * GUI_GRID_CENTER_W;
			h = 2 * GUI_GRID_CENTER_H;
		};
		
		class SAI_GUI_MENU_TEXT1: RscText
		{
			idc = -1;
			text = "BATTLE GENERATOR";
			x = GUI_GRID_CENTER_X + 10 * GUI_GRID_CENTER_W;
			y = GUI_GRID_CENTER_Y + 10 * GUI_GRID_CENTER_H;
			w = 10 * GUI_GRID_CENTER_W;
			h = 2 * GUI_GRID_CENTER_H;
		};
		
		class SAI_GUI_MENU_BUTTON1 : RscButtonMenu
		{
			idc = 5001;
			text = "";
			x = GUI_GRID_CENTER_X + 10 * GUI_GRID_CENTER_W;
			y = GUI_GRID_CENTER_Y + 10 * GUI_GRID_CENTER_H;
			w = 10 * GUI_GRID_CENTER_W;
			h = 2 * GUI_GRID_CENTER_H;
			colorBackground[] = {0,1,0.5,0.1};
			onButtonClick = "closeDialog 0; call compile preprocessFile 'UI\Config.sqf'; call compile preprocessFile 'UI\Functions.sqf'; call compile preprocessFile 'UI\Settings.sqf';";
		};
		
		class SAI_GUI_MENU_TEXT2: RscText
		{
			idc = -1;
			text = "SCENARIO SELECTION";
			x = GUI_GRID_CENTER_X + 10 * GUI_GRID_CENTER_W;
			y = GUI_GRID_CENTER_Y + 14 * GUI_GRID_CENTER_H;
			w = 10 * GUI_GRID_CENTER_W;
			h = 2 * GUI_GRID_CENTER_H;
		};
		
		class SAI_GUI_MENU_BUTTON2 : RscButtonMenu
		{
			idc = 5002;
			text = "";
			x = GUI_GRID_CENTER_X + 10 * GUI_GRID_CENTER_W;
			y = GUI_GRID_CENTER_Y + 14 * GUI_GRID_CENTER_H;
			w = 10 * GUI_GRID_CENTER_W;
			h = 2 * GUI_GRID_CENTER_H;
			colorBackground[] = {0,1,0.5,0.1};
			onButtonClick = "closeDialog 0; call compile preprocessFile 'Scenarios.sqf'; call compile preprocessFile 'UI\Scenario.sqf'";
		};
	};
};