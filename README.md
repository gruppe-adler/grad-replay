[![Release](https://img.shields.io/github/release/gruppe-adler/grad-replay.svg)](https://github.com/gruppe-adler/grad-replay/release)
[![License](https://img.shields.io/github/license/gruppe-adler/grad-replay.svg)](https://github.com/gruppe-adler/grad-replay/license)

# grad-replay
ARMA3 mission replay script (working but wip)
* Records player and AI movement and replays at end of mission.
* Meant for PvP but pimped to support AI as well
* Mission duration should be matched to replay precision (see below) - the longer the mission, the less precision is recommended. Better precision (smaller values) results in longer loading times.

### Required Mods
CBA, ACE3

# How to install
### 1. Download Release
### 2. extract GRAD_replay folder into [mission folder]/node_modules
### 3. Add the following to the description.ext

```
#include "node_modules\@gruppe-adler\replay\ui\defines.hpp"
#include "node_modules\@gruppe-adler\replay\ui\dialog.hpp"
```

```
// if CfgFunctions already exists, just put the #include part inside
class CfgFunctions {
  #include "node_modules\@gruppe-adler\replay\cfgFunctions.hpp"
 };
```
### 4. Initialize script in init.sqf
`[2] call GRAD_replay_fnc_init; // number is precision of replay, 2 means every 2 seconds one snapshot`

### 5. Put this where you want the replay to start (recommended: end of mission)
Must be executed on server only!
```
// stops record, sends data and starts replay
call GRAD_replay_fnc_stopRecord; 

// ends mission after replay is over
[{
	REPLAY_FINISHED
}, {
   ["END1"] remoteExec ["endMission",0,false]; // your custom end mission call or whatever you want to do after replay
}, []] call CBA_fnc_waitUntilAndExecute;
```

### Important
Currently there is **no helper function to resume normal gameplay after replay has played**, this means all assets will be frozen and TFAR spectator channel will be set for all players, furthermore every wound will be healed and all spectator cams left.

### Customization
change variables in functions/server/fn_init.sqf

* `GRAD_REPLAY_SIDES` sides tracked
* `GRAD_REPLAY_AI_VEHICLES_TRACKED` if ai vehicles are tracked
* `GRAD_REPLAY_AI_ONFOOT_TRACKED` if ai on foot is tracked
* `REPLAY_STEPS_PER_TICK` steps played back at once

### Script commands
to pause recording, set `GRAD_REPLAY_RECORDING_PAUSED` to true on server / false to resume
