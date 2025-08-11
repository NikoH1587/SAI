SAI_CFG_FACTIONS = [];
SAI_CFG_FACNAMES = [];
SAI_CFG_CFGVEHICLES = [];
SAI_CFG_CFGVEHNAMES = [];
SAI_CFG_DATE = date;
SAI_CFG_CAST = random 1;
SAI_CFG_TIME = random [0, 11.5, 23];

SAI_CFG_SCENARIO = floor random 3;
SAI_CFG_SCALE = ceil random 3;

SAI_CFG_RATIO = 0;
SAI_CFG_ROLE = 1;

private _world = worldSize;
private _positions = [];
private _rando = [] call BIS_fnc_randomPos;
private _locations = nearestLocations [ _rando, ["NameCityCapital", "NameCity", "NameVillage", "NameLocal", "Hill"], _world/4];

{
	private _pos = position _x;
	if ((surfaceIsWater _pos == false) && count _positions < (3 * SAI_CFG_SCALE)) then {
		private _distance = false;
		{
			if (_pos distance _x < 1000) then {
				_distance = true;
			}
		}forEach _positions;
		
		if (_distance == false) then {
			_positions append [_pos];
		}
	}
}forEach _locations;

SAI_CFG_OBJECTIVES = _positions;

{
	private _mrk = createMarker ["SAI_OBJ_" + str _forEachIndex, _x];
	_mrk setMarkerType "mil_flag";
	if (_forEachIndex == 0) then {_mrk setMarkerColor "ColorWEST"};
	if (_forEachIndex == 1) then {_mrk setMarkerColor "ColorEAST"};
	/// 2
	if (_forEachIndex == 3) then {_mrk setMarkerColor "ColorWEST"};
	if (_forEachIndex == 4) then {_mrk setMarkerColor "ColorEAST"};
	/// 5
	/// 6
	if (_forEachIndex == 7) then {_mrk setMarkerColor "ColorWEST"};
	if (_forEachIndex == 8) then {_mrk setMarkerColor "ColorEAST"};
	/// 8
}forEach SAI_CFG_OBJECTIVES;

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