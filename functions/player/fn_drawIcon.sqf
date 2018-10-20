params ["_map", "_index"];

private _positionData = GRAD_REPLAY_DATABASE_LOCAL_ASSEMBLED param [grad_replay_playbackPosition,[]];
if !(_positionData isEqualType []) exitWith {};

private _iconData = _positionData param [_index,[]];
if !(_iconData isEqualType []) exitWith {};

_iconData params [
    ["_icon", ""],
    ["_colorID", -1],
    ["_pos", [0,0,0]],
    ["_dir", 0],
    ["_name", ""],
    ["_groupname", ""],
    ""
];

private _showName = (ctrlMapScale _map) < 0.03;
private _name =  if (_showName) then { _name + " " + _groupname } else { "" };
private _color = [_colorID] call grad_replay_fnc_getColorFromID;

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
