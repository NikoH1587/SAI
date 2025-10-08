/// THESE ARE DEFAULT SETTINGS
/// FOR DEDICATED SERVER CHANGE THE uRTS_CFG ARRAY HERE
uRTS_PLAYERS = count (call BIS_fnc_listPlayers);
uRTS_READY = 0;

uRTS_CFG = 
[
["Title","Author",["Description"]],
[0,0,0,[0, 0],[[1, 1],[1, 1]],{}],
[
[1,"inf","Rifle Squad",["B_soldier_SL_F","B_soldier_F","B_soldier_LAT_F","B_soldier_M_F","B_soldier_TL_F","B_soldier_AR_F","B_soldier_A_F","B_medic_F"]],
[1,"recon","Recon Team",["B_recon_TL_F","B_recon_M_F","B_recon_medic_F","B_recon_LAT_F","B_recon_JTAC_F","B_recon_exp_F"]],
[3,"motor_inf","Motorized Team",["B_soldier_AR_F","B_soldier_LAT_F","B_MRAP_01_gmg_F"]],
[4,"mech_inf","Mechanized Rifle Squad",["B_soldier_SL_F","B_soldier_F","B_soldier_LAT_F","B_soldier_M_F","B_soldier_TL_F","B_soldier_AR_F","B_soldier_A_F","B_medic_F","B_APC_Wheeled_01_cannon_F"]],
[5,"mech_inf","Mechanized Anti-armor Squad",["B_soldier_SL_F","B_soldier_AR_F","B_soldier_AT_F","B_soldier_AT_F","B_soldier_AT_F","B_soldier_AAT_F","B_soldier_AAT_F","B_soldier_AAT_F","B_APC_Tracked_01_rcws_F"]],
[5,"armor","M2A4 Slammer UP",["B_MBT_01_TUSK_F"]],
[7,"art","M4 Scorcher",["B_MBT_01_arty_F"]],
[6,"air","AH-99 Blackfoot",["B_Heli_Attack_01_dynamicLoadout_F"]],
[7,"plane","A-164 Wipeout (CAS)",["B_Plane_CAS_01_dynamicLoadout_F"]]
],
[
[1,"inf","Rifle Squad",["O_soldier_SL_F","O_soldier_F","O_soldier_LAT_F","O_soldier_M_F","O_soldier_TL_F","O_soldier_AR_F","O_soldier_A_F","O_medic_F"]],
[1,"recon","Recon Team",["O_recon_TL_F","O_recon_M_F","O_recon_medic_F","O_recon_LAT_F","O_recon_JTAC_F","O_recon_exp_F"]],
[3,"motor_inf","Motorized Team",["O_soldier_AR_F","O_soldier_AT_F","O_MRAP_02_GMG_F"]],
[4,"mech_inf","Mechanized Rifle Squad",["O_soldier_SL_F","O_soldier_F","O_soldier_LAT_F","O_soldier_M_F","O_soldier_TL_F","O_soldier_AR_F","O_soldier_A_F","O_medic_F","O_APC_Wheeled_02_rcws_v2_F"]],
[5,"mech_inf","Mechanized Anti-armor Squad",["O_soldier_SL_F","O_soldier_AR_F","O_soldier_AT_F","O_soldier_AT_F","O_soldier_AT_F","O_soldier_AAT_F","O_soldier_AAT_F","O_soldier_AAT_F","O_APC_Tracked_02_cannon_F"]],
[5,"armor","T-100 Varsuk",["O_MBT_02_cannon_F"]],
[5,"art","2S9 Sochor",["O_MBT_02_arty_F"]],
[6,"air","Mi-48 Kajman",["O_Heli_Attack_02_dynamicLoadout_F"]],
[7,"plane","To-199 Neophron (CAS)",["O_Plane_CAS_02_dynamicLoadout_F"]]
]
];

uRTS_CFG_IMPORT = false;

uRTS_CFG_FACTIONS = [];

uRTS_CFG_RECG = [];
uRTS_CFG_INFG = [];
uRTS_CFG_STAT = [];
uRTS_CFG_CARS = [];
uRTS_CFG_SUPS = [];
uRTS_CFG_MOTG = [];
uRTS_CFG_MECG = [];
uRTS_CFG_AUTO = [];
uRTS_CFG_HELO = [];
uRTS_CFG_TANK = [];
uRTS_CFG_ARTY = [];
uRTS_CFG_AERO = [];

