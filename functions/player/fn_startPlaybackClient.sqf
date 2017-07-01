#include "\z\ace\addons\main\script_component.hpp"

params ["_database"];

grad_replay_playbackPosition = 0;

[{
    params ["_args", "_handle"];
    _args params ["_database"];

    grad_replay_playbackPosition = grad_replay_playbackPosition + REPLAY_STEPS_PER_TICK;

    for [{_k=0}, {_k < (count _database select grad_replay_playbackPosition)}, {_k=_k+1}] do {
		
		((findDisplay 12) displayCtrl 51) ctrlAddEventHandler ["Draw", {
			    [_this, _database] call GRAD_replay_drawIcon;
		}];

	};


    // end recording and start playback
    if (grad_replay_playbackPosition >= count _database) then {
    	[_handle] call CBA_fnc_removePerFrameHandler;

    	["Replay finished."] call EFUNC(common,displayTextStructured);

		sleep 6;
		openMap [false,true];

		REPLAY_FINISHED = true;
		publicVariable "REPLAY_FINISHED";
	};

},1,[_database]] call CBA_fnc_addPerFrameHandler;