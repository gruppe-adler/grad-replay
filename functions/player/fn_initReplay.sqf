if (player getVariable ["ACE_isUnconscious", false]) exitWith {
	forceRespawn player;
};

[] call GRAD_replay_fnc_preparePlaybackClient;