uRTS_CFG_ALL = [uRTS_CFG_RECG, uRTS_CFG_INFG, uRTS_CFG_STAT, uRTS_CFG_CARS, uRTS_CFG_SUPS, uRTS_CFG_MOTG, uRTS_CFG_MECG, uRTS_CFG_AUTO, uRTS_CFG_TANK, uRTS_CFG_ARTY, uRTS_CFG_HELO, uRTS_CFG_AERO];

private _cfgVehicles = configFile >> "CfgVehicles";

for "_i" from 0 to ((count _cfgVehicles) - 1) do {
	private _entry = _cfgVehicles select _i;
	if (isClass _entry) then {
		private _scope = getNumber (_entry >> "scope");
		private _side = getNumber (_entry >> "side");
		private _config = configName _entry;
		private _name = getText (_entry >> "displayName");
		private _faction = getText (_entry >> "faction");
		_faction = getText (configfile >> "CfgFactionClasses" >> _faction >> "displayName");
		
		if (_scope > 1 && _side in [0, 1, 2]) then {
			private _med = getNumber (_entry >> "attendant");
			private _eng = getNumber (_entry >> "engineer");
			private _amo = getNumber (_entry >> "transportAmmo");
			private _plo = getNumber (_entry >> "transportFuel");
			private _rep = getNumber (_entry >> "transportRepair");
			private _sup = _med + _eng + _amo + _plo + _rep;
			private _drv = getNumber (_entry >> "hasDriver");
			private _art = getNumber (_entry >> "artilleryScanner");
			private _sim = toLower getText (_entry >> "simulation");
			private _cls = getText (_entry >> "vehicleClass");
			private _arm = (getNumber (_entry >> "armor")) / 100;
			if (_sup == 0 && _drv == 1 && _art == 0 && _cls != "Autonomous") then {
				if (_sim == "carx") then {uRTS_CFG_CARS append [[_faction, "unknown", _name, [_config], (2 max _arm) min 4]]};
				if (_sim == "helicopterrtd") then {uRTS_CFG_HELO append [[_faction, "air", _name, [_config], 6]]};
				if (_sim == "tankx") then {uRTS_CFG_TANK append [[_faction, "armor", _name, [_config], (5 min _arm) max 3]]};
				if (_sim == "airplanex" or _sim == "airplane") then {uRTS_CFG_AERO append [[_faction, "plane", _name, [_config], 7]]};
			};
			
			if (_sup > 0 && _sim != "soldier") then {
				uRTS_CFG_SUPS append [[_faction, "support", _name, [_config], 5 + (_amo min 1) + (_rep min 1)]];
			};
			
			if (_cls == "Autonomous" && _art == 0 && _sup == 0 && _sim != "tankx") then {
				private _uav = 4;
				if (_sim == "helicopterrtd") then {_uav = 5};
				if (_sim == "airplanex") then {_uav = 6};
				uRTS_CFG_AUTO append [[_faction, "uav", _name, [_config], _uav]];
			};
			
			if (_drv == 0 && _cls != "Autonomous" && _art == 0) then {
				uRTS_CFG_STAT append [[_faction, "installation", _name, [_config], 2]];
			};
			
			if (_art == 1) then {
				uRTS_CFG_ARTY append [[_faction, "art", _name, [_config], 5 + _drv + round (_arm min 1)]];
			};
		}
	}
};

private _recICON = ["\A3\ui_f\data\map\markers\nato\b_recon.paa", "\A3\ui_f\data\map\markers\nato\n_recon.paa", "\A3\ui_f\data\map\markers\nato\o_recon.paa"];
private _infICON = ["\A3\ui_f\data\map\markers\nato\b_inf.paa","\A3\ui_f\data\map\markers\nato\n_inf.paa","\A3\ui_f\data\map\markers\nato\o_inf.paa"];
private _motICON = ["\A3\ui_f\data\map\markers\nato\b_motor_inf.paa", "\A3\ui_f\data\map\markers\nato\n_motor_inf.paa", "\A3\ui_f\data\map\markers\nato\o_motor_inf.paa"];
private _mecICON = ["\A3\ui_f\data\map\markers\nato\b_mech_inf.paa", "\A3\ui_f\data\map\markers\nato\n_mech_inf.paa", "\A3\ui_f\data\map\markers\nato\o_mech_inf.paa", "\gm\gm_core\gm_core_ui\data\markers\gm_marker_antiarmor_ca.paa"];

