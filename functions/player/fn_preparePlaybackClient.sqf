#include "\z\ace\addons\main\script_component.hpp"

["Terminate"] call BIS_fnc_EGSpectator;
GCamKill = true;

{_x setMarkerAlphaLocal 0;} forEach allMapMarkers; // hide all markers for replay --> to be tested
	
if (dialog) then {closeDialog 0;};

// ["Starting Replay."] call EFUNC(common,displayTextStructured);

[player, true] call TFAR_fnc_forceSpectator;

[] spawn GRAD_replay_fnc_startPlaybackClient;