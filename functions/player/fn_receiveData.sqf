params ["_count", "_index", "_playerCount"];

GRAD_REPLAY_DATABASE_TARGET_COUNT_LOCAL = _count;
[_count, _index, _playerCount] spawn GRAD_replay_fnc_showProgressBar;


// quit EG spec
if (["IsInitialized"] call BIS_fnc_EGSpectator) then {
	["Terminate"] call BIS_fnc_EGSpectator;
};


// quit ACE spec
if (!isNil "ace_spectator_isSet") then {
	[false] call ace_spectator_fnc_setSpectator;
};


// 
GRAD_CINEMACAM = objNull;


// quit gcam
GCamKill = true;


[player, true] call TFAR_fnc_forceSpectator;