#include "script_component.hpp"

grad_current_ehs = [];
grad_playback_finished = false;
grad_replay_playbackPosition = 0;
grad_current_playbackLoopPosition = 0;

INFO_1("Playing replay at serverTime %1.", serverTime);

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
        sliderSetPosition [80003, linearConversion [0,count GRAD_REPLAY_DATABASE_LOCAL_ASSEMBLED,grad_replay_playbackPosition,0,10]];
        ((findDisplay 80000) displayCtrl 80003) ctrlSetTooltip format ["%1 | %2", grad_replay_playbackPosition, count GRAD_REPLAY_DATABASE_LOCAL_ASSEMBLED - 1];
    };

    {
        private _fickediefackfack = grad_current_playbackLoopPosition;
        private _map = ((findDisplay 80000) displayCtrl 1337);

        private _eh = _map ctrlAddEventHandler ["Draw",
            format [
                "[
                   _this select 0,
                   %1
                ] call GRAD_replay_fnc_drawIcon;",
            _fickediefackfack]
        ];

        [_map,_fickediefackfack] call grad_replay_fnc_animateShot;

        grad_current_ehs pushBack _eh;

        if (grad_current_playbackLoopPosition < (count (GRAD_REPLAY_DATABASE_LOCAL_ASSEMBLED select (grad_replay_playbackPosition))) - 1) then {
            grad_current_playbackLoopPosition = grad_current_playbackLoopPosition + 1;
        };

    } forEach (GRAD_REPLAY_DATABASE_LOCAL_ASSEMBLED select grad_replay_playbackPosition);

    // end playback
    if (
           grad_replay_playbackPosition >= (count (GRAD_REPLAY_DATABASE_LOCAL_ASSEMBLED) - 1) &&
           count (GRAD_REPLAY_DATABASE_LOCAL_ASSEMBLED) >= GRAD_REPLAY_DATABASE_TARGET_COUNT_LOCAL &&
           !(grad_playback_finished)
        ) exitWith {
            INFO_3("playbackpos: %1, count: %2, count target: %3",grad_replay_playbackPosition,count (GRAD_REPLAY_DATABASE_LOCAL_ASSEMBLED),GRAD_REPLAY_DATABASE_TARGET_COUNT_LOCAL);

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
