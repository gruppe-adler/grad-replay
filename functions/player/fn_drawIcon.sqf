params ["_map", "_GRAD_REPLAY_DATABASE", "_index", "_loopCounter"];

/* diag_log format ["accessing index %1, loop %2", _index, _loopCounter];*/

_scale = ctrlMapScale _map;
_showName = _scale < 0.03;

//DEBUG
_index = 0;
_loopCounter = 0;

_icon = [_GRAD_REPLAY_DATABASE, _index, _loopCounter, 0] call GRAD_replay_fnc_getRecordEntry;
_color = [_GRAD_REPLAY_DATABASE, _index, _loopCounter, 1] call GRAD_replay_fnc_getRecordEntry;
_pos = [_GRAD_REPLAY_DATABASE, _index, _loopCounter, 2] call GRAD_replay_fnc_getRecordEntry;
_dir = [_GRAD_REPLAY_DATABASE, _index, _loopCounter, 3] call GRAD_replay_fnc_getRecordEntry;
_name = [_GRAD_REPLAY_DATABASE, _index, _loopCounter, 4] call GRAD_replay_fnc_getRecordEntry;
_groupname = [_GRAD_REPLAY_DATABASE, _index, _loopCounter, 5] call GRAD_replay_fnc_getRecordEntry;

// _icon,_color,_pos,_dir,_veh,_name,_groupname


// diag_log format ["%1, %2, %3, %4, %5, %6", _map, _icon, _color, _pos, _dir, _name];

_nameCluster =  if (_showName) then { _name + " " + _groupname } else { "" };


/*
DEBUG

_icon = "iconManVirtual";
_color = [0.5,0,0,1];
_pos = [4226.96,3986.5,0.00163269];
_dir = 60;
_name = "nomisum";

DEBUG
*/

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