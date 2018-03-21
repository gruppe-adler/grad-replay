params ["_map", "_index"];

_scale = ctrlMapScale _map;
_showName = _scale < 0.03;


if ((typeName (GRAD_REPLAY_DATABASE_LOCAL select grad_replay_playbackPosition select _index)) isEqualTo "STRING") exitWith {
	diag_log format ["grad-replay: catch time trying to infiltrate at %1", _index];
};

(GRAD_REPLAY_DATABASE_LOCAL select grad_replay_playbackPosition select _index) params [
    ["_icon", ""],
    ["_color", [0,0,0,0]],
    ["_pos", [0,0,0]],
    ["_dir", 0],
    ["_name", ""],
    ["_groupname", ""]
];

// diag_log format ["index: %1 %2 %3 %4 %5 %6 %7 %8", _index, _icon, _color, _pos, _dir, _name, _groupname, _map];

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