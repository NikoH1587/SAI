openmap true;
LOC_MODE = "SELECT"; /// "SELECT", "ORDERS", "COMMIT", "CANCEL";
LOC_ORDERS = [];
LOC_SELECT = [];
/// Get counter which can move

LOC_FNC_SELECT = {
	private _selectable = [];
	private _posCLICK = _this;
	/// Find counters with moves
	{
		private _hex = _x;
		private _sid = _x select 4;
			private _act = _x select 5;
		if (_sid == side player && _act > 0) then {
			_selectable pushback _hex;
		};
	}forEach HEX_GRID;

	/// Select counter
	{
		private _hex = _x;
		private _row = _x select 0;
		private _col = _x select 1;
		private _pos = _x select 2;
		if (_pos distance _posCLICK < (HEX_SIZE/2)) then {
			LOC_SELECT = _x;
			LOC_MODE = "ORDER";
			
			private _name = format ["SEL_%1_%2", _row, _col];
			private _marker = createMarkerLocal [_name, _pos];
			_marker setMarkerTypeLocal "Select";
			_marker setMarkerSize [1.5, 1.5];
			/// Play sound 
			0 spawn LOC_SOUND;
			
			/// Add all possible moves
			private _near = _hex call HEX_FNC_NEAR;
			{
				private _nearHEX = _x;
				private _side = _x select 4;
				if (_side != side player) then {
					LOC_ORDERS pushback _nearHEX;
				};
			}forEach _near;		
			
			{
				private _row2 = _x select 0;
				private _col2 = _x select 1;
				private _pos2 = _x select 2;
				private _name2 = format ["STR_%1_%2", _row2, _col2];
				private _marker2 = createMarkerLocal [_name2, _pos2];
				_marker2 setMarkerTypeLocal "Select";
			}ForEach LOC_ORDERS;
		};
	}forEach _selectable;
};

LOC_FNC_ORDERS = {
	private _near = LOC_SELECT call HEX_FNC_NEAR;
	{
		private _hex = _x;
		private _side = _x select 4;
		if (side plyer != _side) then {
			if (_side == "civilian") then {
				LOC_MARCH pushBack _hex;
			} else {
				LOC_ATTACK pushBack _hex;			
			};
		};
	}forEach _near;
};

LOC_FNC_COMMIT = {
	/// Send order to host, update markers for all!
	{
		
	}forEach LOC_MARKERS;
};

onMapSingleClick {
	if (LOC_MODE == "SELECT") then {
		_pos call LOC_FNC_SELECT;
	};
	if (LOC_MODE == "ORDERS") then {
		_pos call LOC_FNC_ORDERS;
	};
	true;
};

/// Sound effect
LOC_SOUND = {
	private _sounds = [
		"a3\dubbing_radio_f\sfx\radionoise1.ogg", 
		"a3\dubbing_radio_f\sfx\radionoise2.ogg", 
		"a3\dubbing_radio_f\sfx\radionoise3.ogg"
	];
	private _sound = playSoundUI [_sounds select floor random 3, 1];
	sleep 1.5;
	stopSound _sound;
};