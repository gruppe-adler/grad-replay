#include "\z\ace\addons\main\script_component.hpp"

if (isServer || isDedicated) then {
	
	{ _x enableSimulationGlobal false; } forEach allPlayers;
	
	publicVariable "GRAD_REPLAY_DATABASE";
	[] remoteExec ["GRAD_replay_fnc_preparePlaybackClient", 0, false];
		
};
