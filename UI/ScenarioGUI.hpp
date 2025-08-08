class SAI_GUI_SCENARIO
{
	idd = 4000;
	class ControlsBackground
	{
		class Background : RscText
		{
			idc = -1;
			x = GUI_GRID_CENTER_X;
			y = GUI_GRID_CENTER_Y;
			w = 40 * GUI_GRID_CENTER_W;
			h = 20 * GUI_GRID_CENTER_H;
			colorBackground[] = {0.1,0.1,0.1,1};
		};
	};
	class Controls
	{	
		class SAI_GUI_SCE_TITLE: RscText
		{
			idc = -1;
			text = "SCENARIO SELECTION";
			x = GUI_GRID_CENTER_X + 0 * GUI_GRID_CENTER_W;
			y = GUI_GRID_CENTER_Y + 0 * GUI_GRID_CENTER_H;
			w = 20 * GUI_GRID_CENTER_W;
			h = 2 * GUI_GRID_CENTER_H;
		};
		
		
		class SAI_GUI_SCE_LIST : RscListBox
		{
			idc = 4001;
			x = GUI_GRID_CENTER_X + 0 * GUI_GRID_CENTER_W;
			y = GUI_GRID_CENTER_Y + 2 * GUI_GRID_CENTER_H;
			w = 20 * GUI_GRID_CENTER_W;
			h = 18 * GUI_GRID_CENTER_H;
			onLBSelChanged = "_select = (_this select 1); [_select] call SAI_FNC_SET_SCENARIO;";
		};	
	};
};