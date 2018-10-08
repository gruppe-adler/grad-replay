params [["_currentUnitData",[]],["_newUnitData",[]]];

// _unit,_side,_pos,_dir,_kindof,_veh,_hide

// prevent markers to render double on the same position (e.g. full team in vehicle)
/*
if (!(_vehicle in GRAD_REPLAY_DATABASE_TEMP)) then {
	GRAD_REPLAY_DATABASE_TEMP = GRAD_REPLAY_DATABASE_TEMP + [_array];
};
*/

if (count _newUnitData == 0) exitWith {};
// [_icon,_colorID,_pos,_dir,_name,_groupname]

private _newSaveData = [];
private _typeDefaults = [
	"",		// icon
	-1,		// color ID
	[0,0],	// pos2D
	-1,		// dir
	"",		// name
	""		// group name
];

/* diag_log ["fnc_storeValue"];
diag_log ["_currentUnitData",_currentUnitData];
diag_log ["_newUnitData",_newUnitData]; */

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

/* diag_log ["_newSaveData",_newSaveData];
diag_log ["_currentUnitData",_currentUnitData];
diag_log ["end fnc_storeValue"]; */

GRAD_REPLAY_DATABASE_TEMP append [_newSaveData];
