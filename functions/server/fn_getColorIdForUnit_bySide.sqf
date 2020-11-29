private _side = if (_this isKindOf "Man") then {side _this} else {sideEmpty};
private _sideColor = [_side] call GRAD_replay_fnc_getSideColorID;

if (_this getVariable ["ACE_isUnconscious", false]) exitWith {_sideColor + 5};

_sideColor