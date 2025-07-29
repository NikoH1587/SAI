SAI_CFG_FACTIONS = [];
SAI_CFG_FACNAMES = [];

_cfg = configFile >> "CfgGroups";
SAI_CFG_GROUPS = [];

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
						if (_isInfantry) then {
							SAI_CFG_FACTIONS append [[_sidename, _facname, _catname, _vehfac]];
							SAI_CFG_FACNAMES append [getText (configFile >> "CfgGroups" >> _sidename >> "name") + " - " + getText (configFile >> "CfgGroups" >> _sidename >> _facname >> "name") + " - " + getText (configFile >> "CfgGroups" >> _sidename >> _facname >> _catname >> "name") + " - " + _vehfac];
						};
					};
				};
			};
		};
	};
};