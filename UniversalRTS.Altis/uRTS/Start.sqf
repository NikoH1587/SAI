{
	if (isPlayer _x && simulationEnabled _x == false) then {
		private _pos = [getMarkerPos "respawn_west", 0, 125, 2, 0] call BIS_fnc_findSafePos;
		_x setUnitLoadout uRTS_LOAD_WEST;
		_x setPos _pos;
		_x enableSimulationGlobal true;
	};
}forEach [uRTS_PLAYER_1, uRTS_PLAYER_2, uRTS_PLAYER_3, uRTS_PLAYER_4];

{
	if (isPlayer _x && simulationEnabled _x == false) then {
		private _pos = [getMarkerPos "respawn_east", 0, 125, 2, 0] call BIS_fnc_findSafePos;
		_x setUnitLoadout uRTS_LOAD_EAST;
		_x setPos _pos;
		_x enableSimulationGlobal true;
	}
}forEach [uRTS_PLAYER_5, uRTS_PLAYER_6, uRTS_PLAYER_7, uRTS_PLAYER_8];