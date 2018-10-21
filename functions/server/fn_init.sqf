// idea from a script by austin_medic
// completely reworked by nomisum for Gruppe Adler
GRAD_REPLAY_DATABASE_LOCAL = [];
GRAD_REPLAY_DATABASE_TARGET_COUNT_LOCAL = 999999; // something really high to prevent from finishing at once
GRAD_REPLAY_PLAYBACK_PAUSED = false;
GRAD_REPLAY_SHOTANIMSPEED = 60;     // how fast projectiles move during replay in meters per 0.1s

if (!isServer) exitWith {};

// constants
GRAD_REPLAY_RECORDING_PAUSED = false;
GRAD_REPLAY_RECORDING_STOPPED = false;
GRAD_REPLAY_SENDING_DELAY = 0.05;
GRAD_REPLAY_DATABASE = [];

// vehicle setVariable ["GRAD_replay_track", true];

GRAD_REPLAY_SIDES = ([(missionConfigFile >> "GRAD_Replay"), "trackedSides", ["west", "east", "civilian"]] call BIS_fnc_returnConfigEntry) apply {call compile _x};
GRAD_REPLAY_AI_VEHICLES_TRACKED = ([(missionConfigFile >> "GRAD_Replay"), "trackedVehicles", 0] call BIS_fnc_returnConfigEntry) == 1;
GRAD_REPLAY_AI_ONFOOT_TRACKED = ([(missionConfigFile >> "GRAD_Replay"), "trackedAI", 0] call BIS_fnc_returnConfigEntry) == 1;
REPLAY_STEPS_PER_TICK = [(missionConfigFile >> "GRAD_Replay"), "stepsPerTick", 1] call BIS_fnc_returnConfigEntry;
GRAD_REPLAY_SENDING_CHUNK_SIZE = [(missionConfigFile >> "GRAD_Replay"), "sendingChunkSize", 10] call BIS_fnc_returnConfigEntry;
GRAD_REPLAY_TRACKSHOTS = ([(missionConfigFile >> "GRAD_Replay"), "trackShots", 0] call BIS_fnc_returnConfigEntry) == 1;
private _precision = [(missionConfigFile >> "GRAD_Replay"), "precision", 1] call BIS_fnc_returnConfigEntry;

if (GRAD_REPLAY_TRACKSHOTS) then {
    ["CAManBase","firedMan",{_this call grad_replay_fnc_onFiredMan}] call CBA_fnc_addClassEventHandler;
};

[_precision] call GRAD_replay_fnc_startRecord;

/* to start playback:
[] GRAD_replay_fnc_stopRecord;
*/
