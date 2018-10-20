params ["_map", "_index"];

private _positionData = GRAD_REPLAY_DATABASE_LOCAL_ASSEMBLED param [grad_replay_playbackPosition,[]];
if !(_positionData isEqualType []) exitWith {};

private _iconData = _positionData param [_index,[]];
if !(_iconData isEqualType []) exitWith {};

_iconData params [
    "",
    ["_colorID", -1],
    ["_pos", [0,0,0]],
    "",
    "",
    "",
    ["_firedTarget",[]]
];

if (_firedTarget isEqualTo []) exitWith {};

private _color = [_colorID] call grad_replay_fnc_getColorFromID;
private _shotDir = _pos getDir _firedTarget;
private _shotDistance = _pos distance _firedTarget;
private _drawEH = -1;
private _shotAnimTicks = (ceil (_shotDistance / GRAD_REPLAY_SHOTANIMSPEED)) min 30;
private _shotAnimCurrentTick = 1;

[{
    params ["_args","_handle"];
    _args params ["_drawEH","_shotAnimCurrentTick","_shotAnimTicks","_map","_pos","_firedTarget","_color","_shotDir"];


    _newShotPos = if (_shotAnimCurrentTick > _shotAnimTicks) then {
        _color set [3,(_color select 3) - 0.2];
        _firedTarget;
    } else {
        _pos getPos [GRAD_REPLAY_SHOTANIMSPEED * _shotAnimCurrentTick,_shotDir];
    };

    _map ctrlRemoveEventHandler ["Draw",_drawEH];

    if (_color select 3 <= 0) then {
        [_handle] call CBA_fnc_removePerFrameHandler;
    } else {
        _args set [0,
            _map ctrlAddEventHandler ["Draw",
                format ["(_this select 0) drawLine [%1,%2,%3]",_pos,_newShotPos,_color]
            ]
        ];
    };

    _args set [1,_shotAnimCurrentTick + 1];

},0.1,[_drawEH,_shotAnimCurrentTick,_shotAnimTicks,_map,_pos,_firedTarget,_color,_shotDir]] call CBA_fnc_addPerFrameHandler;
