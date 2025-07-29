_westX = 0;
_westY = 0;
_eastX = 0;
_eastY = 0;

_force_west = 
(count SAI_WEST_INF * 1) +
(count SAI_WEST_LOG * 1) +
(count SAI_WEST_CAR * 2) +
(count SAI_WEST_AIR * 3) +
(count SAI_WEST_ARM * 4) +
(count SAI_WEST_ART * 5) +
(count SAI_WEST_STA * 1) +
(count SAI_WEST_SUP * 1);

_force_east = 
(count SAI_EAST_INF * 1) +
(count SAI_EAST_LOG * 1) +
(count SAI_EAST_CAR * 2) +
(count SAI_EAST_AIR * 3) +
(count SAI_EAST_ARM * 4) +
(count SAI_EAST_ART * 5) +
(count SAI_EAST_STA * 1) +
(count SAI_EAST_SUP * 1);

SAI_OBJECTIVE = "SAI_CENT";
SAI_FORCE_WEST = SAI_FORCE_WEST max _force_west;
SAI_FORCE_EAST = SAI_FORCE_EAST max _force_east;

if (_force_west > _force_east * 1.5) then {SAI_OBJECTIVE = "SAI_EAST"};
if (_force_east > _force_west * 1.5) then {SAI_OBJECTIVE = "SAI_WEST"};

if (SAI_DEBUG) then {
	private _percentWest = floor ((_force_west / SAI_FORCE_WEST) * 100);
	private _percentEast = floor ((_force_east / SAI_FORCE_EAST) * 100);
	"SAI_WEST" setMarkerText (str _percentWest + "%");
	"SAI_EAST" setMarkerText (str _percentEast + "%");
};