{
	private _side = _x;
	private _sidename = getText (_side >> "name");
	private _factions = "true" configClasses _side;
	{
		private _fac = _x;
		private _categories = "true" configClasses _fac;
		{
			private _cat = _x;
			private _catname = getText (_cat >> "name");
			private _groups = "true" configClasses _cat;
			{
				private _group = _x;
				private _name = getText (_group >> "name");				
				private _icon = getText (_group >> "icon");
				private _faction = getText (_group >> "faction");
				_faction = getText (configfile >> "CfgFactionClasses" >> _faction >> "displayName");	
			
				private _vehicles = [];
				private _units = "true" configClasses _group;
				
				{
					private _unit = _x;
					private _vehicle = getText (_unit >> "vehicle");
					_vehicles append [_vehicle];
				}forEach _units;
				
				if (_faction in uRTS_CFG_FACTIONS == false) then {uRTS_CFG_FACTIONS append [_faction]};

				private _arm = 0;
				private _vehs = 0;
				private _men = 0;
				private _at = 0;
				private _inc = true;
				
				private _ban = 
				["B_support_GMG_F", "B_support_MG_F", "B_support_Mort_F",
				"B_T_Support_GMG_F", "B_T_Support_MG_F", "B_T_Support_Mort_F",
				"B_W_Support_GMG_F", "B_W_Support_MG_F", "B_W_Support_Mort_F",
				"O_support_GMG_F", "O_support_MG_F", "O_support_Mort_F", 
				"O_T_Support_GMG_F", "O_T_Support_MG_F", "O_T_Support_Mort_F",
				"I_support_GMG_F", "I_support_MG_F", "I_support_Mort_F",
				"I_E_Support_GMG_F", "I_E_Support_MG_F", "I_E_Support_Mort_F"];
				{
					private _a = (getNumber (configFile >> "CfgVehicles" >> _x >> "armor")) / 100;
					private _man = getNumber (configFile >> "CfgVehicles" >> _x >> "isMan");
					private _icon = getText (configfile >> "CfgVehicles" >> _x >> "icon");
					if (_icon == "iconManAT") then {_at = _at + 1};
					if (_a > _arm) then {_arm = _a};
					if (_man == 0) then {
						_vehicles = _vehicles - [_x];
						_vehicles append [_x];
						_vehs = _vehs + 1;
					} else {
						_men = _men + 1;
					};
					
					if (_x in _ban) then {_inc = false};
					
				}forEach _vehicles;
				
				if (_men > 6 && _at == 0) then {_at = 1};
				private _big = 0;
				if (_men > 10) then {_big = 1};
				
				if (_icon in _recICON && _inc && _vehs < 2 && _catName != "Support Infantry" && _catName != "Special Forces") then {uRTS_CFG_RECG append [[_faction,"recon", _name, _vehicles, (0.5 max _at) min 2]]};
				if (_icon in _infICON && _inc && _vehs < 2 && _catName != "Support Infantry" && _catName != "Special Forces") then {uRTS_CFG_INFG append [[_faction,"inf", _name, _vehicles, (0.5 max _at) min 2]]};
				if (_icon in _motICON && _inc && _vehs < 3) then {uRTS_CFG_MOTG append [[_faction,"motor_inf", _name, _vehicles, ((3 max _arm) min 4) + _big]]};
				if (_icon in _mecICON && _inc && _vehs == 1) then {uRTS_CFG_MECG append [[_faction,"mech_inf", _name, _vehicles, (4 max _arm) min 5]]};
			}forEach _groups;
		}forEach _categories;
	}forEach _factions;
}forEach [(configFile >> "CfgGroups" >> "West"), (configFile >> "CfgGroups" >> "East"), (configFile >> "CfgGroups" >> "Indep")];