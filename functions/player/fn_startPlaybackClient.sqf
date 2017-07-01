#include "\z\ace\addons\main\script_component.hpp"

grad_replay_playbackPosition = 0;

[{
    // params ["_args", "_handle"];

    grad_replay_playbackPosition = grad_replay_playbackPosition + 1;

    
		waitUntil { !(findDisplay 12 isEqualTo displayNull) };


		for [{_k=0}, {_k < (count (GRAD_REPLAY_DATABASE select grad_replay_playbackPosition))}, {_k=_k+1}] do { 

			_icon = [GRAD_REPLAY_DATABASE, grad_replay_playbackPosition, _k, 0] call getRecordEntry;
			_color = [GRAD_REPLAY_DATABASE, grad_replay_playbackPosition, _k, 1] call getRecordEntry;
			_pos = [GRAD_REPLAY_DATABASE, grad_replay_playbackPosition, _k, 2] call getRecordEntry;
			_dir = [GRAD_REPLAY_DATABASE, grad_replay_playbackPosition, _k, 3] call getRecordEntry;
			_special = [GRAD_REPLAY_DATABASE, grad_replay_playbackPosition, _k, 4] call getRecordEntry;
			_veh = [GRAD_REPLAY_DATABASE, grad_replay_playbackPosition, _k, 5] call getRecordEntry;

			_icon = "\A3\ui_f\data\map\vehicleicons\" + _icon;

			findDisplay 12 displayCtrl 51 ctrlAddEventHandler    
			[    
				"Draw",     
				format ["_this select 0 drawIcon     
				[      
					%1,     
					%2,      
					%3,      
					24,     
					24,      
					%4,      
					'',
					0    
				]", _icon, _color, _pos, _dir]
			];  
		};

	/* diag_log format ["replay pos is %1, count grad_replay db is %2", grad_replay_playbackPosition, count GRAD_REPLAY_DATABASE];*/

    // end recording and start playback
    if (grad_replay_playbackPosition >= count GRAD_REPLAY_DATABASE) then {
    	[_this select 1] call CBA_fnc_removePerFrameHandler;

    	[] spawn GRAD_replay_fnc_stopPlaybackClient;
	};

},1,[]] call CBA_fnc_addPerFrameHandler;