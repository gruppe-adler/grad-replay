#include "\z\ace\addons\main\script_component.hpp"

grad_current_ehs = [];
grad_playback_finished = false;
grad_replay_playbackPosition = 0;
grad_current_playbackLoopPosition = 0;

// GRAD_REPLAY_DATABASE_LOCAL = parseSimpleArray GRAD_REPLAY_DATABASE_LOCAL;
diag_log format ["playing replay at serverTime %1", serverTime];


// openMap [true, false];

[] call GRAD_replay_fnc_showPlaybackControl;

[{
    params ["_args", "_handle"];

	// delete icons frame before
	if (count grad_current_ehs > 0) then {
		{
			((findDisplay 80000) displayCtrl 1337) ctrlRemoveEventHandler ["Draw", _x];
		} forEach grad_current_ehs;
	};

    grad_current_ehs = []; // reset eventhandler draws
    grad_current_playbackLoopPosition = 0; // reset loop
    
    // adjust progressbar
    if (!isNull (findDisplay 80000)) then {
        sliderSetPosition [80003, linearConversion [0,count GRAD_REPLAY_DATABASE_LOCAL,grad_replay_playbackPosition,0,10]];
        ((findDisplay 80000) displayCtrl 80003) ctrlSetTooltip format ["%1 | %2", grad_replay_playbackPosition, count GRAD_REPLAY_DATABASE_LOCAL - 1];
    };

    {
            private _fickediefackfack = grad_current_playbackLoopPosition;

			private _eh = ((findDisplay 80000) displayCtrl 1337) ctrlAddEventHandler ["Draw",
                format [
    				"[
                       _this select 0,
                       %1
                    ] call GRAD_replay_fnc_drawIcon;", 
                _fickediefackfack]
            ];
			grad_current_ehs append [_eh];

            if (grad_current_playbackLoopPosition < (count (GRAD_REPLAY_DATABASE_LOCAL select (grad_replay_playbackPosition))) - 1) then {
                grad_current_playbackLoopPosition = grad_current_playbackLoopPosition + 1;
            };
    
    } forEach (GRAD_REPLAY_DATABASE_LOCAL select grad_replay_playbackPosition);
    
    // end playback
    if (
    	   grad_replay_playbackPosition >= (count (GRAD_REPLAY_DATABASE_LOCAL) - 1) && 
           count (GRAD_REPLAY_DATABASE_LOCAL) >= GRAD_REPLAY_DATABASE_TARGET_COUNT_LOCAL &&
    	   !(grad_playback_finished)
    	) exitWith {
            diag_log format ["playbackpos: %1, count: %2, count target: %3", 
                grad_replay_playbackPosition, 
                count (GRAD_REPLAY_DATABASE_LOCAL), 
                GRAD_REPLAY_DATABASE_TARGET_COUNT_LOCAL
            ];

            if ((isMultiplayer && !(serverCommandAvailable "#kick")) || !isMultiplayer) then {
                [] remoteExec ["GRAD_replay_fnc_showHintReplayFinished", [0,-2] select isDedicated];
            };

        	grad_playback_finished = true;
        	// grad_replay_playbackPosition = grad_replay_playbackPosition - 1;
            [_handle] call CBA_fnc_removePerFrameHandler;
        	[] spawn GRAD_replay_fnc_stopPlaybackClient;
            ((findDisplay 80000) displayCtrl 80003) ctrlEnable false;
        
	};

     // counter
    if (!grad_playback_finished && !GRAD_REPLAY_PLAYBACK_PAUSED) then {
        grad_replay_playbackPosition = grad_replay_playbackPosition + 1;
        [grad_replay_playbackPosition] call GRAD_replay_fnc_setTimeDisplay;

        if (!dialog) then {
            [] call GRAD_replay_fnc_showPlaybackControl;
        };
    };

   

},0.1,[]] call CBA_fnc_addPerFrameHandler;

// admin client syncs his progress
if (isMultiplayer && !(serverCommandAvailable "#kick")) exitWith {};

[{
    [grad_replay_playbackPosition] remoteExec ["GRAD_replay_fnc_syncPlaybackPos", [0,-2] select isDedicated, false];
},1,[]] call CBA_fnc_addPerFrameHandler;