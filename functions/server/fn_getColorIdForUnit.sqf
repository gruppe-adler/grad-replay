params [
	["_unit", objNull, [objNull]]
];

if (!alive _unit) exitWith {10};

private _coloringCallback = _unit getVariable [
	"grad_replay_color", 
	grad_replay_fnc_getColorIdForUnit_bySide
];

assert(_coloringCallback isEqualType {});

private _colorId = _unit call _coloringCallback;
if (_colorId isEqualType []) then {
	private _color = _colorId;
	_colorId = GRAD_REPLAY_COLORS find _color;
	if (_colorId == -1) then {
		_colorId = GRAD_REPLAY_COLORS pushBack _color;
	};
};

_colorId