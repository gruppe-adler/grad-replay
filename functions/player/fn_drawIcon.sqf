params ["_map", "_blub"];

_icon = [GRAD_REPLAY_DATABASE, grad_replay_playbackPosition, _blub, 0] call GRAD_replay_fnc_getRecordEntry;
_color = [GRAD_REPLAY_DATABASE, grad_replay_playbackPosition, _blub, 1] call GRAD_replay_fnc_getRecordEntry;
_pos = [GRAD_REPLAY_DATABASE, grad_replay_playbackPosition, _blub, 2] call GRAD_replay_fnc_getRecordEntry;
_dir = [GRAD_REPLAY_DATABASE, grad_replay_playbackPosition, _blub, 3] call GRAD_replay_fnc_getRecordEntry;


diag_log format ["%1, %2, %3, %4, %5, %6", _map, _icon, _color, _pos, _dir, _blub];

_map drawIcon [
			_icon,
			_color,
			_pos,
			24,
			24,
			_dir,
			'.', 
			1, 
			0.03, 
			'TahomaB', 
			'right'
		];