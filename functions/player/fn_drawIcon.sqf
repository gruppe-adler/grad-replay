params ["_map", "_index"];

private _positionData = GRAD_REPLAY_DATABASE_LOCAL param [grad_replay_playbackPosition,[]];
if !(_positionData isEqualType []) exitWith {};

private _iconData = _positionData param [_index,[]];
if !(_iconData isEqualType []) exitWith {};

_scale = ctrlMapScale _map;
_showName = _scale < 0.03;

_iconData params [
    ["_icon", ""],
    ["_color", [0,0,0,0]],
    ["_pos", [0,0,0]],
    ["_dir", 0],
    ["_name", ""],
    ["_groupname", ""]
];


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
