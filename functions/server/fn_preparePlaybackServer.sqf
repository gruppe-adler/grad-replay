#include "\z\ace\addons\main\script_component.hpp"

if (isServer || isDedicated) then {
	
	{ 
		if (isMultiplayer) then {
			_x enableSimulationGlobal false; 
		} else {
			_x enableSimulation false;
		};

		_x setVariable ["ace_map_hideBlueForceMarker", true];

	} forEach allUnits;
	
	publicVariable "GRAD_REPLAY_DATABASE";
	[] remoteExec ["GRAD_replay_fnc_preparePlaybackClient", allPlayers, false];
		
};
