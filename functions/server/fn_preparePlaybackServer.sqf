#include "\z\ace\addons\main\script_component.hpp"

if (isServer || isDedicated) then {
	
	{ _x enableSimulationGlobal false; } forEach allPlayers;
	
	[] remoteExec ["GRAD_replay_fnc_preparePlaybackClient.sqf", 0, false];
	[GRAD_REPLAY_DATABASE] remoteExec ["GRAD_replay_fnc_startPlaybackClient.sqf", 0, false];
		
};
