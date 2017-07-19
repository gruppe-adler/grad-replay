["Terminate"] call BIS_fnc_EGSpectator;
GCamKill = true;

// just in case he has no map
player linkItem "itemMap";

{_x setMarkerAlphaLocal 0;} forEach allMapMarkers; // hide all markers for replay --> to be tested
	
if (!isNull (findDisplay 7810)) then {closeDialog 0;};

["Starting Replay."] call EFUNC(common,displayTextStructured);

openMap [true, false];
[player, true] call TFAR_fnc_forceSpectator;

// remove blocking stuff
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