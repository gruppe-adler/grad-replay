// idea from a script by austin_medic
// completely reworked by nomisum for Gruppe Adler
GRAD_REPLAY_DATABASE_LOCAL = [];
GRAD_REPLAY_DATABASE_TARGET_COUNT_LOCAL = 999999; // something really high to prevent from finishing at once
GRAD_REPLAY_PLAYBACK_PAUSED = false;
GRAD_REPLAY_SHOTANIMSPEED = 60;     // how fast projectiles move during replay in meters per 0.1s

if (!isServer) exitWith {};

GRAD_REPLAY_COLORS = [

    // side color IDs
    [0,0.3,0.6,1],          // 0: WEST
    [0.5,0,0,1],            // 1: EAST
    [0,0.5,0,1],            // 2: INDEPENDENT
    [0.4,0,0.5,1],          // 3: CIVILIAN
    [0.7,0.6,0,1],          // 4: SIDEEMPTY

    // unconscious IDs are currently hardcoded to be exactly +5 in fn_startRecord!
    [0,0.3,0.6,0.5],        // 5: WEST unconscious
    [0.5,0,0,0.5],          // 6: EAST unconscious
    [0,0.5,0,0.5],          // 7: INDEPENDENT unconscious
    [0.4,0,0.5,0.5],        // 8: CIVILIAN unconscious
    [0.7,0.6,0,0.5],        // 9: SIDEEMPTY unconscious

    // other
    [0.2,0.2,0.2,0.5]      // 10: dead unit

    // NOTE: this color array can change during recording
];

// constants
GRAD_REPLAY_DATABASE = [];
GRAD_REPLAY_RECORDING_PAUSED = false;
GRAD_REPLAY_RECORDING_STOPPED = false;
GRAD_REPLAY_SENDING_DELAY = 0.05;


// vehicle setVariable ["GRAD_replay_track", true];

if (isNil "GRAD_REPLAY_SIDES") then {
    GRAD_REPLAY_SIDES = ([(missionConfigFile >> "GRAD_Replay"), "trackedSides", ["west", "east", "civilian"]] call BIS_fnc_returnConfigEntry) apply {call compile _x};
};
if (isNil "GRAD_REPLAY_AI_VEHICLES_TRACKED") then {
    GRAD_REPLAY_AI_VEHICLES_TRACKED = ([(missionConfigFile >> "GRAD_Replay"), "trackedVehicles", 0] call BIS_fnc_returnConfigEntry) == 1;
};
if (isNil "GRAD_REPLAY_AI_ONFOOT_TRACKED") then {
    GRAD_REPLAY_AI_ONFOOT_TRACKED = ([(missionConfigFile >> "GRAD_Replay"), "trackedAI", 0] call BIS_fnc_returnConfigEntry) == 1;
};
if (isNil "REPLAY_STEPS_PER_TICK") then {
    REPLAY_STEPS_PER_TICK = [(missionConfigFile >> "GRAD_Replay"), "stepsPerTick", 1] call BIS_fnc_returnConfigEntry;
};
if (isNil "GRAD_REPLAY_SENDING_CHUNK_SIZE") then {
    GRAD_REPLAY_SENDING_CHUNK_SIZE = [(missionConfigFile >> "GRAD_Replay"), "sendingChunkSize", 10] call BIS_fnc_returnConfigEntry;
};
if (isNil "GRAD_REPLAY_TRACKSHOTS") then {
    GRAD_REPLAY_TRACKSHOTS = ([(missionConfigFile >> "GRAD_Replay"), "trackShots", 0] call BIS_fnc_returnConfigEntry) == 1;
};
if (isNil "GRAD_REPLAY_PRECISION") then {
    GRAD_REPLAY_PRECISION = [(missionConfigFile >> "GRAD_Replay"), "precision", 1] call BIS_fnc_returnConfigEntry;
};

if (GRAD_REPLAY_TRACKSHOTS) then {
    ["CAManBase","firedMan",{_this call grad_replay_fnc_onFiredMan}] call CBA_fnc_addClassEventHandler;
};

[] call GRAD_replay_fnc_startRecord;

/* to start playback:
[] GRAD_replay_fnc_stopRecord;
*/

