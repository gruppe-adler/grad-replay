#include "\z\ace\addons\main\script_component.hpp"

["Terminate"] call BIS_fnc_EGSpectator;
GCamKill = true;

{_x setMarkerAlphaLocal 0;} forEach allMapMarkers; // hide all markers for replay --> to be tested
	
if (!isNull (findDisplay 7810)) then {closeDialog 0;};

["Starting Replay."] call EFUNC(common,displayTextStructured);

[player, true] call TFAR_fnc_forceSpectator;

// remove blocking stuff
if ("ACE_MapTools" in (items player + assignedItems player)) then {
	player removeItem "ACE_MapTools";
};

if ("ItemCompass" in (items player + assignedItems player)) then {
	player removeItem "ItemCompass";
};

if ("ItemWatch" in (items player + assignedItems player)) then {
	player removeItem "ItemWatch";
};

[] spawn GRAD_replay_fnc_startPlaybackClient;