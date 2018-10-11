params ["_unit","_veh","_isEmptyVehicle"];


// always track empty vehicles
if (_isEmptyVehicle) exitWith {true};

// never track non-driver units in vehicles to avoid duplicate icons
if (_unit isKindOf "Man" && {driver _veh != _unit}) exitWith {false};

// always track if explicitly set by user
if (_unit getVariable ["grad_replay_track",false]) exitWith {true};

// always track players
if (isPlayer _unit) exitWith {true};

// only track AI if in included sides
if ((side _unit) in GRAD_REPLAY_SIDES && (_unit getVariable ["grad_gcamspec_firstSpawn", true])) exitWith {true};

false
