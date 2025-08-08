class SAI_GUI_SETTINGS
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
			h = 20 * GUI_GRID_CENTER_H;
			colorBackground[] = {0.1,0.1,0.1,1};
		};
	};
	class Controls
	{	
		class SAI_GUI_TITLE: RscText
		{
			idc = -1;
			text = "UNIVERSAL SCENARIO GENERATOR";
			x = GUI_GRID_CENTER_X + 0 * GUI_GRID_CENTER_W;
			y = GUI_GRID_CENTER_Y + 0 * GUI_GRID_CENTER_H;
			w = 20 * GUI_GRID_CENTER_W;
			h = 2 * GUI_GRID_CENTER_H;
		};
		
		class SAI_GUI_VERSION: RscText
		{
			idc = -1;
			text = "VERSION 1";
			x = GUI_GRID_CENTER_X + 20 * GUI_GRID_CENTER_W;
			y = GUI_GRID_CENTER_Y + 0 * GUI_GRID_CENTER_H;
			w = 10 * GUI_GRID_CENTER_W;
			h = 2 * GUI_GRID_CENTER_H;
		};
		
		class SAI_GUI_CREDITS: RscText
		{
			idc = -1;
			text = "MADE BY KOSMOKAINEN";
			x = GUI_GRID_CENTER_X + 30 * GUI_GRID_CENTER_W;
			y = GUI_GRID_CENTER_Y + 0 * GUI_GRID_CENTER_H;
			w = 10 * GUI_GRID_CENTER_W;
			h = 2 * GUI_GRID_CENTER_H;
		};
		
		class SAI_GUI_SET_WEST_TEXT: RscText
		{
			idc = -1;
			text = "SELECT PLAYER FACTION";
			x = GUI_GRID_CENTER_X + 0 * GUI_GRID_CENTER_W;
			y = GUI_GRID_CENTER_Y + 2 * GUI_GRID_CENTER_H;
			w = 30 * GUI_GRID_CENTER_W;
			h = 2 * GUI_GRID_CENTER_H;
			colorBackground[] = {0,1,1,0.1};
		};

		class SAI_GUI_SET_WEST : RscCombo
		{
			idc = 1001;
			x = GUI_GRID_CENTER_X + 0 * GUI_GRID_CENTER_W;
			y = GUI_GRID_CENTER_Y + 4 * GUI_GRID_CENTER_H;
			w = 30 * GUI_GRID_CENTER_W;
			h = 2 * GUI_GRID_CENTER_H;
			tooltip = "Select faction to spawn on player side.";
			onLBSelChanged = "_select = (_this select 1); [_select] call SAI_FNC_SET_WEST;";
		};

		class SAI_GUI_COM_WEST_TEXT: RscText
		{
			idc = -1;
			text = "FACTION COMPOSITION";
			x = GUI_GRID_CENTER_X + 30 * GUI_GRID_CENTER_W;
			y = GUI_GRID_CENTER_Y + 2 * GUI_GRID_CENTER_H;
			w = 10 * GUI_GRID_CENTER_W;
			h = 2 * GUI_GRID_CENTER_H;
			colorBackground[] = {0,1,1,0.1};
		};

		class SAI_GUI_COM_WEST : RscCombo
		{
			idc = 1002;
			x = GUI_GRID_CENTER_X + 30 * GUI_GRID_CENTER_W;
			y = GUI_GRID_CENTER_Y + 4 * GUI_GRID_CENTER_H;
			w = 10 * GUI_GRID_CENTER_W;
			h = 2 * GUI_GRID_CENTER_H;
			tooltip = "Select player side vehicles. Select CUSTOM to manually configure.";
			onLBSelChanged = "_select = (_this select 1); [_select] call SAI_FNC_COM_WEST;";
		};

		class SAI_GUI_SET_EAST_TEXT: RscText
		{
			idc = -1;
			text = "SELECT ENEMY FACTION";
			x = GUI_GRID_CENTER_X + 0 * GUI_GRID_CENTER_W;
			y = GUI_GRID_CENTER_Y + 8 * GUI_GRID_CENTER_H;
			w = 30 * GUI_GRID_CENTER_W;
			h = 2 * GUI_GRID_CENTER_H;
			colorBackground[] = {1,1,0,0.1};
		};

		class SAI_GUI_SET_EAST : RscCombo
		{
			idc = 1003;
			x = GUI_GRID_CENTER_X + 0 * GUI_GRID_CENTER_W;
			y = GUI_GRID_CENTER_Y + 10 * GUI_GRID_CENTER_H;
			w = 30 * GUI_GRID_CENTER_W;
			h = 2 * GUI_GRID_CENTER_H;
			tooltip = "Select faction to spawn on enemy side.";
			onLBSelChanged = "_select = (_this select 1); [_select] call SAI_FNC_SET_EAST;";
		};
		
		class SAI_GUI_COM_EAST_TEXT: RscText
		{
			idc = -1;
			text = "FACTION COMPOSITION";
			x = GUI_GRID_CENTER_X + 30 * GUI_GRID_CENTER_W;
			y = GUI_GRID_CENTER_Y + 8 * GUI_GRID_CENTER_H;
			w = 10 * GUI_GRID_CENTER_W;
			h = 2 * GUI_GRID_CENTER_H;
			colorBackground[] = {1,1,0,0.1};
		};

		class SAI_GUI_COM_EAST : RscCombo
		{
			idc = 1004;
			x = GUI_GRID_CENTER_X + 30 * GUI_GRID_CENTER_W;
			y = GUI_GRID_CENTER_Y + 10 * GUI_GRID_CENTER_H;
			w = 10 * GUI_GRID_CENTER_W;
			h = 2 * GUI_GRID_CENTER_H;
			tooltip = "Select enemy side vehicles. Select CUSTOM to manually configure.";
			onLBSelChanged = "_select = (_this select 1); [_select] call SAI_FNC_COM_EAST;";
		};

		class SAI_GUI_TIME_TEXT : RscText
		{
			idc = -1;
			text = "TIME";
			x = GUI_GRID_CENTER_X + 0 * GUI_GRID_CENTER_W;
			y = GUI_GRID_CENTER_Y + 14 * GUI_GRID_CENTER_H;
			w = 10 * GUI_GRID_CENTER_W;
			h = 2 * GUI_GRID_CENTER_H;
		};	

		class SAI_GUI_TIME : RscCombo
		{
			idc = 1011;
			x = GUI_GRID_CENTER_X + 10 * GUI_GRID_CENTER_W;
			y = GUI_GRID_CENTER_Y + 14 * GUI_GRID_CENTER_H;
			w = 10 * GUI_GRID_CENTER_W;
			h = 2 * GUI_GRID_CENTER_H;
			tooltip = "Set world time.";
			onLBSelChanged = "_select = (_this select 1); [_select] call SAI_FNC_SET_TIME;";
		};	
		
		class SAI_GUI_WEATHER_TEXT : RscText
		{
			idc = -1;
			text = "WEATHER";
			x = GUI_GRID_CENTER_X + 0 * GUI_GRID_CENTER_W;
			y = GUI_GRID_CENTER_Y + 16 * GUI_GRID_CENTER_H;
			w = 10 * GUI_GRID_CENTER_W;
			h = 2 * GUI_GRID_CENTER_H;
		};			
		
		class SAI_GUI_WEATHER : RscCombo
		{
			idc = 1012;
			x = GUI_GRID_CENTER_X + 10 * GUI_GRID_CENTER_W;
			y = GUI_GRID_CENTER_Y + 16 * GUI_GRID_CENTER_H;
			w = 10 * GUI_GRID_CENTER_W;
			h = 2 * GUI_GRID_CENTER_H;
			tooltip = "Set world weather.";
			onLBSelChanged = "_select = (_this select 1); [_select] call SAI_FNC_SET_WEATHER;";
		};	
		
		class SAI_GUI_SCALE_TEXT : RscText
		{
			idc = -1;
			text = "SCALE";
			x = GUI_GRID_CENTER_X + 0 * GUI_GRID_CENTER_W;
			y = GUI_GRID_CENTER_Y + 18 * GUI_GRID_CENTER_H;
			w = 10 * GUI_GRID_CENTER_W;
			h = 2 * GUI_GRID_CENTER_H;
		};			
		
		class SAI_GUI_SCALE : RscCombo
		{
			idc = 1013;
			x = GUI_GRID_CENTER_X + 10 * GUI_GRID_CENTER_W;
			y = GUI_GRID_CENTER_Y + 18 * GUI_GRID_CENTER_H;
			w = 10 * GUI_GRID_CENTER_W;
			h = 2 * GUI_GRID_CENTER_H;
			tooltip = "Set scale of mission.";
			onLBSelChanged = "_select = (_this select 1); [_select] call SAI_FNC_SET_SCALE;";
		};	

		class SAI_GUI_DIFFICULTY_TEXT : RscText
		{
			idc = -1;
			text = "DIFFICULTY";
			x = GUI_GRID_CENTER_X + 20 * GUI_GRID_CENTER_W;
			y = GUI_GRID_CENTER_Y + 14 * GUI_GRID_CENTER_H;
			w = 10 * GUI_GRID_CENTER_W;
			h = 2 * GUI_GRID_CENTER_H;
		};			
		
		class SAI_GUI_DIFFICULTY : RscCombo
		{
			idc = 1021;
			x = GUI_GRID_CENTER_X + 30 * GUI_GRID_CENTER_W;
			y = GUI_GRID_CENTER_Y + 14 * GUI_GRID_CENTER_H;
			w = 10 * GUI_GRID_CENTER_W;
			h = 2 * GUI_GRID_CENTER_H;
			tooltip = "Select player side to enemy side ratio.";
			onLBSelChanged = "_select = (_this select 1); [_select] call SAI_FNC_SET_DIFFICULTY;";
		};	
	
		class SAI_GUI_ROLE_TEXT : RscText
		{
			idc = -1;
			text = "PLAYER ROLE";
			x = GUI_GRID_CENTER_X + 20 * GUI_GRID_CENTER_W;
			y = GUI_GRID_CENTER_Y + 16 * GUI_GRID_CENTER_H;
			w = 10 * GUI_GRID_CENTER_W;
			h = 2 * GUI_GRID_CENTER_H;
		};			
		
		class SAI_GUI_ROLE : RscCombo
		{
			idc = 1022;
			x = GUI_GRID_CENTER_X + 30 * GUI_GRID_CENTER_W;
			y = GUI_GRID_CENTER_Y + 16 * GUI_GRID_CENTER_H;
			w = 10 * GUI_GRID_CENTER_W;
			h = 2 * GUI_GRID_CENTER_H;
			tooltip = "Select player role for mission.";
			onLBSelChanged = "_select = (_this select 1); [_select] call SAI_FNC_SET_ROLE;";
		};		
	
///		class SAI_GUI_TEXT_RESET: RscText
///		{
///			idc = -1;
///			text = "RESET SAVE";
///			x = GUI_GRID_CENTER_X + 20 * GUI_GRID_CENTER_W;
///			y = GUI_GRID_CENTER_Y + 18 * GUI_GRID_CENTER_H;
///			w = 10 * GUI_GRID_CENTER_W;
///			h = 2 * GUI_GRID_CENTER_H;
///		};	
	
///		class SAI_GUI_RESET : RscCheckBox
///			{
///			idc = 1023;
///			x = GUI_GRID_CENTER_X + 26 * GUI_GRID_CENTER_W;
///			y = GUI_GRID_CENTER_Y + 18 * GUI_GRID_CENTER_H;
///			w = 2 * GUI_GRID_CENTER_W;
///			h = 2 * GUI_GRID_CENTER_H;
///			tooltip = "Checking this will reset map save.";
///		};

		class SAI_GUI_TEXT_PLAY: RscText
		{
			idc = -1;
			text = "START MISSION";
			x = GUI_GRID_CENTER_X + 30 * GUI_GRID_CENTER_W;
			y = GUI_GRID_CENTER_Y + 18 * GUI_GRID_CENTER_H;
			w = 10 * GUI_GRID_CENTER_W;
			h = 2 * GUI_GRID_CENTER_H;
		};	
		
		class SAI_GUI_PLAY : RscButtonMenu
		{
			idc = 1024;
			text = "";
			x = GUI_GRID_CENTER_X + 30 * GUI_GRID_CENTER_W;
			y = GUI_GRID_CENTER_Y + 18 * GUI_GRID_CENTER_H;
			w = 10 * GUI_GRID_CENTER_W;
			h = 2 * GUI_GRID_CENTER_H;
			colorBackground[] = {0,1,0.5,0.1};
			onButtonClick = "closeDialog 0; if (SAI_CFG_WEST_COM != 5 && SAI_CFG_EAST_COM != 5) then {execVM 'SAI.sqf'} else {call compile preprocessFile 'UI\Vehicles.sqf';}";
		};
	};
};