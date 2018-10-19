params ["_unit","_veh","_isVehicle","_isEmptyVehicle","_isMan"];

// always track things
if (!_isVehicle && !_isMan) exitWith {true};

// always track empty vehicles
if (_isEmptyVehicle) exitWith {true};

// never track non empty vehicle objects (only effective commander has icon)
if (_isVehicle) exitWith {false};

// never track more than the effective commander in a vehicle to avoid duplicate icons
if (effectiveCommander _veh != _unit) exitWith {false};

// always track if explicitly set by user
if (_unit getVariable ["grad_replay_track",false]) exitWith {true};

// always track players
if (isPlayer _unit) exitWith {true};

// only track AI if in included sides
if ((side _unit) in GRAD_REPLAY_SIDES && (_unit getVariable ["grad_gcamspec_firstSpawn", true])) exitWith {true};

false
