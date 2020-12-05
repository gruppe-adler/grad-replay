#include "script_component.hpp"

INFO_1("Starting recording with precision %1",GRAD_REPLAY_PRECISION);

{
    _x setVariable ["GRAD_replay_track", true];
    _x setVariable ["asr_ai_exclude", true];
} forEach playableUnits + switchableUnits + allPlayers;

// currentSaveState array contains last relevant data
private _currentSaveState = [];

[{
    params ["_args", "_handle"];
    _args params ["_currentSaveState"];

    // end recording and start playback
    if (GRAD_REPLAY_RECORDING_STOPPED) exitWith {
        [_handle] call CBA_fnc_removePerFrameHandler;
        [] spawn GRAD_replay_fnc_preparePlaybackServer;
    };

    // skip if currently paused
    if (GRAD_REPLAY_RECORDING_PAUSED) exitWith {};

    _players = playableUnits + switchableUnits + allDeadMen;
    _trackedUnits = _players;
    _terminals = allMissionObjects "Land_DataTerminal_01_F"; // speciality for mission "breaking contact"
    _trackedUnits append _terminals;

    if (GRAD_REPLAY_AI_VEHICLES_TRACKED ) then {
        // filter weapon holders
        _vehicles = (vehicles + allDead - allDeadMen) select {
            !(typeOf _x in ["WeaponHolder","WeaponHolder_Single_F","WeaponHolderSimulated","WeaponHolderSimulated_Scripted","GroundWeaponHolder","GroundWeaponHolder_Scripted"])
        };
        _trackedUnits append _vehicles;
    };

    if (GRAD_REPLAY_AI_ONFOOT_TRACKED) then {
        _ai = allUnits - playableUnits - switchableUnits;
        _trackedUnits append _ai;
    };

    /* diag_log ["_trackedUnits",_trackedUnits]; */

    // _nextTickData contains all the data of the next timestamp that is then appended to GRAD_REPLAY_DATABASE
    _nextTickData = [];

    {
        _unit = _x;
        _veh = vehicle _unit;
        _isMan = _unit isKindOf "Man";
        _isVehicle = !_isMan && {_unit isKindOf "AllVehicles"};
        _isEmptyVehicle = _isVehicle && {{alive _x} count (crew _unit) == 0};

        if ([_unit,_veh,_isVehicle,_isEmptyVehicle,_isMan] call grad_replay_fnc_canTrackUnit) then {

            // set tracking ID if unit doesn't have one
            private _unitID = _unit getVariable "grad_replay_unitID";
            if (isNil "_unitID") then {
                _unitID = _currentSaveState pushBack [];
                _unit setVariable ["grad_replay_unitID",_unitID];
            };
            private _currentUnitData = _currentSaveState select _unitID;

            // use ACE_Name so it works with dead units
            private _name = _unit getVariable ["ACE_Name",""];

            private _pos = getpos _unit;
            _pos resize 2;
            
            private _dir = round (getDir _veh);
            private _type = typeOf _veh;

            // firedTarget is being set by fn_onFiredMan --> if it has a value, save and reset the variable
            private _firedTarget = _unit getVariable ["grad_replay_firedTarget",[]];
            _unit setVariable ["grad_replay_firedTarget",nil];


            private _groupname = if (_unit isEqualTo (leader group _unit)) then {" (" + groupId (group _unit) + ")"} else {""};
            if (alive _unit && {_unit getVariable ["ACE_isUnconscious", false]}) then {
                _groupname = "unconscious";
            };

            private _colorID = [_unit] call grad_replay_fnc_getColorIdForUnit;

            [
                _currentUnitData,
                _nextTickData,
                _unitID,
                [_type, _colorID, _pos, _dir, _name, _groupname, _firedTarget]
            ] call GRAD_replay_fnc_storeValue;
        };

    } forEach _trackedUnits;

    _nextTickData pushBack dayTime;
    GRAD_REPLAY_DATABASE pushBack _nextTickData;

},GRAD_REPLAY_PRECISION,[_currentSaveState]] call CBA_fnc_addPerFrameHandler;
