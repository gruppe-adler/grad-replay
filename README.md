# grad_replay
arma3 in-game mission replay script (working but wip)

records player and AI movement and replays at end of mission

## required mods
CBA

# How to install
### 1. Download Release
### 2. extract GRAD_replay folder into <mission folder>/node_modules
### 3. Add the following to the description.ext

```
#include "node_modules\grad_replay\ui\defines.hpp"
#include "node_modules\grad_replay\ui\dialog.hpp"
```

```
// if CfgFunctions already exists, just put the #include part inside
class CfgFunctions {
  #include "node_modules\grad_replay\cfgFunctions.hpp"
 };
```
### 4. Initialize script
Init.sqf:
`[2] call GRAD_replay_fnc_init; // number is precision of replay, 2 means every 2 seconds one snapshot`

### 5. Catch the ending of your mission and put this before
Must be executed on server only!
```
call GRAD_replay_fnc_stopRecord;

[{
	REPLAY_FINISHED
}, {
   ["END1"] remoteExec ["endMission",0,false]; // your custom end mission call or whatever you want to do after replay
}, []] call CBA_fnc_waitUntilAndExecute;
```

### Customization
change variables in functions/server/fn_init.sqf

* `GRAD_REPLAY_SIDES` sides tracked
* `GRAD_REPLAY_AI_VEHICLES_TRACKED` if ai vehicles are tracked
* `GRAD_REPLAY_AI_ONFOOT_TRACKED` if ai on foot is tracked
* `REPLAY_STEPS_PER_TICK` steps played back at once

### Script commands
to pause recording, set `GRAD_REPLAY_RECORDING_PAUSED` to true on server / false to resume
