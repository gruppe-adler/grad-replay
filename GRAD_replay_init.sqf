// idea from a script by austin_medic
// completely reworked by nomisum for Gruppe Adler

if (!isServer) exitWith {};


params [["_precision", 1]];

// constants
GRAD_REPLAY_PAUSED = false;
GRAD_REPLAY_STOPPED = false;

GRAD_REPLAY_SIDES = [west, east, civilian, sideLogic, sideEmpty];
GRAD_REPLAY_EMPTY_TRACKED = true; // vehicle setVariable ["GRAD_replay_track", true];
GRAD_REPLAY_CIVILIAN_TRAFFIC_TRACKED = false;
GRAD_REPLAY_CIVILIAN_ONFOOT_TRACKED = false;

GRAD_REPLAY_DATABASE_TEMP = [];
GRAD_REPLAY_DATABASE = [];

REPLAY_STEPS_PER_TICK = 1;


[_precision] call GRAD_replay_fnc_startRecord;

diag_log format ["grad replay: starting record"];



/* to start playback:

[] GRAD_replay_fnc_stopRecord;

*/