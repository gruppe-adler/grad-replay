#include "script_component.hpp"

INFO("Assembling replay data.");
private _startTime = diag_tickTime;

GRAD_REPLAY_DATABASE_LOCAL_ASSEMBLED = [];

private _currentUnitsDataStates = [];
private _typeDefaults = [
	"",		// icon
	-1,		// color ID
	[0,0],	// pos2D
	-1,		// dir
	"",		// name
	""		// group name
];

{
    _compressedIntervalData = _x;
    _intervalData = [];
    {
		// catch nil entries, not sure what's causing them
		if (isNil "_x") then {
			ERROR_1("Interval data is nil at index %1.",_forEachIndex);

		} else {
			// timestamp
	        if (_x isEqualType 0) exitWith {
	            _intervalData pushBack _x;
	        };

	        // data array
	        if (_x isEqualType []) then {
	            _unitData = [];
	            _compressedUnitData = _x;

	            if (_forEachIndex >= count _currentUnitsDataStates) then {
	                _currentUnitsDataStates pushBack [];
	            };
	            _currentUnitDataState = _currentUnitsDataStates select _forEachIndex;

	            {
	                if (isNil "_x") then {
	                    _unitData pushBack (_currentUnitDataState param [_forEachIndex,_typeDefaults select _forEachIndex]);
	                } else {
	                    _currentUnitDataState set [_forEachIndex,_x];
	                    _unitData pushBack _x;
	                };
	            } forEach _compressedUnitData;

	            _intervalData pushBack _unitData;
	        };
		};
    } forEach _compressedIntervalData;

    GRAD_REPLAY_DATABASE_LOCAL_ASSEMBLED pushBack _intervalData;
    false
} count GRAD_REPLAY_DATABASE_LOCAL;

INFO_1("Assembling completed in %1s",diag_tickTime - _startTime);
