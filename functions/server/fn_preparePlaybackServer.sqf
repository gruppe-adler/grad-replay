#include "script_component.hpp"

if (!isServer) exitWith {};

{
	if (isMultiplayer) then {
		_x enableSimulationGlobal false;

		// freeze vehicle
		if (!(vehicle _x isEqualTo _x) && _x isEqualTo (driver vehicle _x)) then {
				vehicle _x attachTo [_x];
		};
	} else {
		_x enableSimulation false;
	};

	_x setVariable ["ace_map_hideBlueForceMarker", true];

} forEach allUnits;

// remove ace blu force tracking marker

ace_map_BFT_Enabled = false;
ace_map_mapShake = false;
// call ACE_map_fnc_blueForceTrackingUpdate;

publicVariable "ace_map_BFT_Enabled";
publicVariable "ace_map_mapShake";


missionnamespace setVariable ["GRAD_replay_isRunning", true, true];

INFO("Sending database to clients.");
private _startTime = diag_tickTime;

_replayLength = count GRAD_REPLAY_DATABASE;
INFO_1("Replay length is %1",_replayLength);

private _allPlayers = allPlayers - entities "HeadlessClient_F";

// set every client to know whats his number in line and display progress bar
{
	[_replayLength, _forEachIndex + 1, count _allPlayers] remoteExec ["GRAD_replay_fnc_receiveData", _x];
} forEach _allPlayers;

// send to all clients at once, but one tidbit after another --> hopefully this works
for [{_i=0},{_i < ceil (_replayLength / GRAD_REPLAY_SENDING_CHUNK_SIZE)},{_i=_i+1}] do {
	_startIndex = _i * GRAD_REPLAY_SENDING_CHUNK_SIZE;
	_endIndex = _startIndex + GRAD_REPLAY_SENDING_CHUNK_SIZE;
	if (_endIndex >= _replayLength) then {_endIndex = _replayLength - 1};

	_chunk = [];
	for [{_j=_startIndex},{_j<=_endIndex},{_j=_j+1}] do {
	    _chunk pushBack (GRAD_REPLAY_DATABASE select _j);
	};

	[_chunk,_startIndex] remoteExecCall ["GRAD_replay_fnc_addReplayPart", _allPlayers];
	sleep GRAD_REPLAY_SENDING_DELAY; // set to zero for debugging ordering
};

INFO_1("Database sending completed in %1s.",(diag_tickTime - _startTime));

// wait until all clients have received all the data and assembled it
private _waitCondition = {
	{!(_x getVariable ["grad_replay_playerReceivalComplete",false])} count (_this select 0) == 0
};
private _onComplete = {
	INFO_1("All players have received and assembled database. Total time since start of function: %1.",(diag_tickTime - (_this select 1)));
	[] remoteExec ["GRAD_replay_fnc_initReplay", _this select 0, false];
};
private _onTimeout = {
	[] remoteExec ["GRAD_replay_fnc_initReplay", _this select 0, false];
	_missingPlayers = (_this select 0) select {!(_x getVariable ["grad_replay_playerReceivalComplete",false])};
	INFO_1("Waiting for players timed out. Missing players: %1",_missingPlayers);
};
[_waitCondition,_onComplete,[_allPlayers,_startTime],30,_onTimeout] call CBA_fnc_waitUntilAndExecute;

// copyToClipboard str GRAD_REPLAY_DATABASE;
