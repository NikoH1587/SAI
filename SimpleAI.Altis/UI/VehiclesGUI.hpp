class SAI_GUI_VEHICLES
{
	idd = 2000;
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
		class SAI_GUI_VEH_TITLE: RscText
		{
			idc = -1;
			text = "CUSTOM VEHICLE SELECTION";
			x = GUI_GRID_CENTER_X + 0 * GUI_GRID_CENTER_W;
			y = GUI_GRID_CENTER_Y + 0 * GUI_GRID_CENTER_H;
			w = 20 * GUI_GRID_CENTER_W;
			h = 2 * GUI_GRID_CENTER_H;
		};
		
		
		class SAI_GUI_VEH_LIST : RscListBox
		{
			idc = 2001;
			x = GUI_GRID_CENTER_X + 0 * GUI_GRID_CENTER_W;
			y = GUI_GRID_CENTER_Y + 2 * GUI_GRID_CENTER_H;
			w = 20 * GUI_GRID_CENTER_W;
			h = 18 * GUI_GRID_CENTER_H;
			onLBSelChanged = "_select = (_this select 1); [_select] call SAI_FNC_SET_VEH;";
		};		
		
		class SAI_GUI_VEH_LIST_WEST : RscListBox
		{
			idc = 2002;
			x = GUI_GRID_CENTER_X + 20 * GUI_GRID_CENTER_W;
			y = GUI_GRID_CENTER_Y + 2 * GUI_GRID_CENTER_H;
			w = 20 * GUI_GRID_CENTER_W;
			h = 6 * GUI_GRID_CENTER_H;
		};	
		
		class SAI_GUI_VEH_LIST_EAST : RscListBox
		{
			idc = 2003;
			x = GUI_GRID_CENTER_X + 20 * GUI_GRID_CENTER_W;
			y = GUI_GRID_CENTER_Y + 10 * GUI_GRID_CENTER_H;
			w = 20 * GUI_GRID_CENTER_W;
			h = 6 * GUI_GRID_CENTER_H;
		};	

		class SAI_GUI_VEH_COPY : RscButtonMenu
		{
			idc = 2011;
			text = "COPY";
			onButtonClick = "copyToClipboard str [SAI_CFG_CUSTOM_WEST, SAI_CFG_CUSTOM_EAST]; hint 'Copied vehicles list to clipboard'";
			x = GUI_GRID_CENTER_X + 20 * GUI_GRID_CENTER_W;
			y = GUI_GRID_CENTER_Y + 0 * GUI_GRID_CENTER_H;
			w = 10 * GUI_GRID_CENTER_W;
			h = 2 * GUI_GRID_CENTER_H;
			tooltip = "Copy vehicle list to clipboard in format [['west_veh1','west_veh2'],['east_veh1','east_veh2']]";
			colorBackground[] = {0.5,0,0.5,0.1};
		};
		
		class SAI_GUI_VEH_PASTE : RscButtonMenu
		{
			idc = 2012;
			text = "PASTE";
			x = GUI_GRID_CENTER_X + 30 * GUI_GRID_CENTER_W;
			y = GUI_GRID_CENTER_Y + 0 * GUI_GRID_CENTER_H;
			w = 10 * GUI_GRID_CENTER_W;
			h = 2 * GUI_GRID_CENTER_H;
			tooltip = "Paste vehicles list from clipboard. Might not work in MP.";
			colorBackground[] = {0.5,0,0.5,0.1};
			onButtonClick = "_copylist = call compile copyFromClipboard; if (_copylist isEqualType [] && {count _copylist == 2}) then {SAI_CFG_CUSTOM_WEST = _copylist select 0; SAI_CFG_CUSTOM_EAST = _copylist select 1; call SAI_FNC_NEW_VEH_LIST; hint 'Pasted vehicles list from clipboard';} else {hint 'Clipboard content is invalid!';};";
		};		
		
		class SAI_GUI_VEH_WEST : RscButtonMenu
		{
			idc = 2013;
			text = "SET TO PLAYER SIDE";
			x = GUI_GRID_CENTER_X + 20 * GUI_GRID_CENTER_W;
			y = GUI_GRID_CENTER_Y + 8 * GUI_GRID_CENTER_H;
			w = 20 * GUI_GRID_CENTER_W;
			h = 2 * GUI_GRID_CENTER_H;
			tooltip = "Set selected vehicle to player side.";
			colorBackground[] = {0,1,1,0.1};
			onButtonClick = "call SAI_FNC_SET_VEH_WEST";
		};		
		
		class SAI_GUI_VEH_EAST : RscButtonMenu
		{
			idc = 2014;
			text = "SET TO ENEMY SIDE";
			x = GUI_GRID_CENTER_X + 20 * GUI_GRID_CENTER_W;
			y = GUI_GRID_CENTER_Y + 16 * GUI_GRID_CENTER_H;
			w = 20 * GUI_GRID_CENTER_W;
			h = 2 * GUI_GRID_CENTER_H;
			tooltip = "Set selected vehicle to enemy side.";
			colorBackground[] = {1,0.5,0,0.1};
			onButtonClick = "call SAI_FNC_SET_VEH_EAST";
		};		
		
		class SAI_GUI_VEH_NO : RscButtonMenu
		{
			idc = 2015;
			text = "RESET";
			x = GUI_GRID_CENTER_X + 20 * GUI_GRID_CENTER_W;
			y = GUI_GRID_CENTER_Y + 18 * GUI_GRID_CENTER_H;
			w = 10 * GUI_GRID_CENTER_W;
			h = 2 * GUI_GRID_CENTER_H;
			colorBackground[] = {1,0,0,0.1};
			tooltip = "Clear all selections.";
			onButtonClick = "call SAI_FNC_RST_VEH_LIST";
		};		
		
		class SAI_GUI_VEH_OK : RscButtonMenu
		{
			idc = 2021;
			text = "START MISSION";
			x = GUI_GRID_CENTER_X + 30 * GUI_GRID_CENTER_W;
			y = GUI_GRID_CENTER_Y + 18 * GUI_GRID_CENTER_H;
			w = 10 * GUI_GRID_CENTER_W;
			h = 2 * GUI_GRID_CENTER_H;
			colorBackground[] = {0,1,0.5,0.1};
			onButtonClick = "closeDialog 0; execVM 'SAI.sqf'";
		};
	};
};