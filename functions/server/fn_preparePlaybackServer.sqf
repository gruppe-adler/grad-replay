#include "script_component.hpp"

if (!isServer) exitWith {};

["GRAD_replay_preparingPlayback",{true}] call CBA_fnc_globalEvent;

private _fnc_disableUnit = if (isMultiplayer) then {
    {
        _this enableSimulationGlobal false;
        [""] remoteExec ["switchMove", _this];

        // freeze vehicle
        if (!(vehicle _this isEqualTo _this) && _this isEqualTo (driver vehicle _this)) then {
            vehicle _this attachTo [_this];
        };
    }
} else {
    {
        _this enableSimulation false;
        _this switchMove "";
    }
};

{
    _x call _fnc_disableUnit;
    _x setVariable ["ace_map_hideBlueForceMarker", true];
} count allUnits;

// remove ace blu force tracking marker

ace_map_BFT_Enabled = false;
ace_map_mapShake = false;
// call ACE_map_fnc_blueForceTrackingUpdate;

publicVariable "ace_map_BFT_Enabled";
publicVariable "ace_map_mapShake";


missionnamespace setVariable ["GRAD_replay_isRunning", true, true];

INFO("Sending database to clients.");
private _startTime = diag_tickTime;

private _replayLength = count GRAD_REPLAY_DATABASE;
INFO_1("Replay length is %1",_replayLength);

private _allPlayers = allPlayers - entities "HeadlessClient_F";

// set every client to know whats his number in line and display progress bar
{
    [_replayLength, _forEachIndex + 1, count _allPlayers] remoteExec ["GRAD_replay_fnc_receiveData", _x];
} forEach _allPlayers;

// send to all clients at once, but one tidbit after another --> hopefully this works
for [{_i=0},{_i < ceil (_replayLength / GRAD_REPLAY_SENDING_CHUNK_SIZE)},{_i=_i+1}] do {

    _startIndex = _i * GRAD_REPLAY_SENDING_CHUNK_SIZE;
    if (_startIndex >= _replayLength) exitWith {};

    _endIndex = _startIndex + GRAD_REPLAY_SENDING_CHUNK_SIZE;
    if (_endIndex >= _replayLength) then {_endIndex = _replayLength - 1};

    _chunk = GRAD_REPLAY_DATABASE select [_startIndex, _endIndex - _startIndex + 1];

    [_chunk,_startIndex] remoteExecCall ["GRAD_replay_fnc_addReplayPart", _allPlayers];
    sleep GRAD_REPLAY_SENDING_DELAY; // set to zero for debugging ordering
};

INFO_1("Database sending completed in %1s.",(diag_tickTime - _startTime));

// wait until all clients have received all the data and assembled it
private _waitCondition = {
    params ["_allPlayers"];
    (_allPlayers arrayIntersect allPlayers) findIf {!(_x getVariable ["grad_replay_playerAssemblyComplete",false])} < 0
};

private _onComplete = {
    params ["_allPlayers","_startTime"];

    _allPlayers = _allPlayers select {!isNull _x};
    INFO_1("All players have received and assembled database. Total time since start of function: %1.",(diag_tickTime - _startTime));
    [] remoteExec ["GRAD_replay_fnc_initReplay", _allPlayers, false];
};

private _onTimeout = {
    params ["_allPlayers","_startTime"];
    private _missingPlayers = _allPlayers select {!(_x getVariable ["grad_replay_playerReceiptComplete",false])};
    _allPlayers = _allPlayers select {!isNull _x};

    [] remoteExec ["GRAD_replay_fnc_initReplay", _allPlayers, false];
    INFO_1("Waiting for players timed out. Missing players: %1",_missingPlayers);
};

[_waitCondition,_onComplete,[_allPlayers,_startTime],45,_onTimeout] call CBA_fnc_waitUntilAndExecute;

// copyToClipboard str GRAD_REPLAY_DATABASE;
