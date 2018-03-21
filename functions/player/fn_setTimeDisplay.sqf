params ["_position"];

disableSerialization;
_time = GRAD_REPLAY_DATABASE_LOCAL select _position select (count (GRAD_REPLAY_DATABASE_LOCAL select _position) - 1);

// if (_time find ".paa" > -1) exitWith { diag_log format ["grad-replay: catch unvalid time display: %1", _position]; };

((findDisplay 80000) displayCtrl 80004) ctrlSetText _time;