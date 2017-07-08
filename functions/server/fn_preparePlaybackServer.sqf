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

	// remove ace blu force tracking marker
	
	ace_map_BFT_Enabled = false;
	ace_map_mapShake = false;
	call ACE_map_fnc_blueForceTrackingUpdate;
	
	publicVariable "ace_map_BFT_Enabled";
	publicVariable "ace_map_mapShake";
	
	[GRAD_REPLAY_DATABASE] remoteExec ["GRAD_replay_fnc_preparePlaybackClient", [0,-2] select isDedicated, false];
		
};
