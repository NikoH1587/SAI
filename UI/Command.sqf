onMapSingleClick {

	private _markers = SAI_MARKERS_WEST;
	private _clickPos = _pos;
	private _nearest = "";
	private _minDist = 200;
	
	{
		private _mrkPos = getMarkerPos _x;
		private _dist = _clickPos distance2D _mrkPos;
		
		if (_dist < _minDist) then {
			_minDist = _dist;
			_nearest = _x;
		};
	} forEach _markers;
	
	if (_nearest != "") then {

		/// WAYPOINT POSITION LINE ON EVERY BLUFOR MARKER!

		private _grpID = _nearest select [9, count _nearest];
		private _group = SAI_WEST_ALL findIf { groupId _x == _grpID };
		private _grp = if (_group != -1) then { SAI_WEST_ALL select _group } else { grpNull };



		if (!isNull _grp) then {
			createDialog "SAI_GUI_CMD";
			private _display = findDisplay 3000;
			(_display displayCtrl 3002) ctrlSetText format ["%1", groupId _grp];

			private _combo = _display displayCtrl 3003;
			lbClear _combo;
			_combo lbAdd "Move";
			_combo lbAdd "Defend";
			_combo lbAdd "Attack";
			
			private _markerType = markerType _nearest;
			private _cfg = configFile >> "CfgMarkers" >> _markerType;
			private _iconPath = getText (_cfg >> "icon");
			
			(_display displayCtrl 3001) ctrlSetText _iconPath;
		};
	} else {
		player sideChat "No group selected, click on marker to select group";
	}
};
