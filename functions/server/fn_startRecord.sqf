params ["_precision"];

diag_log format ["grad replay: starting record with precision %1", _precision];


{
	_x setVariable ["GRAD_replay_persistentName", name _x, true];

} forEach playableUnits + switchableUnits;

{
	_x setVariable ["GRAD_replay_track", true];
	_x setVariable ["asr_ai_exclude", true];
} forEach playableUnits + switchableUnits;


GRAD_REPLAY_DATABASE_TEMP = []; // global local

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

		    	if (_unit getVariable ["GRAD_replay_track", false]) then {

		    		_isEmptyVehicle = _unit isKindOf "LandVehicle" && ({alive _x} count (crew _unit) == 0);
					_isMan = (vehicle _unit) isKindOf "Man" || isPlayer _unit; // isplayer is overkill, but debug
					_isCustomObject = _unit getVariable ["GRAD_replay_track", false];

		    		_name = if (alive _unit && _isMan) then {name _unit} else {""};
		    		_groupname = if (_unit isEqualTo (leader group _unit)) then {" (" + groupId (group _unit) + ")"} else {""};
					_veh = vehicle _unit;
					_dir = getDir _veh;
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

					// track terminal
					if (_type isEqualTo "Land_DataTerminal_01_F" && !(isNil "GRAD_TERMINAL_ACTIVE") && {GRAD_TERMINAL_ACTIVE}) then {
						_color = [1,0,0,1];
					};

					// mark empty vehicle
					if (_isEmptyVehicle && !_isMan) then {
						_color = [sideEmpty] call GRAD_replay_fnc_getSideColor;
					};

					// change icon for unconcscious
					if (_unit getVariable ["ACE_isUnconscious", false]) then {
						_icon = "iconManVirtual";
						_groupname = "unconscious";
					};

					// change icon for dead unit and add name					
					if (!alive _unit && _isMan) then {
						_icon = "iconExplosiveGP";
						_groupname = _unit getVariable ["GRAD_replay_persistentName", ""];
						_color = [.2,.2,.2,1];
					};

					// change icon for destroyed vehicle and add name
					if (!alive _unit && _isEmptyVehicle) then {
						_groupname = _unit getVariable ["GRAD_replay_persistentName", ""];
						_color = [.2,.2,.2,1];
					};

					// current values: position, side, kindof
					if (_isMan || _isEmptyVehicle || _isCustomObject) then {
						GRAD_REPLAY_DATABASE_TEMP pushBack [_icon,_color,_pos,_dir,_name,_groupname];
					};
				};
			
			} forEach _trackedUnits;

		    GRAD_REPLAY_DATABASE pushBack GRAD_REPLAY_DATABASE_TEMP;
			GRAD_REPLAY_DATABASE_TEMP = [];
		    
		    // end recording and start playback
		    if (GRAD_REPLAY_STOPPED) then {
		    	[_handle] call CBA_fnc_removePerFrameHandler;

		    	call GRAD_replay_fnc_preparePlaybackServer;
			};
	};

},_precision, []] call CBA_fnc_addPerFrameHandler;