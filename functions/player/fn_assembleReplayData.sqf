#include "script_component.hpp"

params [["_part",0],["_startIndex",0],["_startTime",diag_tickTime],["_currentUnitsDataStates",[]]];

if (_part == 0) then {
    INFO("Assembling replay data.");
} else {
    INFO_2("Continuing assembly at index %1 (recursion %2).",_startIndex,_part);
};

if (isNil "GRAD_REPLAY_DATABASE_LOCAL_ASSEMBLED") then {
    GRAD_REPLAY_DATABASE_LOCAL_ASSEMBLED = [];
};

private _typeDefaults = [
    "",         // icon
    -1,         // color ID
    [0,0],      // pos2D
    -1,         // dir
    "",         // name
    "",         // group name
    []          // fired target
];

private _interrupt = false;
private _startTimePart = diag_tickTime;
private _continueAt = 0;

for [{_i=_startIndex},{_i< count GRAD_REPLAY_DATABASE_LOCAL},{_i=_i+1}] do {

    _compressedIntervalData = GRAD_REPLAY_DATABASE_LOCAL select _i;
    _intervalData = [];

    {
        // catch nil entries, not sure what's causing them
        if (!isNil "_x") then {

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

    if ((diag_tickTime - _startTimePart) > 0.2) exitWith {_interrupt = true; _continueAt = _i + 1};
};

if (_interrupt) then {
    [{_this call grad_replay_fnc_assembleReplayData},[_part + 1,_continueAt,_startTime,_currentUnitsDataStates]] call CBA_fnc_execNextFrame;
} else {
    player setVariable ["grad_replay_playerAssemblyComplete",true,true];
    INFO_1("Assembling completed in %1s",diag_tickTime - _startTime);
};
