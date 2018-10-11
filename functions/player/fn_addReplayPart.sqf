#include "script_component.hpp"

params ["_chunk", "_startIndex"];

// add all received parts to database
{
    GRAD_REPLAY_DATABASE_LOCAL set [_startIndex + _forEachIndex, _x];
} forEach _chunk;

// start assembling, if everything has been received
private _targetCount = missionNamespace getVariable ["GRAD_REPLAY_DATABASE_TARGET_COUNT_LOCAL",9999999];
if ({!isNil "_x"} count GRAD_REPLAY_DATABASE_LOCAL >= _targetCount) then {

    // apparently function can run multiple times parallelly --> exit here if other instance was first
    if (player getVariable ["grad_replay_playerReceiptComplete",false]) exitWith {};
    player setVariable ["grad_replay_playerReceiptComplete",true,true];

    INFO_1("Client replay receipt completed at serverTime %1",serverTime);
    diag_log [{!isNil "_x"} count GRAD_REPLAY_DATABASE_LOCAL,count GRAD_REPLAY_DATABASE_LOCAL,_targetCount,_startIndex,count _chunk];

    [] call grad_replay_fnc_assembleReplayData;
};
