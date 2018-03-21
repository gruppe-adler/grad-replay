// idea from a script by austin_medic
// completely reworked by nomisum for Gruppe Adler
GRAD_REPLAY_DATABASE_LOCAL = [];
GRAD_REPLAY_DATABASE_TARGET_COUNT_LOCAL = 999999; // something really high to prevent from finishing at once
GRAD_REPLAY_PLAYBACK_PAUSED = false;

if (!isServer) exitWith {};

params [["_precision", 1]];

// constants
GRAD_REPLAY_RECORDING_PAUSED = false;
GRAD_REPLAY_RECORDING_STOPPED = false;

GRAD_REPLAY_SENDING_DELAY = 0.1;

GRAD_REPLAY_SIDES = [west, east, civilian];
// vehicle setVariable ["GRAD_replay_track", true];
GRAD_REPLAY_AI_VEHICLES_TRACKED = false; 
GRAD_REPLAY_AI_ONFOOT_TRACKED = false;


GRAD_REPLAY_DATABASE_TEMP = [];
GRAD_REPLAY_DATABASE = [];

REPLAY_STEPS_PER_TICK = 1;

[_precision] call GRAD_replay_fnc_startRecord;

diag_log format ["grad replay: starting record"];



/* to start playback:

[] GRAD_replay_fnc_stopRecord;

*/
