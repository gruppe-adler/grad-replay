#include "\z\ace\addons\main\script_component.hpp"

params ["_GRAD_REPLAY_DATABASE"];

grad_replay_playbackPosition = 0;
grad_replay_current_ehs = [];
grad_replay_isPlaybackFinished = false;

diag_log format ["_GRAD_REPLAY_DATABASE is %1", _GRAD_REPLAY_DATABASE];

[{
    params ["_args", "_handle"];
    _args params ["_GRAD_REPLAY_DATABASE"];

    

	[grad_replay_current_ehs] call GRAD_replay_fnc_removeDrawEventhandler;

    // reset everything
	grad_replay_current_ehs = [];
	grad_replay_current_playbackLoopPosition = 0;


    // counter
    if (!grad_replay_isPlaybackFinished) then {
        grad_replay_playbackPosition = grad_replay_playbackPosition + 1;
    };

    // diag_log format ["_GRAD_REPLAY_DATABASE has %1 entries, grad_replay_playbackPosition is %2", count _GRAD_REPLAY_DATABASE, grad_replay_playbackPosition];

    {
            if (grad_replay_current_playbackLoopPosition >= count (_GRAD_REPLAY_DATABASE select grad_replay_playbackPosition)) exitWith {};

    		grad_replay_current_playbackLoopPosition = grad_replay_current_playbackLoopPosition + 1;
    		
    	
            _currentPlayBackPosition = grad_replay_playbackPosition;
            _fickediefackfack = grad_replay_current_playbackLoopPosition;

            // diag_log format ["_GRAD_REPLAY_DATABASE current selection is %1", _GRAD_REPLAY_DATABASE select grad_replay_playbackPosition];
            // diag_log format ["_currentPlayBackPosition is %1, _fickediefackfack is %2 ", _currentPlayBackPosition, _fickediefackfack];

			_eh = ((findDisplay 12) displayCtrl 51) ctrlAddEventHandler 
            ["Draw",format [
    				"[
                       _this select 0,
                       %1,
                       %2,
                       %3
                    ] call GRAD_replay_fnc_drawIcon;", _GRAD_REPLAY_DATABASE, _currentPlayBackPosition, _fickediefackfack]
            ];
            
			grad_replay_current_ehs pushBack _eh;



	} forEach (_GRAD_REPLAY_DATABASE select grad_replay_playbackPosition);
	// you begin counting with 0

    

    // end recording and start playback
    if (grad_replay_playbackPosition >= (count (_GRAD_REPLAY_DATABASE) - 1) && !(grad_replay_isPlaybackFinished)) then {
        	grad_replay_isPlaybackFinished = true;
        	grad_replay_playbackPosition = grad_replay_playbackPosition - 1; // reset to last frame
        	[] spawn GRAD_replay_fnc_stopPlaybackClient;
	};

},0.1,[_GRAD_REPLAY_DATABASE]] call CBA_fnc_addPerFrameHandler;