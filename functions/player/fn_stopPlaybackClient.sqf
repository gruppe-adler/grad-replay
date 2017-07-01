#include "\z\ace\addons\main\script_component.hpp"

["Replay finished."] call EFUNC(common,displayTextStructured);

sleep 6;
openMap [false,false];

REPLAY_FINISHED = true;
publicVariable "REPLAY_FINISHED";