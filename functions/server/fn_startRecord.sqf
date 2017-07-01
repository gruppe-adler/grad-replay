params ["_precision", "_specialVehicle"];

[{
    params ["_args", "_handle"];
    _args params ["_specialVehicle"];

    // just skip if currently paused
    if (!GRAD_REPLAY_PAUSED) then {

    	_players = playableUnits + switchableUnits + allDeadMen;
    	_vehicles = vehicles;
    	_ai = allUnits - playableUnits - switchableUnits;
    	_trackedUnits = _players;

    	if (GRAD_REPLAY_AI_TRACKED) then {
    		_trackedUnits = _trackedUnits + _ai;
    	};

    	if (GRAD_REPLAY_EMPTY_TRACKED) then {
    		_trackedUnits = _trackedUnits + _vehicles;
    	};

	    {
	    	_unit = _x;

	    	// dont render different stuff
	    	if (_unit isKindOf "WeaponHolderSimulated") exitWith {};
			if (_unit isKindOf "ACE_wheel" || _unit isKindOf "ACE_Track" ) exitWith {};

			_veh = vehicle _unit;
			_pos = getpos _unit;
			_side = side (group _unit);
			_color = [_side] call GRAD_replay_fnc_getSideColor;
			_icon = getText (configfile >> "CfgVehicles" >> typeOf _unit >> "icon");
			_special = "none";

			if (_side == civilian && (!(_veh isEqualTo _specialVehicle) || !(_unit isEqualTo _specialVehicle) || !GRAD_REPLAY_EMPTY_TRACKED)) exitWith {};
			
			_dir = (getDir _unit);
			
			// dont render another marker for the vehicle, if vehicle is not empty
			if (count (crew _unit) > 0 && ((crew _unit) select 0 != _unit)) exitWith {};


			if (_unit getVariable ["ACE_isUnconscious", false]) then {
				_special = "unconscious";
			};

			if (!alive _unit) then {
				_special = "dead";
			};

			// current values: position, side, kindof
			[_unit,_color,_pos,_dir,_special,_veh] call GRAD_replay_fnc_storeValue;
		
	} forEach _trackedUnits;

    GRAD_REPLAY_DATABASE = GRAD_REPLAY_DATABASE + [GRAD_REPLAY_DATABASE_TEMP];
	GRAD_REPLAY_DATABASE_TEMP = [];
    
    // end recording and start playback
    if (GRAD_REPLAY_STOPPED) then {
    	[_handle] call CBA_fnc_removePerFrameHandler;

    	call GRAD_replay_fnc_preparePlaybackServer;
	};

},_precision,[_specialVehicle]] call CBA_fnc_addPerFrameHandler;