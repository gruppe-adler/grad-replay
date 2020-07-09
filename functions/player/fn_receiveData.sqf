params ["_replayLength", "_index", "_playerCount"];

// quit EG spec
if (["IsInitialized"] call BIS_fnc_EGSpectator) then {
    ["Terminate"] call BIS_fnc_EGSpectator;
};


// quit ACE spec
if (!isNil "ace_spectator_isSet") then {
    [false] call ace_spectator_fnc_setSpectator;
};

GRAD_REPLAY_DATABASE_TARGET_COUNT_LOCAL = _replayLength;
[_replayLength, _index, _playerCount] spawn GRAD_replay_fnc_showProgressBar;


// quit grad cam
GRAD_CINEMACAM = objNull;


// quit gcam
GCamKill = true;

// let players be able to talk already
if (isClass (configFile >> "CfgPatches" >> "task_force_radio")) then {
    [player, true] call TFAR_fnc_forceSpectator;
};
if (isClass (configFile >> "CfgPatches" >> "acre_main")) then {
    [true] call acre_api_fnc_setSpectator;
};
