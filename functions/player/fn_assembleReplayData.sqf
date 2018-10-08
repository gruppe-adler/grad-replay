private _compressedData = GRAD_REPLAY_DATABASE_LOCAL;
GRAD_REPLAY_DATABASE_LOCAL = [];

private _currentUnitsDataStates = [];
private _typeDefaults = [
	"",		// icon
	-1,		// color ID
	[0,0],	// pos2D
	-1,		// dir
	"",		// name
	""		// group name
];

{
    _compressedIntervalData = _x;
    _intervalData = [];
    {

        // timestamp
        if (_x isEqualType "") exitWith {
            _intervalData pushBack _x;
        };

        // data array
        if (_x isEqualType []) then {
            _unitData = [];
            _compressedUnitData = _x;

            if (_forEachIndex >= count _currentUnitsDataStates) then {
                _currentUnitsDataStates pushBack [];
            };
            _currentUnitDataState = _currentUnitsDataStates select _forEachIndex;

            {
                if (isNil "_x") then {
                    _unitData pushBack (_currentUnitDataState param [_forEachIndex,_typeDefaults select _forEachIndex]);
                } else {
                    _currentUnitDataState set [_forEachIndex,_x];
                    _unitData pushBack _x;
                };
            } forEach _compressedUnitData;

            _intervalData pushBack _unitData;
        };
    } forEach _compressedIntervalData;

    GRAD_REPLAY_DATABASE_LOCAL pushBack _intervalData;
    false
} count _compressedData;
