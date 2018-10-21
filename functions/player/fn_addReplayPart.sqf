#include "script_component.hpp"

params ["_chunk", "_startIndex"];

// add all received parts to database
{
    GRAD_REPLAY_DATABASE_LOCAL set [_startIndex + _forEachIndex, _x];
} forEach _chunk;

// start assembling, if everything has been received
private _targetCount = missionNamespace getVariable ["GRAD_REPLAY_DATABASE_TARGET_COUNT_LOCAL",9999999];
if ({!isNil "_x"} count GRAD_REPLAY_DATABASE_LOCAL >= _targetCount) then {

    // apparently function can run multiple times in parallel --> exit here if other instance was first
    if (player getVariable ["grad_replay_playerReceiptComplete",false]) exitWith {};
    player setVariable ["grad_replay_playerReceiptComplete",true,true];

    INFO_1("Client replay receipt completed at serverTime %1",serverTime);

    [{[] call grad_replay_fnc_assembleReplayData},[],1] call CBA_fnc_waitAndExecute;
};
