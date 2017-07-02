#include "\z\ace\addons\main\script_component.hpp"

grad_replay_playbackPosition = 0;
grad_current_ehs = [];
grad_current_playbackLoopPosition = 0;



[{
	{
		((findDisplay 12) displayCtrl 51) ctrlRemoveEventHandler ["Draw", _x];
	} forEach grad_current_ehs;

	grad_current_ehs = [];

    grad_replay_playbackPosition = grad_replay_playbackPosition + 1;

    for [{_k=0}, {_k < (count (GRAD_REPLAY_DATABASE select grad_replay_playbackPosition))}, {_k=_k+1}] do { 

    		hintsilent format ["loopcount %1", (count (GRAD_REPLAY_DATABASE select grad_replay_playbackPosition))];

			grad_current_playbackLoopPosition = _k;
			// _special = [GRAD_REPLAY_DATABASE, grad_replay_playbackPosition, _k, 4] call GRAD_replay_fnc_getRecordEntry;
			// _veh = [GRAD_REPLAY_DATABASE, grad_replay_playbackPosition, _k, 5] call GRAD_replay_fnc_getRecordEntry;

			_eh = ((findDisplay 12) displayCtrl 51) ctrlAddEventHandler ["Draw",{

				/* diag_log format ["%1, %2, %3, %4", _thisicon, _thiscolor, _thispos, _thisdir];*/

				/*
				format ["
						(_this select 0) drawArrow [
							'%1' call LOCPOSR,
							%2,
							[1,0.4,0,1]
						];
					",(_m getvariable "IDCODE"),_mPs select 0]];
				*/

				 diag_log format ["%1", grad_current_playbackLoopPosition];
				 call compile format ["
				 	[
				 		_this select 0,
						%1
					] call GRAD_replay_fnc_drawIcon", grad_current_playbackLoopPosition
				];
			}];
			
	};

	grad_current_ehs = grad_current_ehs + [_eh];

    // end recording and start playback
    if (grad_replay_playbackPosition >= count GRAD_REPLAY_DATABASE) then {
    	// [_this select 1] call CBA_fnc_removePerFrameHandler;

    	// [] spawn GRAD_replay_fnc_stopPlaybackClient;
	};

},5,[]] call CBA_fnc_addPerFrameHandler;