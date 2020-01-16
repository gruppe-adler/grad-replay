#include "script_component.hpp"

params ["_unit", "", "", "", "", "", "_projectile", "_vehicle"];

// only effective commander is tracked if unit is inside a vehicle --> proceed as if effective commander fired the shot
_unit = effectiveCommander vehicle _unit;

// make sure unit is being tracked
private _unitID = _unit getVariable [QGVAR(unitID),-1];
if (_unitID < 0) exitWith {};

// a projectile is being tracked already
if (!isNil {_unit getVariable QGVAR(firedTarget)}) exitWith {};

// track projectile
private _lastProjectilePos = [0,0,0];
[{
    params ["_args","_handle"];
    _args params ["_projectile","_unit","_lastProjectilePos"];

    if (!isNil {_unit getVariable QGVAR(firedTarget)}) exitWith {[_handle] call CBA_fnc_removePerFrameHandler};

    if (!isNull _projectile) then {
        _lastProjectilePos resize 0;
        _lastProjectilePos append (getPos _projectile);
    } else {
        _lastProjectilePos resize 2;
        _unit setVariable [QGVAR(firedTarget),_lastProjectilePos];
        [_handle] call CBA_fnc_removePerFrameHandler;
    };
},0,[_projectile,_unit,_lastProjectilePos]] call CBA_fnc_addPerFrameHandler;
