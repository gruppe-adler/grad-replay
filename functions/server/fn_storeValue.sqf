#include "script_component.hpp"

params [["_currentUnitData",[]],["_nextTickData",[]],["_unitID",-1],["_newUnitData",[]]];

// _newUnitData contents: [_icon,_colorID,_pos,_dir,_name,_groupname]
if (count _newUnitData == 0) exitWith {};

private _newSaveData = [];
private _typeDefaults = [
    "",         // icon
    -1,         // color ID
    [0,0],      // pos2D
    -1,         // dir
    "",         // name
    "",         // group name
    []          // fired target
];

for [{_i=0},{_i<((count _currentUnitData) max (count _newUnitData))},{_i=_i+1}] do {
    _typeDefault = _typeDefaults select _i;
    _newUnitDataSelected = _newUnitData param [_i,_typeDefault];

    if !((_currentUnitData param [_i,_typeDefault]) isEqualTo _newUnitDataSelected) then {
        _currentUnitData set [_i,_newUnitDataSelected];
        _newSaveData set [_i,_newUnitDataSelected];
    } else {
        _newSaveData set [_i,nil];
    };
};

_nextTickData set [_unitID,_newSaveData];
