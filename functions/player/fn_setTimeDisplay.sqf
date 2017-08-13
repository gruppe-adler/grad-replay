params ["_position"];

disableSerialization;
_time = GRAD_REPLAY_DATABASE_LOCAL select _position select ((count (GRAD_REPLAY_DATABASE_LOCAL select _position)) - 1);

((findDisplay 80000) displayCtrl 80004) ctrlSetText _time;