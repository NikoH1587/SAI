SAI_CFG_DATE = date;
SAI_CFG_CAST = random 1;
SAI_CFG_TIME = random [0, 11.5, 23];
SAI_CFG_SCALE = ceil random 2;
SAI_CFG_SCENARIO = ceil random 3;
SAI_CFG_DIFFICULTY = ceil random 3;
SAI_CFG_ROLE = 1;
SAI_CFG_SPAWNS_WEST = 5 * SAI_CFG_SCALE;
SAI_CFG_SPAWNS_EAST = 5 * SAI_CFG_SCALE;
SAI_CFG_RESPAWNS_WEST = 5 * SAI_CFG_SCALE;
SAI_CFG_RESPAWNS_EAST = 5 * SAI_CFG_SCALE;

SAI_CFG_WEST_REC = [["West" , "Guerilla" , "Infantry" , "IRG_InfSquad_Weapons"],["West" , "Guerilla" , "Motorized_MTP" , "IRG_Technicals"]];
SAI_CFG_WEST_INF = [["West" , "BLU_F" , "Infantry" , "BUS_InfSquad"],["West" , "BLU_F" , "Infantry" , "BUS_InfSquad_Weapons"]];
SAI_CFG_WEST_MOT = [["West" , "BLU_F" , "Motorized" , "BUS_MotInf_Team"], ["West" , "BLU_F" , "Mechanized" , "BUS_MechInfSquad"]];
SAI_CFG_WEST_MEC = [["West" , "BLU_F" , "Mechanized" , "BUS_MechInfSquad"], ["West" , "BLU_F" , "Mechanized" , "BUS_MechInf_AT"],["West" , "BLU_F" , "Armored" , "BUS_TankSection"]];
SAI_CFG_WEST_GRP = [SAI_CFG_WEST_REC, SAI_CFG_WEST_INF,SAI_CFG_WEST_MOT,SAI_CFG_WEST_MEC];

SAI_CFG_WEST_MHQ = ["B_MRAP_01_F"];
SAI_CFG_WEST_STA = ["B_static_AT_F", "B_HMG_01_high_F"];
SAI_CFG_WEST_BNK = ["Land_BagBunker_Large_F","Land_BagBunker_Small_F","Land_BagBunker_Tower_F"];

SAI_CFG_WEST_AIR = ["B_Heli_Attack_01_pylons_dynamicLoadout_F", "B_Plane_CAS_01_dynamicLoadout_F"];
SAI_CFG_WEST_ART = ["B_MBT_01_arty_F", "B_Mortar_01_F"];
SAI_CFG_WEST_SUP = ["B_Truck_01_ammo_F", "B_Truck_01_Repair_F"];
SAI_CFG_WEST_LOG = ["B_Truck_01_covered_F", "B_Heli_Light_01_F"];

///SAI_CFG_WEST_INF = [];
///SAI_CFG_WEST_MOT = [];

SAI_CFG_EAST_REC = [["East" , "OPF_F" , "Infantry" , "OIA_ReconSquad"],["East" , "OPF_F" , "Motorized_MTP" , "O_MotInf_AssaultViperTeam"]];
SAI_CFG_EAST_INF = [["East" , "OPF_F" , "Infantry" , "OIA_InfSquad"],["East" , "OPF_F" , "UInfantry" , "OIA_GuardSquad"]];
SAI_CFG_EAST_MOT = [["East" , "OPF_F" , "Mechanized" , "OIA_MechInfSquad"],["East" , "OPF_F" , "Motorized_MTP" , "OIA_MotInf_Team"]];
SAI_CFG_EAST_MEC = [["East" , "OPF_F" , "Mechanized" , "OIA_MechInfSquad"], ["East" , "OPF_F" , "Mechanized" , "OIA_MechInf_AT"],["East" , "OPF_F" , "Armored" , "OIA_TankSection"]];
SAI_CFG_EAST_GRP = [SAI_CFG_EAST_REC, SAI_CFG_EAST_INF,SAI_CFG_EAST_MOT,SAI_CFG_EAST_MEC];

SAI_CFG_EAST_MHQ = ["O_MRAP_02_F"];
SAI_CFG_EAST_STA = ["O_HMG_01_high_F", "O_static_AT_F"];
SAI_CFG_EAST_BNK = ["Land_BagBunker_Large_F","Land_BagBunker_Small_F","Land_BagBunker_Tower_F"];

SAI_CFG_EAST_AIR = ["O_Heli_Attack_02_dynamicLoadout_F", "O_Plane_CAS_02_dynamicLoadout_F"];
SAI_CFG_EAST_ART = ["O_Mortar_01_F", "O_MBT_02_arty_F"];
SAI_CFG_EAST_SUP = ["O_Truck_03_ammo_F", "O_Truck_03_repair_F"];
SAI_CFG_EAST_LOG = ["O_Truck_03_covered_F", "O_Heli_Light_02_unarmed_F"];

