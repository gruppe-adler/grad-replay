#include "\z\ace\addons\main\script_component.hpp"

params ["GRAD_REPLAY_DATABASE"];

grad_replay_playbackPosition = 0;
grad_replay_current_ehs = [];
grad_replay_isPlaybackFinished = false;



[{
    params ["_args", "_handle"];
    _args params ["GRAD_REPLAY_DATABASE"];

	[grad_replay_current_ehs] call GRAD_replay_fnc_removeDrawEventhandler;

    // reset everything
	grad_replay_current_ehs = [];
	grad_replay_current_playbackLoopPosition = 0;


    diag_log format ["GRAD_REPLAY_DATABASE has %1 entries, grad_replay_playbackPosition is %2", count GRAD_REPLAY_DATABASE, grad_replay_playbackPosition];
    {
            if (grad_replay_current_playbackLoopPosition >= count ((GRAD_REPLAY_DATABASE select grad_replay_playbackPosition) - 1)) exitWith {};

    		grad_replay_current_playbackLoopPosition = grad_replay_current_playbackLoopPosition + 1;
    		
    		
    		_fickediefackfack = grad_replay_current_playbackLoopPosition;

			_eh = ((findDisplay 12) displayCtrl 51) ctrlAddEventHandler ["Draw",format [
				"[
                   _this select 0,
                   %1
                ] call GRAD_replay_fnc_drawIcon;", _fickediefackfack]
            ];
			grad_replay_current_ehs = grad_replay_current_ehs + [_eh];



	} count (GRAD_REPLAY_DATABASE select grad_replay_playbackPosition);
	// you begin counting with 0

    // counter
    if (!grad_replay_isPlaybackFinished) then {
        grad_replay_playbackPosition = grad_replay_playbackPosition + 1;
    };

    // end recording and start playback
    if (
    	grad_replay_playbackPosition >= count (GRAD_REPLAY_DATABASE) && 
    	!(grad_replay_isPlaybackFinished)
    	) then {
    	grad_replay_isPlaybackFinished = true;
    	grad_replay_playbackPosition = grad_replay_playbackPosition - 1; // reset to last frame
    	[] spawn GRAD_replay_fnc_stopPlaybackClient;
	};

},0.1,[GRAD_REPLAY_DATABASE]] call CBA_fnc_addPerFrameHandler;