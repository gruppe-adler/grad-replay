params ["_map", "_index"];

_scale = ctrlMapScale _map;
_showName = _scale < 0.03;

_icon = [GRAD_REPLAY_DATABASE_LOCAL, grad_replay_playbackPosition, _index, 0, ""] call GRAD_replay_fnc_getRecordEntry;
_color = [GRAD_REPLAY_DATABASE_LOCAL, grad_replay_playbackPosition, _index, 1, [0,0,0,0]] call GRAD_replay_fnc_getRecordEntry;
_pos = [GRAD_REPLAY_DATABASE_LOCAL, grad_replay_playbackPosition, _index, 2, [0,0,0]] call GRAD_replay_fnc_getRecordEntry;
_dir = [GRAD_REPLAY_DATABASE_LOCAL, grad_replay_playbackPosition, _index, 3, 0] call GRAD_replay_fnc_getRecordEntry;
_name = [GRAD_REPLAY_DATABASE_LOCAL, grad_replay_playbackPosition, _index, 4, ""] call GRAD_replay_fnc_getRecordEntry;
_groupname = [GRAD_REPLAY_DATABASE_LOCAL, grad_replay_playbackPosition, _index, 5, ""] call GRAD_replay_fnc_getRecordEntry;

/* diag_log format ["%1, %2, %3, %4, %5, %6, %7, %8", _map, _icon, _color, _pos, _dir, _index, _showName, _name];*/

_name =  if (_showName) then { _name + " " + _groupname } else { "" };



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
