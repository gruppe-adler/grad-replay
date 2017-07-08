params ["_database", "_cluster", "_iteration", "_index"];

private ["_return"];

_return = _database select _cluster select _iteration select _index;

// diag_log format ["%4 read at cluster %1 at iteration %2 at index %3", _cluster, _iteration, _index, _return];

_return