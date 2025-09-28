class SAI_GUI_CMD
{
	idd = 3000;
	class ControlsBackground
	{
		class Background : RscText
		{
			idc = -1;
			x = GUI_GRID_CENTER_X;
			y = GUI_GRID_CENTER_Y;
			w = 6 * GUI_GRID_CENTER_W;
			h = 2 * GUI_GRID_CENTER_H;
			colorBackground[] = {0.1,0.1,0.1,1};
		};
	};
	class Controls
	{
		
		class SAI_GUI_CMD_ICON: RscPicture
		{
			idc = 3001;
			text = "\A3\ui_f\data\map\markers\nato\b_inf.paa";
			x = GUI_GRID_CENTER_X + 0 * GUI_GRID_CENTER_W;
			y = GUI_GRID_CENTER_Y + 0 * GUI_GRID_CENTER_H;
			w = 1 * GUI_GRID_CENTER_W;
			h = 1 * GUI_GRID_CENTER_H;
		};	
		
		class SAI_GUI_CMD_TEXT: RscText
		{
			idc = 3002;
			text = "CMD TEXT";
			x = GUI_GRID_CENTER_X + 1 * GUI_GRID_CENTER_W;
			y = GUI_GRID_CENTER_Y + 0 * GUI_GRID_CENTER_H;
			w = 4 * GUI_GRID_CENTER_W;
			h = 1 * GUI_GRID_CENTER_H;
		};		
		
		class SAI_GUI_CMD_LIST : RscCombo
		{
			idc = 3003;
			x = GUI_GRID_CENTER_X + 0 * GUI_GRID_CENTER_W;
			y = GUI_GRID_CENTER_Y + 1 * GUI_GRID_CENTER_H;
			w = 6 * GUI_GRID_CENTER_W;
			h = 1 * GUI_GRID_CENTER_H;
			onLBSelChanged = "_select = (_this select 1); [_select] call SAI_CMD_SELECT;";
		};		
	};
};