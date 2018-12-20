params [["_set", true]];

GRAD_REPLAY_RECORDING_PAUSED = _set;
["GRAD_replay_paused",{true}] call CBA_fnc_globalEvent;