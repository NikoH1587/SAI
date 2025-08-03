SAI_CFG_FACTIONS = [];
SAI_CFG_FACNAMES = [];
SAI_CFG_CFGVEHICLES = [];
SAI_CFG_CFGVEHNAMES = [];
SAI_CFG_CUSTOM_WEST = [];
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