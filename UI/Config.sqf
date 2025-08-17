SAI_CFG_FACTIONS = [];
SAI_CFG_FACNAMES = [];
SAI_CFG_CFGVEHICLES = [];
SAI_CFG_CFGVEHNAMES = [];
SAI_CFG_DATE = date;
SAI_CFG_CAST = random 1;
SAI_CFG_TIME = random [0, 11.5, 23];

SAI_CFG_SCENARIO = ceil random 3;
SAI_CFG_SCALE = ceil random 2;
SAI_CFG_TITLE = "";
SAI_CFG_DESCRIPTION = "";
SAI_DISTANCE = 500 * SAI_CFG_SCALE;
SAI_CFG_ROLE = 1;
SAI_CFG_SPAWNS_WEST = 10*SAI_CFG_SCALE;
SAI_CFG_SPAWNS_EAST = 10*SAI_CFG_SCALE;
SAI_CFG_RESPAWNS_WEST = 10*SAI_CFG_SCALE;
SAI_CFG_RESPAWNS_EAST = 10*SAI_CFG_SCALE;

private _positions = [];
private _rando = [] call BIS_fnc_randomPos;
private _loc = nearestLocation [_rando, ["NameCityCapital", "NameCity", "NameVillage", "NameLocal"]];
private _name = text _loc;
private _locations = nearestLocations [position _loc, [], worldSize];

{
	private _pos = position _x;
	if ((surfaceIsWater _pos == false) && count _positions < 3) then {
		private _distance = false;
		{
			if (_pos distance _x < SAI_DISTANCE*3) then {
				_distance = true;
			}
		}forEach _positions;
		
		if (_distance == false) then {
			_positions append [_pos];
		}
	}
}forEach _locations;

_names = ["Alpha", "Bravo", "Charlie", "Delta", "Echo"];

if (_name == "") then {
	_name = _names select floor random count _names;
};

if (SAI_CFG_SCALE == 1) then {
	SAI_CFG_TITLE = "Skirmish in " + _name;
	SAI_CFG_DESCRIPTION = " Description1 \n Description2 \n Description3";
};
if (SAI_CFG_SCALE == 2) then {
	SAI_CFG_TITLE = "Battle of " + _name;
	SAI_CFG_DESCRIPTION = " Description1 \n Description2 \n Description3";
};

private _cent = createMarker ["SAI_CENT", _positions select 0];
_cent setMarkerShape "ELLIPSE";
_cent setMarkerSize [SAI_DISTANCE, SAI_DISTANCE];
_cent setmarkerBrush "Border";
private _west = createMarker ["SAI_WEST", _positions select 1];
_west setMarkerShape "ELLIPSE";
_west setMarkerSize [SAI_DISTANCE, SAI_DISTANCE];
_west setmarkerBrush "Border";
private _east = createMarker ["SAI_EAST", _positions select 2];
_east setMarkerShape "ELLIPSE";
_east setMarkerSize [SAI_DISTANCE, SAI_DISTANCE];
_east setmarkerBrush "Border";

if (SAI_CFG_SCENARIO == 2) then {_cent setMarkerPos (_positions select 1); _east setMarkerPos (_positions select 0)};
if (SAI_CFG_SCENARIO == 3) then {_cent setMarkerPos (_positions select 2); _west setMarkerPos (_positions select 0)};

SAI_CFG_WEST = ["West", "BLU_F", "Infantry", "BLU_F"];
SAI_CFG_WEST_COM = 0;
SAI_CFG_CUSTOM_WEST = [];
SAI_CFG_EAST = ["East", "OPF_F", "Infantry", "OPF_F"];
SAI_CFG_EAST_COM = 0;
SAI_CFG_CUSTOM_EAST = [];

_cfg = configFile >> "CfgGroups";

for "_i" from 0 to (count (configFile >> "CfgVehicles")) do {
	_entry = (configFile >> "CfgVehicles") select _i;
	if (isClass _entry) then {
		_scope = getNumber (_entry >> "scope");
		if (_scope == 2) then {
			_sim = getText (_entry >> "simulation");
			_fac = getText (_entry >> "faction");
			_side = getNumber (_entry >> "side");
			_conf = configname _entry;
			_name = getText (_entry >> "displayName");
			
			if (_sim in ["carx", "tankx", "helicopterrtd", "airplanex"] && _side in [0, 1, 2]) then {SAI_CFG_CFGVEHICLES append [_conf]; SAI_CFG_CFGVEHNAMES append [_name + " - " + _conf]};
		}
	}
};

for "_s" from 0 to count _cfg - 1 do {
	_side = _cfg select _s;
	if (isClass _side) then {
		for "_f" from 0 to count _side - 1 do {
			_faction = _side select _f;
			if (isClass _faction) then {
				for "_c" from 0 to count _faction - 1 do {
					_category = _faction select _c;
					if (isClass _category) then {
						_isInfantry = true;
						_sidename = configname _side;
						_facname = configname _faction;
						_catname = configname _category;
						_vehfac = "none";
						for "_g" from 0 to count _category - 1 do {
							_group = _category select _g;
							if (isClass _group) then {
								for "_u" from 0 to count _group - 1 do {
									_unit = _group select _u;
									if (isClass _unit) then {
										_vehicle = (_unit >> "vehicle") call BIS_fnc_getCfgData;
										if (isClass (configFile >> "CfgVehicles" >> _vehicle)) then {
											_simulation = (configFile >> "CfgVehicles" >> _vehicle >> "simulation") call BIS_fnc_getCfgData;
											_vehfac = (configFile >> "CfgVehicles" >> _vehicle >> "faction") call BIS_fnc_getCfgData;
											if (_simulation != "soldier") then {_isInfantry = false};
										};
									};
								};
							};
						};
						if (_isInfantry && _catname != "Support") then {
							SAI_CFG_FACTIONS append [[_sidename, _facname, _catname, _vehfac]];
							SAI_CFG_FACNAMES append [getText (configFile >> "CfgGroups" >> _sidename >> "name") + " - " + getText (configFile >> "CfgGroups" >> _sidename >> _facname >> "name") + " - " + getText (configFile >> "CfgGroups" >> _sidename >> _facname >> _catname >> "name") + " - " + _vehfac];
						};
					};
				};
			};
		};
	};
};