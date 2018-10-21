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

// unit did not fire shot this tick
if (_firedTarget isEqualTo []) exitWith {};

private _color = [_colorID] call grad_replay_fnc_getColorFromID;
private _shotDir = _pos getDir _firedTarget;
private _shotDistance = _pos distance _firedTarget;
private _drawEH = -1;
private _shotAnimTicks = (floor (_shotDistance / GRAD_REPLAY_SHOTANIMSPEED)) min 30;
private _shotAnimCurrentTick = 1;

// flying lines Star Wars style animation
[{
    params ["_args","_handle"];
    _args params ["_drawEH","_shotAnimCurrentTick","_shotAnimTicks","_map","_pos","_firedTarget","_color","_shotDir"];

    _newShotEndPos = if (_shotAnimCurrentTick > _shotAnimTicks) then {
        _firedTarget
    } else {
        _pos getPos [GRAD_REPLAY_SHOTANIMSPEED * _shotAnimCurrentTick,_shotDir]
    };

    _startPosTick = (_shotAnimCurrentTick - 2) max 0;
    _newShotStartPos = if (_startPosTick > _shotAnimTicks) then {
        _firedTarget
    } else {
        _pos getPos [GRAD_REPLAY_SHOTANIMSPEED * _startPosTick,_shotDir]
    };

    // remove previous draw EH
    _map ctrlRemoveEventHandler ["Draw",_drawEH];

    // create new draw EH and save ID in _drawEH (_args set [0,...])
    if (_startPosTick > _shotAnimTicks) then {
        [_handle] call CBA_fnc_removePerFrameHandler;
    } else {
        _args set [0,
            _map ctrlAddEventHandler ["Draw",
                format ["(_this select 0) drawLine [%1,%2,%3]",_newShotStartPos,_newShotEndPos,_color]
            ]
        ];
    };

    _args set [1,_shotAnimCurrentTick + 1];

},0.1,[_drawEH,_shotAnimCurrentTick,_shotAnimTicks,_map,_pos,_firedTarget,_color,_shotDir]] call CBA_fnc_addPerFrameHandler;


// continuous lines style animation
/* [{
    params ["_args","_handle"];
    _args params ["_drawEH","_shotAnimCurrentTick","_shotAnimTicks","_map","_pos","_firedTarget","_color","_shotDir"];

    _newShotPos = if (_shotAnimCurrentTick > _shotAnimTicks) then {
        _color set [3,(_color select 3) - 0.2];
        _firedTarget;
    } else {
        _pos getPos [GRAD_REPLAY_SHOTANIMSPEED * _shotAnimCurrentTick,_shotDir];
    };

    // remove previous draw EH
    _map ctrlRemoveEventHandler ["Draw",_drawEH];

    // create new draw EH and save ID in _drawEH (_args set [0,...])
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

},0.1,[_drawEH,_shotAnimCurrentTick,_shotAnimTicks,_map,_pos,_firedTarget,_color,_shotDir]] call CBA_fnc_addPerFrameHandler; */
