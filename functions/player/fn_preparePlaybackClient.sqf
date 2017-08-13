#include "\z\ace\addons\main\script_component.hpp"

["Terminate"] call BIS_fnc_EGSpectator;
GCamKill = true;

{_x setMarkerAlphaLocal 0;} forEach allMapMarkers; // hide all markers for replay --> to be tested
	
if (dialog) then {closeDialog 0;};

// ["Starting Replay."] call EFUNC(common,displayTextStructured);

[player, true] call TFAR_fnc_forceSpectator;

[ "TIMER", "onEachFrame" ] call BIS_fnc_removeStackedEventHandler;
ctrlDelete (uiNamespace getVariable "GRAD_replay_rsc_loadingBar");
ctrlDelete (uiNamespace getVariable "GRAD_replay_txt_loading");
ctrlDelete (uiNamespace getVariable "GRAD_replay_txt_loadingInfo");

[] spawn GRAD_replay_fnc_startPlaybackClient;