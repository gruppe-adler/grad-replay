params ["_map", "_index"];

private _array = (GRAD_REPLAY_DATABASE_LOCAL select grad_replay_playbackPosition param [_index,[]]);
if ((typeName _array) isEqualTo "STRING" || _array isEqualTo []) exitWith {
	//diag_log format ["grad-replay: catch time trying to infiltrate at %1", _index];
};

_scale = ctrlMapScale _map;
_showName = _scale < 0.03;


private _icon =  _array param [0, ""];
private _color =  _array param [1, [0,0,0,0]];
private _pos =  _array param [2, [0,0,0]];
private _dir =  _array param [3, 0];
private _name =  _array param [4, ""];
private _groupname =  _array param [5, ""];

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
