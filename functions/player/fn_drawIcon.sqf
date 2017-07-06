params ["_map", "_blub"];

_icon = [GRAD_REPLAY_DATABASE, grad_replay_playbackPosition, _blub, 0] call GRAD_replay_fnc_getRecordEntry;
_color = [GRAD_REPLAY_DATABASE, grad_replay_playbackPosition, _blub, 1] call GRAD_replay_fnc_getRecordEntry;
_pos = [GRAD_REPLAY_DATABASE, grad_replay_playbackPosition, _blub, 2] call GRAD_replay_fnc_getRecordEntry;
_dir = [GRAD_REPLAY_DATABASE, grad_replay_playbackPosition, _blub, 3] call GRAD_replay_fnc_getRecordEntry;

_scale = ctrlMapScale _map;
_showName = _scale < 0.03;

_name = [GRAD_REPLAY_DATABASE, grad_replay_playbackPosition, _blub, 5] call GRAD_replay_fnc_getRecordEntry;
_groupname = [GRAD_REPLAY_DATABASE, grad_replay_playbackPosition, _blub, 6] call GRAD_replay_fnc_getRecordEntry;

_name =  if (_showName) then { _name + _groupname } else { "" };

// diag_log format ["%1, %2, %3, %4, %5, %6, %7", _map, _icon, _color, _pos, _dir, _blub, _showName];

_map drawIcon [
			_icon,
			_color,
			_pos,
			24,
			24,
			_dir,
			_name, 
			1, 
			0.03, 
			'TahomaB', 
			'right'
		];