params ["_array", "_index"];

// hintsilent format ["appending array %1", count GRAD_REPLAY_DATABASE_LOCAL];
// diag_log format ["appending array %1", count GRAD_REPLAY_DATABASE_LOCAL];

GRAD_REPLAY_DATABASE_LOCAL set [_index, (parseSimpleArray _array)];