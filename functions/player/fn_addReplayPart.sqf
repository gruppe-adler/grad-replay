#include "script_component.hpp"

params ["_chunk", "_startIndex"];

// hintsilent format ["appending array %1", count GRAD_REPLAY_DATABASE_LOCAL];
// diag_log format ["appending array %1", count GRAD_REPLAY_DATABASE_LOCAL];

// add all received parts to database
{
    GRAD_REPLAY_DATABASE_LOCAL set [_startIndex + _forEachIndex, _x];
} forEach _chunk;

// start assembling, if everything has been received
private _targetCount = missionNamespace getVariable ["GRAD_REPLAY_DATABASE_TARGET_COUNT_LOCAL",9999999];

if ({!isNil "_x"} count GRAD_REPLAY_DATABASE_LOCAL >= _targetCount) then {
    INFO_1("Client replay receipt completed at serverTime %1",serverTime);
    player setVariable ["grad_replay_playerReceiptComplete",true,true];
    [] call grad_replay_fnc_assembleReplayData;
};
