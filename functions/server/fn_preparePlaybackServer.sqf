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
	
 	["Standby. Replay is loading...", 1.5, ACE_player, 20] remoteExec ["ace_common_displayTextStructured", allPlayers, false]; 

	missionnamespace setVariable ["GRAD_replay_isRunning", true, true];
	GRAD_REPLAY_DATABASE = str GRAD_REPLAY_DATABASE;
	publicVariable "GRAD_REPLAY_DATABASE";
	
	diag_log format ["sending replay at serverTime %1", serverTime];
	[] remoteExec ["GRAD_replay_fnc_initReplay", allPlayers, false];

	// copyToClipboard str GRAD_REPLAY_DATABASE;

};
