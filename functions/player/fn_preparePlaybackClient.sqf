#include "\z\ace\addons\main\script_component.hpp"

{_x setMarkerAlphaLocal 0;} forEach allMapMarkers; // hide all markers for replay --> to be tested
	
if (!isNull (findDisplay 7810)) then {closeDialog 0;};

forceRespawn player;

[player] remoteExec ["GRAD_replay_fnc_setMeSpectator", 2, false];

["Starting Replay."] call EFUNC(common,displayTextStructured);

player linkItem "itemMap";

openMap [true, false];
[player, true] call TFAR_fnc_forceSpectator;



if ("ACE_MapTools" in items player) then {
	player removeItem "ACE_MapTools";
};

if ("ItemCompass" in items player) then {
	player removeItem "ItemCompass";
};

if ("ItemWatch" in items player) then {
	player removeItem "ItemWatch";
};


[] spawn GRAD_replay_fnc_startPlaybackClient;