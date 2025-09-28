/// THESE ARE DEFAULT SETTINGS
/// FOR DEDICATED SERVER CHANGE THE uRTS_CFG ARRAY HERE
uRTS_CFG = 
[
["Title","Author",["Description"]],
[0,0,0,0,0,{}],
[
[1,"Rifle Squad",["B_soldier_SL_F","B_soldier_F","B_soldier_LAT_F","B_soldier_M_F","B_soldier_TL_F","B_soldier_AR_F","B_soldier_A_F","B_medic_F"]],
[3,"Motorized Team",["B_soldier_AR_F","B_soldier_LAT_F","B_MRAP_01_gmg_F"]],
[3,"Motorized Reinforcements",["B_soldier_SL_F","B_soldier_F","B_soldier_LAT_F","B_soldier_M_F","B_soldier_TL_F","B_soldier_AR_F","B_soldier_A_F","B_medic_F","B_soldier_SL_F","B_soldier_F","B_soldier_LAT_F","B_soldier_M_F","B_soldier_TL_F","B_soldier_AR_F","B_soldier_A_F","B_medic_F","B_Truck_01_transport_F"]],
[4,"Mechanized Rifle Squad",["B_soldier_SL_F","B_soldier_F","B_soldier_LAT_F","B_soldier_M_F","B_soldier_TL_F","B_soldier_AR_F","B_soldier_A_F","B_medic_F","B_APC_Wheeled_01_cannon_F"]],
[4,"Mechanized Anti-armor Squad",["B_soldier_SL_F","B_soldier_AR_F","B_soldier_AT_F","B_soldier_AT_F","B_soldier_AT_F","B_soldier_AAT_F","B_soldier_AAT_F","B_soldier_AAT_F","B_APC_Tracked_01_rcws_F"]],
[5,"M2A4 Slammer UP",["B_MBT_01_TUSK_F"]],
[5,"M4 Scorcher",["B_MBT_01_arty_F"]],
[6,"AH-99 Blackfoot",["B_Heli_Attack_01_dynamicLoadout_F"]],
[7,"A-164 Wipeout (CAS)",["B_Plane_CAS_01_dynamicLoadout_F"]]
],
[
[1,"Rifle Squad",["O_soldier_SL_F","O_soldier_F","O_soldier_LAT_F","O_soldier_M_F","O_soldier_TL_F","O_soldier_AR_F","O_soldier_A_F","O_medic_F"]],
[3,"Motorized Team",["O_soldier_AR_F","O_soldier_AT_F","O_MRAP_02_GMG_F"]],
[3,"Motorized Reinforcements",["O_soldier_SL_F","O_soldier_F","O_soldier_LAT_F","O_soldier_M_F","O_soldier_TL_F","O_soldier_AR_F","O_soldier_A_F","O_medic_F","O_soldier_TL_F","O_soldier_AR_F","O_soldier_GL_F","O_soldier_LAT_F","O_Truck_03_transport_F"]],
[4,"Mechanized Rifle Squad",["O_soldier_SL_F","O_soldier_F","O_soldier_LAT_F","O_soldier_M_F","O_soldier_TL_F","O_soldier_AR_F","O_soldier_A_F","O_medic_F","O_APC_Wheeled_02_rcws_v2_F"]],
[4,"Mechanized Anti-armor Squad",["O_soldier_SL_F","O_soldier_AR_F","O_soldier_AT_F","O_soldier_AT_F","O_soldier_AT_F","O_soldier_AAT_F","O_soldier_AAT_F","O_soldier_AAT_F","O_APC_Tracked_02_cannon_F"]],
[5,"T-140 Angara",["O_MBT_04_cannon_F"]],
[5,"2S9 Sochor",["O_MBT_02_arty_F"]],
[6,"Mi-48 Kajman",["O_Heli_Attack_02_dynamicLoadout_F"]],
[7,"To-199 Neophron (CAS)",["O_Plane_CAS_02_dynamicLoadout_F"]]
]
];

uRTS_CFG_IMPORT = false;

uRTS_CFG_FACTIONS = [];

uRTS_CFG_RECG = [];
uRTS_CFG_INFG = [];
uRTS_CFG_CARS = [];

uRTS_CFG_MOTG = [];
uRTS_CFG_MECG = [];
uRTS_CFG_HELO = [];

uRTS_CFG_TANK = [];
uRTS_CFG_ARTY = [];
uRTS_CFG_AERO = [];

uRTS_CFG_ALL = [uRTS_CFG_RECG, uRTS_CFG_INFG, uRTS_CFG_CARS, uRTS_CFG_MOTG, uRTS_CFG_MECG, uRTS_CFG_TANK, uRTS_CFG_ARTY, uRTS_CFG_HELO, uRTS_CFG_AERO];

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
		
		if (_scope > 0 && _side in [0, 1, 2]) then {
			private _med = getNumber (_entry >> "attendant");
			private _eng = getNumber (_entry >> "engineer");
			private _amo = getNumber (_entry >> "transportAmmo");
			private _plo = getNumber (_entry >> "transportFuel");
			private _rep = getNumber (_entry >> "transportRepair");
			private _sup = _med + _eng + _amo + _plo + _rep;
			private _drv = getNumber (_entry >> "hasDriver");			
			private _art = getNumber (_entry >> "artilleryScanner");
			if (_sup == 0 && _drv == 1 && _art == 0) then {
				private _sim = toLower getText (_entry >> "simulation");
				if (_sim == "carx") then {uRTS_CFG_CARS append [[_faction, _name, [_config]]]};
				if (_sim == "helicopterrtd") then {uRTS_CFG_HELO append [[_faction, _name, [_config]]]};
				if (_sim == "tankx") then {uRTS_CFG_TANK append [[_faction, _name, [_config]]]};
				if (_sim == "airplanex" or _sim == "airplane") then {uRTS_CFG_AERO append [[_faction, _name, [_config]]]};
			};
			
			if (_art == 1) then {
				uRTS_CFG_ARTY append [[_faction, _name, [_config]]];
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
				
				/// set vehicle as last in group
				private _lead = _vehicles select 0;
				if (_lead isKindOf "Man" == false) then {
					_vehicles deleteAt 0;
					_vehicles pushBack _lead;
				};
				
				if (_faction in uRTS_CFG_FACTIONS == false) then {uRTS_CFG_FACTIONS append [_faction]};

				if (_icon in _recICON) then {uRTS_CFG_RECG append [[_faction, _name, _vehicles]]};
				if (_icon in _infICON) then {uRTS_CFG_INFG append [[_faction, _name, _vehicles]]};
				if (_icon in _motICON) then {uRTS_CFG_MOTG append [[_faction, _name, _vehicles]]};
				if (_icon in _mecICON) then {uRTS_CFG_MECG append [[_faction, _name, _vehicles]]};
			}forEach _groups;
		}forEach _categories;
	}forEach _factions;
}forEach [(configFile >> "CfgGroups" >> "West"), (configFile >> "CfgGroups" >> "East"), (configFile >> "CfgGroups" >> "Indep")];