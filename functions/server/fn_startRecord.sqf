params ["_precision"];

diag_log format ["grad replay: starting record with precision %1", _precision];

{
	_x setVariable ["GRAD_replay_persistentName", name _x, true];

} forEach allUnits;

{
	_x setVariable ["GRAD_replay_track", true];
	_x setVariable ["asr_ai_exclude", true];
} forEach playableUnits + switchableUnits + allPlayers;

[{
    params ["_args", "_handle"];
    _args params [];

    // only skip if currently paused
    if (!GRAD_REPLAY_RECORDING_PAUSED) then {

	    	_players = playableUnits + switchableUnits + allDeadMen;
	    	_vehicles = vehicles + allDead - allDeadMen;
	    	_ai = allUnits - playableUnits - switchableUnits;
	    	_trackedUnits = _players;
	    	_terminals = allMissionObjects "Land_DataTerminal_01_F"; // speciality for mission "breaking contact"
	    	_trackedUnits append _terminals;

	    	if (GRAD_REPLAY_AI_VEHICLES_TRACKED) then {
	    		_trackedUnits append _vehicles;
	    	};

	    	if (GRAD_REPLAY_AI_ONFOOT_TRACKED) then {
	    		_trackedUnits append _ai;
	    	};

	    	// diag_log format ["tracked: %1",_trackedUnits];

		    {
		    	_unit = _x;


		    	// if (_unit getVariable ["GRAD_replay_track", false] || isPlayer _unit) then {

		    		_isEmptyVehicle = _unit isKindOf "LandVehicle" && ({alive _x} count (crew _unit) == 0);
					_isMan = (vehicle _unit) isKindOf "Man";
					_isCustomObject = _unit getVariable ["GRAD_replay_track", false];
					_isAI = !isPlayer _unit;
					// _isPlayerVehicle = _unit isPlayer;

		    		_name = if (alive _unit && _isMan) then {name _unit} else {""};
		    		_groupname = if (_unit isEqualTo (leader group _unit)) then {" (" + groupId (group _unit) + ")"} else {""};
					_veh = vehicle _unit;
					_pos = getpos _unit;
					_side = side _unit;
					_color = [_side] call GRAD_replay_fnc_getSideColor;
					_type = typeOf (vehicle _unit);
					_icon = getText (configfile >> "CfgVehicles" >> _type >> "icon");


					// mark funkwagen if he is sending in red // speciality for mission "breaking contact"
					if (_type isEqualTo "rhs_gaz66_r142_vv" && {_veh getVariable ["tf_range",0] == 50000}) then {
						_color = [1,0,0,1];
					};

					// speciality for mission "breaking contact"
					if (_type isEqualTo "Land_DataTerminal_01_F" && !(isNil "GRAD_TERMINAL_ACTIVE") && {GRAD_TERMINAL_ACTIVE}) then {
						_color = [1,0,0,1];
					};

					if (_isEmptyVehicle && !_isMan) then {
						_color = [sideEmpty] call GRAD_replay_fnc_getSideColor;
					};

					// todo filter empty vehicles and crew

					_dir = getDir (vehicle _unit);

					if (_unit getVariable ["ACE_isUnconscious", false]) then {
						_color = [_color select 0, _color select 1, _color select 2, 0.5];
						_groupname = "unconscious";
					};

					

					if (!alive _unit && _isMan) then {
						_groupname = _unit getVariable ["GRAD_replay_persistentName", ""];
						_color = [.2,.2,.2,1];
					};

					if (!alive _unit && _isEmptyVehicle) then {
						_groupname = _unit getVariable ["GRAD_replay_persistentName", ""];
						_color = [.2,.2,.2,1];
					};

					// current values: position, side, kindof
					if ((_isMan && _side in GRAD_REPLAY_SIDES && (_unit getVariable ["grad_gcamspec_firstSpawn", true])) || 
						_isEmptyVehicle ||
						(_isCustomObject && _side in GRAD_REPLAY_SIDES ||
						_isAI)) then {
						[[_icon,_color,_pos,_dir,_name,_groupname]] call GRAD_replay_fnc_storeValue;
					};
				// };

				// diag_log format ["grad replay: storing %1, %2, %3, %4, %5, %6", _unit,_color,_pos,_dir,_special,_veh];

				
			
			} forEach _trackedUnits;

			if (count GRAD_REPLAY_DATABASE_TEMP > 0) then {

				_hour = floor daytime;
				_minute = floor ((daytime - _hour) * 60);
				_second = floor (((((daytime) - (_hour))*60) - _minute)*60);
				_emptyZeroMinute = "";
				_emptyZeroSecond = "";
				if (_minute < 10) then { _emptyZeroMinute = "0"; };
				if (_second < 10) then { _emptyZeroSecond = "0"; };
				_time24 = text format ["%1:%2%3:%4%5",_hour,_emptyZeroMinute,_minute,_emptyZeroSecond,_second];
				GRAD_REPLAY_DATABASE_TEMP append [str _time24];

		    	GRAD_REPLAY_DATABASE append [GRAD_REPLAY_DATABASE_TEMP];
			};
			GRAD_REPLAY_DATABASE_TEMP = [];
		    
		    // end recording and start playback
		    if (GRAD_REPLAY_RECORDING_STOPPED) then {
		    	[_handle] call CBA_fnc_removePerFrameHandler;

		    	[] spawn GRAD_replay_fnc_preparePlaybackServer;
			};
	};

},_precision] call CBA_fnc_addPerFrameHandler;