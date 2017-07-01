// idea from a script by austin_medic
// completely reworked by nomisum for Gruppe Adler

if (!isServer) exitWith {};

params [["_precision", 3], ["_specialVehicle", objNull]];

// constants
GRAD_REPLAY_PAUSED = false;
GRAD_REPLAY_STOPPED = false;

GRAD_REPLAY_EMPTY_TRACKED = false;
GRAD_REPLAY_SIDES_TRACKED = [west, east, independent, civilian];
GRAD_REPLAY_AI_TRACKED = false;

GRAD_REPLAY_DATABASE_TEMP = [];
GRAD_REPLAY_DATABASE = [];

REPLAY_STEPS_PER_TICK = 3;

[_precision, _specialVehicle] call GRAD_replay_fnc_startRecord;



/* to start playback:

[] GRAD_replay_fnc_stopRecord;

*/