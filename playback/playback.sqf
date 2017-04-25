#include "\z\ace\addons\main\script_component.hpp"


{_x setMarkerAlpha 0;} forEach allMapMarkers; // hide all markers for replay --> to be tested
if (!isNull (findDisplay 7810)) then {closeDialog 0};

if (player getVariable ["ACE_isUnconscious", false]) then {
	forceRespawn player;
};

if (isServer || isDedicated) then {

	[{["Starting Replay."] call EFUNC(common,displayTextStructured);},"BIS_fnc_spawn",true,true] call BIS_fnc_MP;
	[{openMap [true,true];},"BIS_fnc_spawn",true,true] call BIS_fnc_MP;
	[{[player, true] call TFAR_fnc_forceSpectator;},"BIS_fnc_spawn",true,true] call BIS_fnc_MP;

	local_recording_length = count local_recording;
	local_recording_counter = 0;
	current_markers = [];
	deadUnitMarkers = [];
	tempCurrentPlayerCount = 0;

	getDayTimeConverted = {
		_getdaytime = _this select 0;
		//daytime = 1.66046
		_hour = floor _getdaytime;
		_minute = floor ((_getdaytime - _hour) * 60);
		_second = floor (((((_getdaytime) - (_hour))*60) - _minute)*60);
		_time24 = text format ["%1:%2:%3",_hour,_minute,_second];
		if (_minute < 10) then {
		_time24 = text format ["%1:0%2:%3",_hour,_minute,_second];
		};
		if (_second < 10) then {
		_time24 = text format ["%1:%2:0%3",_hour,_minute,_second];
		};
		if (_second < 10 && _minute < 10) then {
		_time24 = text format ["%1:0%2:0%3",_hour,_minute,_second];
		};
		//_time24 = 1:39:37
		_time24
	};

	checkArrayLength = {
		_value = _this select 0;
		_array = _this select 1;
		if (_value < 0) then {_value = 0};
		if (_value > count _array - 1) then {_value = count _array - 1};
		_value
	};

	// **** change : faster Option (If) added
	getSideMarkerColor = {
		_mySide = _this select 0;
		_result = "ColorCivilian";
		switch(true)do
		{
		  case (_mySide == west):{_result = "ColorBLUFOR";};
		  case (_mySide == resistance):{_result = "ColorIndependent";};
		  case (_mySide == east):{_result = "ColorOPFOR";};
		  default {};
		};
		_result
	};

	countCurrentUnits = {
		_entry = _this select 0;
		_units = count (((local_recording) select _entry) select 2);
		// diag_log format ["Replay: countCurrentUnits: %1", _units];
		_units
	};

	getRecordingUnit = {
		_stepentry = _this select 0;
		_unitentry = _this select 1;
		_unit = (((((local_recording) select _stepentry) select 2) select _unitentry) select 0);
		// diag_log format ["Replay: stepEntry: %1, unitEntry: %2, getRecordingUnit: %3", _stepentry,_unitentry,_unit];
		_unit
	};

	getRecordingSide = {
		_stepentry = _this select 0;
		_unitentry = _this select 1;
		_side = (((((local_recording) select _stepentry) select 2) select _unitentry) select 1);
		// diag_log format ["Replay: stepEntry: %1, unitEntry: %2, _side: %3", _stepentry,_unitentry,_side];
		_side
	};

	getRecordingPos = {
		_stepentry = _this select 0;
		_unitentry = _this select 1;
		_pos = (((((local_recording) select _stepentry) select 2) select _unitentry) select 2);
		_pos
	};

	getRecordingDir = {
		_stepentry = _this select 0;
		_unitentry = _this select 1;
		_dir = (((((local_recording) select _stepentry) select 2) select _unitentry) select 3);
		_dir
	};

	getRecordingKindof = {
		_stepentry = _this select 0;
		_unitentry = _this select 1;
		_kindof = (((((local_recording) select _stepentry) select 2) select _unitentry) select 4);
		_kindof
	};

	getRecordingVehicle = {
		_stepentry = _this select 0;
		_unitentry = _this select 1;
		_vehicle = (((((local_recording) select _stepentry) select 2) select _unitentry) select 5);
		_vehicle
	};

	getRecordingHide = {
		_stepentry = _this select 0;
		_unitentry = _this select 1;
		_hide = (((((local_recording) select _stepentry) select 2) select _unitentry) select 6);
		_hide
	};

	createNewMarker = {
		_unit = _this select 0;
		_side = _this select 1;
		_pos = _this select 2;
		_dir = _this select 3;
		_kindof = _this select 4;
		_veh = _this select 5;

		_marker = createMarker [format["%1",_unit],_pos];
		diag_log format ["Replay: Marker %1 created", _marker];
		_marker setMarkerShape "ICON";
		_marker setMarkerType _kindof;
		_marker setMarkerAlpha 1;
		_marker setMarkerDir _dir;
		_marker setMarkerColor ([_side] call getSideMarkerColor);
		current_markers = current_markers + [_unit];
		/* if (_kindof == "KIA") then {
			deadUnitMarkers = deadUnitMarkers + [_unit];
		} else {
			current_markers = current_markers + [_unit];
		}; */
	};

	checkIfMarkerExists = {
		_return = false;
		if (([_this select 0,_this select 1] call getRecordingUnit) in current_markers) then {
			_return = true;
		};
		_return
	};

	iterateRecording = {
		while {true} do
		{
			for [{_k=0}, {_k < ([local_recording_counter] call countCurrentUnits)}, {_k=_k+1}] do {
				_unit = [local_recording_counter,_k] call getRecordingUnit;
				_side = [local_recording_counter,_k] call getRecordingSide;
				_pos = [local_recording_counter,_k] call getRecordingPos;
				_dir = [local_recording_counter,_k] call getRecordingDir;
				_kindof = [local_recording_counter,_k] call getRecordingKindof;
				_veh = [local_recording_counter,_k] call getRecordingVehicle;
				_hide = [local_recording_counter,_k] call getRecordingHide;

					if ([local_recording_counter,_k] call checkIfMarkerExists) then {
						(str _unit) setMarkerPos _pos;
						(str _unit) setMarkerDir _dir;
						(str _unit) setMarkerType _kindof;
						if (_hide) then {(str _unit) setMarkerAlpha 0;} else {(str _unit) setMarkerAlpha 1;};
					} else {
						[_unit,_side,_pos,_dir,_kindof,_veh] call createNewMarker;
					};
				};


		local_recording_counter = local_recording_counter + REPLAY_STEPS_PER_TICK;

		if (!(local_recording_counter < local_recording_length)) exitWith {
			[{["Replay finished."] call EFUNC(common,displayTextStructured);},"BIS_fnc_spawn",true,true] call BIS_fnc_MP;
			sleep 12;
			[{openMap [false,true];},"BIS_fnc_spawn",true,true] call BIS_fnc_MP;

			REPLAY_FINISHED = true;
			publicVariable "REPLAY_FINISHED";
		};

		sleep REPLAY_SPEED;

		};
	};

	[] spawn iterateRecording;
};
