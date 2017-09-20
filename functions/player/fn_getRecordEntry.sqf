params ["_database", "_cluster", "_iteration", "_index", "_defaultValue"];

private ["_return"];

_return = _database;
{
    if (count _return <= _x) exitWith {
        if (isNil "_defaultValue") then {_return = nil} else {_return = _defaultValue};
    };
    _return = _return select _x;

    false
} count [_cluster,_iteration,_index];



/* diag_log format ["playback reading cluster %1 at iteration %2 at index %3", _cluster, _iteration, _index];*/

_return
