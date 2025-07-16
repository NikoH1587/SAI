// Get west and east marker positions
_west = getMarkerPos "SAI_WEST";
_east = getMarkerPos "SAI_EAST";

// Midpoint between markers
_cent = [
    ((_west select 0) + (_east select 0)) / 2,
    ((_west select 1) + (_east select 1)) / 2
];
createMarker ["SAI_CENT", _cent];

// Calculate angle from west to east
_dx = (_east select 0) - (_west select 0);
_dy = (_east select 1) - (_west select 1);
_angle = atan (_dy / _dx);
if (_dx < 0) then { _angle = _angle + 180 };


SAI_DISTANCE = _west distance _east;
SAI_RADIUS = SAI_DISTANCE/6;

_rAngle = _angle + 90;
_lAngle  = _angle - 90;

_rPos = [
    (_cent select 0) + (cos _rAngle) * SAI_DISTANCE/3,
    (_cent select 1) + (sin _rAngle) * SAI_DISTANCE/3
];
_lPos = [
    (_cent select 0) + (cos _lAngle) * SAI_DISTANCE/3,
    (_cent select 1) + (sin _lAngle) * SAI_DISTANCE/3
];

createMarker ["SAI_RIGHT", _rPos];
createMarker ["SAI_LEFT", _lPos];

{
_x setMarkerShape "ELLIPSE";
_x setMarkerSize [SAI_RADIUS, SAI_RADIUS];
_x setMarkerBrush "Border";
}forEach ["SAI_RIGHT", "SAI_CENT", "SAI_LEFT", "SAI_WEST", "SAI_EAST"];
