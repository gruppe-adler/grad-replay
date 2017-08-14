#include "\z\ace\addons\main\script_component.hpp"
// ["Replay finished."] call EFUNC(common,displayTextStructured);

//disableSerialization;
uiSleep 5;
// openMap [false,false];
if (dialog) then {closeDialog 2;};
REPLAY_FINISHED = true;
publicVariable "REPLAY_FINISHED";