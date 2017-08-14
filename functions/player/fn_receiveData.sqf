params ["_count", "_index", "_playerCount"];

GRAD_REPLAY_DATABASE_TARGET_COUNT_LOCAL = _count;
[_count, _index, _playerCount] spawn GRAD_replay_fnc_showProgressBar;