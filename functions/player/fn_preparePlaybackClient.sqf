#include "\z\ace\addons\main\script_component.hpp"

{_x setMarkerAlphaLocal 0;} forEach allMapMarkers; // hide all markers for replay --> to be tested
	
if (!isNull (findDisplay 7810)) then {closeDialog 0};
if (player getVariable ["ACE_isUnconscious", false]) then {
	forceRespawn player;
};

["Starting Replay."] call EFUNC(common,displayTextStructured);
openMap [true,true];
[player, true] call TFAR_fnc_forceSpectator;