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

    // just skip if currently paused
    if (!GRAD_REPLAY_PAUSED) then {

	    	_players = playableUnits + switchableUnits + allDeadMen;
	    	_vehicles = vehicles + allDead - allDeadMen;
	    	_ai = allUnits - playableUnits - switchableUnits;
	    	_trackedUnits = _players;


	    	if (GRAD_CIVILIAN_TRAFFIC_TRACKED) then {
	    		_trackedUnits = _trackedUnits + _ai;
	    	};

	    	if (GRAD_REPLAY_EMPTY_TRACKED) then {
	    		_trackedUnits = _trackedUnits + _vehicles;
	    	};

		    {
		    	_unit = _x;

		    	/*
		    	// dont render different stuff
		    	_isNoShit = (
		    		!(_unit isKindOf "#particlesource") && 
		    		!(_unit isKindOf "GroundWeaponHolder") && 
		    		!(_unit isKindOf "WeaponHolder") && 
		    		!(_unit isKindOf "WeaponHolderSimulated") && 
		    		!(_unit isKindOf "ACE_wheel") &&
		    		!(_unit isKindOf "ACE_Track") &&
		    		(count (crew _unit) > 0)
		    	);

		    	_shouldBeTracked = _unit getVariable ["GRAD_replay_track", false];

		    	_isEmptyVehicle = (count (crew _unit)) == 0;
				*/
				

		    	// !(count (crew _unit) > 0 && ((crew _unit) select 0 != _unit))

		    	// diag_log format ["grad replay: is no shit is %1", _isNoShit];

		    	if (_unit getVariable ["GRAD_replay_track", false]) then {

		    		_isEmptyVehicle = _unit isKindOf "LandVehicle" && ({alive _x} count (crew _unit) == 0);
					_isMan = (vehicle _unit) isKindOf "Man" || isPlayer _unit;
					_isCustomObject = _unit getVariable ["GRAD_replay_track", false];
					// _isPlayerVehicle = _unit isPlayer;

		    		_name = if (alive _unit && _isMan) then {name _unit} else {""};
		    		_groupname = if (_unit isEqualTo (leader group _unit)) then {" (" + groupId (group _unit) + ")"} else {""};
					_veh = vehicle _unit;
					_pos = getpos _unit;
					_side = side _unit;
					_color = [_side] call GRAD_replay_fnc_getSideColor;
					_type = typeOf (vehicle _unit);
					_icon = getText (configfile >> "CfgVehicles" >> _type >> "icon");

					/*
					diag_log format ["
					_isEmptyVehicle: %1, 
					_isMan %2, 
					_isCustomObject %3, 
					%4, %5, %6, %7, %8, %9, %10", 
					_isEmptyVehicle, 
					_isMan, 
					_isCustomObject, 
					_name,
					_groupname,
					_veh,
					_side,
					_color,
					_type,
					_icon];*/

					// mark funkwagen if he is sending in red
					if (_type isEqualTo "rhs_gaz66_r142_vv" && {_veh getVariable ["tf_range",0] == 50000}) then {
						_color = [1,0,0,1];
					};

					if (_type isEqualTo "Land_DataTerminal_01_F" && !(isNil "GRAD_TERMINAL_ACTIVE") && {GRAD_TERMINAL_ACTIVE}) then {
						_color = [1,0,0,1];
					};

					if (_isEmptyVehicle && !_isMan) then {
						_color = [sideEmpty] call GRAD_replay_fnc_getSideColor;
					};

					

					_dir = getDir (vehicle _unit);

					if (_unit getVariable ["ACE_isUnconscious", false]) then {
						_icon = "iconManVirtual";
						_groupname = "unconscious";
					};

					

					if (!alive _unit && _isMan) then {
						_icon = "iconExplosiveGP";
						_groupname = _unit getVariable ["GRAD_replay_persistentName", ""];
						_color = [.2,.2,.2,1];
					};

					if (!alive _unit && _isEmptyVehicle) then {
						_groupname = _unit getVariable ["GRAD_replay_persistentName", ""];
						_color = [.2,.2,.2,1];
					};

					// current values: position, side, kindof
					if (_isMan || _isEmptyVehicle || _isCustomObject) then {
						[[_icon,_color,_pos,_dir,_veh,_name,_groupname]] call GRAD_replay_fnc_storeValue;
					};
				};

				// diag_log format ["grad replay: storing %1, %2, %3, %4, %5, %6", _unit,_color,_pos,_dir,_special,_veh];

				
			
			} forEach _trackedUnits;

		    GRAD_REPLAY_DATABASE = GRAD_REPLAY_DATABASE + [GRAD_REPLAY_DATABASE_TEMP];
			GRAD_REPLAY_DATABASE_TEMP = [];
		    
		    // end recording and start playback
		    if (GRAD_REPLAY_STOPPED) then {
		    	[_handle] call CBA_fnc_removePerFrameHandler;

		    	call GRAD_replay_fnc_preparePlaybackServer;
			};
	};

},_precision] call CBA_fnc_addPerFrameHandler;