_distance = 500;
if (SAI_CFG_SCALE == 1 && SAI_CFG_SCENARIO == 1) then {_distance = 250};
if (SAI_CFG_SCALE == 2 && SAI_CFG_SCENARIO == 1) then {_distance = 500};
if (SAI_CFG_SCALE == 1 && SAI_CFG_SCENARIO != 1) then {_distance = 500};
if (SAI_CFG_SCALE == 2 && SAI_CFG_SCENARIO != 1) then {_distance = 1000};

private _positions = [];
private _rando = [] call BIS_fnc_randomPos;
private _loc = nearestLocation [_rando, ["NameCityCapital", "NameCity", "NameVillage", "NameLocal"]];
private _name = text _loc;
private _locations = nearestLocations [position _loc, [], worldSize];

{
	private _pos = position _x;
	if ((surfaceIsWater _pos == false) && count _positions < 3) then {
		private _close = false;
		{
			if (_pos distance _x < _distance*3) then {
				_close = true;
			}
		}forEach _positions;
		
		if (_close == false) then {
			_positions append [_pos];
		}
	}
}forEach _locations;

_names = ["Alpha", "Bravo", "Charlie", "Delta", "Echo"];

if (_name == "") then {
	_name = _names select floor random count _names;
};

SAI_CFG_TITLE = "";
SAI_CFG_DESCRIPTION = "";

if (SAI_CFG_SCALE == 1) then {
	SAI_CFG_TITLE = "Skirmish in " + _name;
};

if (SAI_CFG_SCALE == 2) then {
	SAI_CFG_TITLE = "Battle of " + _name;
};

if (SAI_CFG_SCENARIO == 1) then {
	SAI_CFG_DESCRIPTION = "Gambit";
};

if (SAI_CFG_SCENARIO == 2) then {
	SAI_CFG_DESCRIPTION = "Attack";
};

if (SAI_CFG_SCENARIO == 3) then {
	SAI_CFG_DESCRIPTION = "Defence";
};

if (SAI_CFG_DIFFICULTY == 1) then {
	SAI_CFG_DESCRIPTION = SAI_CFG_DESCRIPTION + " \nEasy";
	SAI_CFG_SPAWNS_WEST = SAI_CFG_SPAWNS_WEST + (1 * SAI_CFG_SCALE);
	SAI_CFG_SPAWNS_EAST = SAI_CFG_SPAWNS_EAST - (1 * SAI_CFG_SCALE);
	SAI_CFG_RESPAWNS_WEST = SAI_CFG_RESPAWNS_WEST + (1 * SAI_CFG_SCALE);
	SAI_CFG_RESPAWNS_EAST = SAI_CFG_RESPAWNS_EAST - (1 * SAI_CFG_SCALE);
};

if (SAI_CFG_DIFFICULTY == 2) then {
	SAI_CFG_DESCRIPTION = SAI_CFG_DESCRIPTION + " \nNormal";
};

if (SAI_CFG_DIFFICULTY == 3) then {
	SAI_CFG_DESCRIPTION = SAI_CFG_DESCRIPTION + " \nHard";
	SAI_CFG_SPAWNS_WEST = SAI_CFG_SPAWNS_WEST - (1 * SAI_CFG_SCALE);
	SAI_CFG_SPAWNS_EAST = SAI_CFG_SPAWNS_EAST + (1 * SAI_CFG_SCALE);
	SAI_CFG_RESPAWNS_WEST = SAI_CFG_RESPAWNS_WEST - (1 * SAI_CFG_SCALE);
	SAI_CFG_RESPAWNS_EAST = SAI_CFG_RESPAWNS_EAST + (1 * SAI_CFG_SCALE);
};

/// Conditions stuff
0 setOverCast SAI_CFG_CAST;
forceWeatherChange;
private _date = [SAI_CFG_DATE select 0, SAI_CFG_DATE  select 1, SAI_CFG_DATE  select 2, SAI_CFG_TIME, SAI_CFG_DATE select 4];
setDate _date;
skipTime 0;

SAI_CFG_DESCRIPTION = SAI_CFG_DESCRIPTION + (" \n" + ([dayTime] call BIS_fnc_timeToString));

if (SAI_CFG_CAST < 0.33) then {SAI_CFG_DESCRIPTION = SAI_CFG_DESCRIPTION + (" \n" + "Clear");};
if (SAI_CFG_CAST > 0.66) then {SAI_CFG_DESCRIPTION = SAI_CFG_DESCRIPTION + (" \n" + "Storm");};
if (SAI_CFG_CAST < 0.33 == false && SAI_CFG_CAST > 0.66 == false) then {SAI_CFG_DESCRIPTION = SAI_CFG_DESCRIPTION + (" \n" + "Cloudy");};

private _cent = createMarker ["SAI_CENT", _positions select 0];
private _west = createMarker ["SAI_WEST", _positions select 1];
private _east = createMarker ["SAI_EAST", _positions select 2];

if (SAI_CFG_SCENARIO == 2) then {_cent setMarkerPos (_positions select 1); _east setMarkerPos (_positions select 0)};
if (SAI_CFG_SCENARIO == 3) then {_cent setMarkerPos (_positions select 2); _west setMarkerPos (_positions select 0)};