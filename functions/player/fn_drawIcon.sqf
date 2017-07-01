params ["_map", "_database"];

// _unit,_side,_pos,_dir,_special,_veh
_unit = [_database, grad_replay_playbackPosition, 0] call getRecordEntry;
_color = [_database, grad_replay_playbackPosition, 1] call getRecordEntry;
_pos = [_database, grad_replay_playbackPosition, 2] call getRecordEntry;
_dir = [_database, grad_replay_playbackPosition, 3] call getRecordEntry;
_special = [_database, grad_replay_playbackPosition, 4] call getRecordEntry;
_veh = [_database, grad_replay_playbackPosition, 5] call getRecordEntry;

_theMap drawIcon [
	_unit, 
	_color, 
	_pos, 
	0.5/ctrlMapScale (_this select 0),
    0.5/ctrlMapScale (_this select 0), 
	_dir,
	"", 
	0
];