#include "script_component.hpp"

params ["_precision"];

INFO_1("Starting recording with precision %1",_precision);

{
    _x setVariable ["GRAD_replay_persistentName", name _x, true];

} forEach allUnits;

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

    if (GRAD_REPLAY_VEHICLES_TRACKED) then {
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
        _isEmptyVehicle = _unit isKindOf "LandVehicle" && {{alive _x} count (crew _unit) == 0};

        if ([_unit,_veh,_isEmptyVehicle] call grad_replay_fnc_canTrackUnit) then {
            _unitID = _unit getVariable "grad_replay_unitID";
            if (isNil "_unitID") then {
                _unitID = _currentSaveState pushBack [];
                _unit setVariable ["grad_replay_unitID",_unitID];
            };
            _currentUnitData = _currentSaveState select _unitID;

            _isMan = _veh isKindOf "Man";

            _name = if (alive _unit && _isMan) then {name _unit} else {""};
            _groupname = if (_unit isEqualTo (leader group _unit)) then {" (" + groupId (group _unit) + ")"} else {""};

            _pos = getpos _unit;
            _pos resize 2;

            _side = side _unit;
            _colorID = [_side] call GRAD_replay_fnc_getSideColorID;
            _type = typeOf _veh;
            _icon = getText (configfile >> "CfgVehicles" >> _type >> "icon");

            // mark funkwagen if he is sending in red // speciality for mission "breaking contact"
            if (_type isEqualTo "rhs_gaz66_r142_vv" && {_veh getVariable ["tf_range",0] == 50000}) then {
                _colorID = 11;
            };

            // speciality for mission "breaking contact"
            if (_type isEqualTo "Land_DataTerminal_01_F" && !(isNil "GRAD_TERMINAL_ACTIVE") && {GRAD_TERMINAL_ACTIVE}) then {
                _colorID = 11;
            };

            if (_isEmptyVehicle) then {
                _colorID = [sideEmpty] call GRAD_replay_fnc_getSideColorID;
            };

            _dir = round (getDir _veh);

            if (_unit getVariable ["ACE_isUnconscious", false]) then {
                _colorID = _colorID + 5;
                _groupname = "unconscious";
            };

            if (!alive _unit && (_isMan || _isEmptyVehicle)) then {
                _groupname = _unit getVariable ["GRAD_replay_persistentName", ""];
                _colorID = 10;
            };

            [_currentUnitData,_nextTickData,_unitID,[_icon,_colorID,_pos,_dir,_name,_groupname]] call GRAD_replay_fnc_storeValue;
        };

        false
    } count _trackedUnits;

    if (count _nextTickData > 0) then {
        _nextTickData pushBack dayTime;
        GRAD_REPLAY_DATABASE pushBack _nextTickData;
    };

},_precision,[_currentSaveState]] call CBA_fnc_addPerFrameHandler;
