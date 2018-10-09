params ["_array", "_index"];

// hintsilent format ["appending array %1", count GRAD_REPLAY_DATABASE_LOCAL];
// diag_log format ["appending array %1", count GRAD_REPLAY_DATABASE_LOCAL];

GRAD_REPLAY_DATABASE_LOCAL set [_index, _array];

private _targetCount = missionNamespace getVariable ["GRAD_REPLAY_DATABASE_TARGET_COUNT_LOCAL",9999999];

if (count GRAD_REPLAY_DATABASE_LOCAL == _targetCount) then {
    [] call grad_replay_fnc_assembleReplayData;
    player setVariable ["grad_replay_playerReceivalComplete",true,true];
};
