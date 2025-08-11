SAI_CFG_SCENARIOS = [
	[
	"ANYMAP", /// map required to show scenario, "ANYMAP" for any map
	"NOKEY", /// key required to show scenario in scenario list. "NOKEY" if not required
	"Title",
	"Description", 
	"Author", 
	[2035, 6, 1, 12, 0], /// date: ["year", "month", "day", "hours", "minutes"]
	0, /// weather: 0-1
	1, /// scale: 1(Skirmish), 2 (Battle), 3 (Campaign)
	0, /// difficulty: -1(Easy), 0(Medium), 1(Hard)
	2, /// player role: 1 (Solider), 2(Leader), 3(Commander)
	[["West", "BLU_F", "Infantry", "BLU_F"],["East", "OPF_F", "Infantry", "OPF_F"]],
	[0,0], /// Faction compositions, 0-5, 5 is custom
	[["B_T_LSV_01_unarmed_F","B_LSV_01_armed_F","B_LSV_01_AT_F"],["O_T_LSV_02_unarmed_F","O_T_LSV_02_armed_F","O_T_LSV_02_AT_F"]], /// cfgVehicles configs, requires previous to be 5
	[[_westMarkers],[_neutMarkers],[_eastMarkers]], /// Objectives: Leave empty if randomly generated
	"NOKEY", /// Key written to playerNameSpace on completion
	{hint "custom script"} /// Custom script to run
	]
];