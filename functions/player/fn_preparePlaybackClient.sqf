#include "\z\ace\addons\main\script_component.hpp"

params ["_GRAD_REPLAY_DATABASE"];

{_x setMarkerAlphaLocal 0;} forEach allMapMarkers; // hide all markers for replay --> to be tested
	
if (!isNull (findDisplay 7810)) then {closeDialog 0;};
if (player getVariable ["ACE_isUnconscious", false]) then {
	forceRespawn player;
};

if (isMultiplayer) then {
	player enableSimulationGlobal false;
	player hideObjectGlobal true;
} else {
	player enableSimulation false;
	player hideObject true;
};

["Starting Replay."] call EFUNC(common,displayTextStructured);
openMap [true, false];
[player, true] call TFAR_fnc_forceSpectator;


[_GRAD_REPLAY_DATABASE] spawn GRAD_replay_fnc_startPlaybackClient;