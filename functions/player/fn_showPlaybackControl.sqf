createDialog "playbackControl";

if (serverCommandAvailable "#kick" || !isMultiplayer) then {

    (findDisplay 80000) displayAddEventHandler [
        "KeyDown",
        format ["if ((_this select 1) == 57) then {
            GRAD_REPLAY_PLAYBACK_PAUSED = !GRAD_REPLAY_PLAYBACK_PAUSED;

            if (GRAD_REPLAY_PLAYBACK_PAUSED) then {
                [] remoteExec ['GRAD_replay_fnc_showHintPause', [0,-2] select isDedicated, false];
            } else {
                [] remoteExec ['GRAD_replay_fnc_showHintPlay', [0,-2] select isDedicated, false];
            };

            publicVariable 'GRAD_REPLAY_PLAYBACK_PAUSED'; true
        };"]
    ];

};
