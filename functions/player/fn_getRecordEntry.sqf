params ["_database", "_iteration", "_index"];

private ["_return"];

_return = _database select _iteration select _index;

diag_log format ["playback reading iteration %1 at index %2", _iteration, _index];

_return