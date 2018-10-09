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
_replayLength = count GRAD_REPLAY_DATABASE;
INFO_1("Started sending replay at serverTime %1",serverTime);
INFO_1("Replay length is %1",_replayLength);

private _allPlayers = allPlayers - entities "HeadlessClient_F";

// set every client to know whats his number in line and display progress bar
{
	[_replayLength, _forEachIndex + 1, count _allPlayers] remoteExec ["GRAD_replay_fnc_receiveData", _x];
} forEach _allPlayers;

// send to all clients at once, but one tidbit after another --> hopefully this works
{
	[_x, _forEachIndex] remoteExecCall ["GRAD_replay_fnc_addReplayPart", _allPlayers];
	sleep GRAD_REPLAY_SENDING_DELAY; // set to zero for debugging ordering
} forEach GRAD_REPLAY_DATABASE;

// wait until all clients have received all the data and assembled it
[
	{{!(_x getVariable ["grad_replay_playerReceivalComplete",false])} count (_this select 0) == 0},
	{[] remoteExec ["GRAD_replay_fnc_initReplay", _this select 0, false]},
	[_allPlayers],
	30,
	{
		[] remoteExec ["GRAD_replay_fnc_initReplay", _this select 0, false];
		INFO_1("Waiting for players timed out. Missing players: %1",(_this select 0) select {!(_x getVariable ["grad_replay_playerReceivalComplete",false])});
	}
] call CBA_fnc_waitUntilAndExecute;

// copyToClipboard str GRAD_REPLAY_DATABASE;
