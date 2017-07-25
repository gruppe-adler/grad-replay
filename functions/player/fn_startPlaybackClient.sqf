#include "\z\ace\addons\main\script_component.hpp"

grad_replay_playbackPosition = 0;
grad_current_ehs = [];
grad_playback_finished = false;

diag_log format ["parsing replay at serverTime %1", serverTime];
GRAD_REPLAY_DATABASE = parseSimpleArray GRAD_REPLAY_DATABASE;
diag_log format ["playing replay at serverTime %1", serverTime];

// just in case he has no map
if (!("ItemMap" in (items player + assignedItems player))) then {
    player linkItem "itemMap";
};
waitUntil {"ItemMap" in (items player + assignedItems player)};
openMap [true, false];

[{
	// delete icons frame before
	if (count grad_current_ehs > 0) then {
		{
			((findDisplay 12) displayCtrl 51) ctrlRemoveEventHandler ["Draw", _x];
		} forEach grad_current_ehs;
	};
	grad_current_ehs = [];
	grad_current_playbackLoopPosition = 0;




    {
    		if (grad_current_playbackLoopPosition >= (count (GRAD_REPLAY_DATABASE select grad_replay_playbackPosition))) exitWith {};
    		
    		
    		

    		_fickediefackfack = grad_current_playbackLoopPosition;

			_eh = ((findDisplay 12) displayCtrl 51) ctrlAddEventHandler ["Draw",format [
				"[
                   _this select 0,
                   %1
                ] call GRAD_replay_fnc_drawIcon;", _fickediefackfack]
            ];
			grad_current_ehs = grad_current_ehs + [_eh];

            grad_current_playbackLoopPosition = grad_current_playbackLoopPosition + 1;

	} count (GRAD_REPLAY_DATABASE select grad_replay_playbackPosition);
	// you begin counting with 0, so delete 1

    

    // counter
    if (!grad_playback_finished) then {
        grad_replay_playbackPosition = grad_replay_playbackPosition + 1;
    };

    // end recording and start playback
    if (
    	grad_replay_playbackPosition >= count (GRAD_REPLAY_DATABASE) && 
    	!(grad_playback_finished)
    	) then {
    	grad_playback_finished = true;
    	grad_replay_playbackPosition = grad_replay_playbackPosition - 1;
    	[] spawn GRAD_replay_fnc_stopPlaybackClient;
	};

},0.1,[]] call CBA_fnc_addPerFrameHandler;