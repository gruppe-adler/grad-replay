params ["_isPlay"];

disableSerialization;

if (_isPlay) then {
	((findDisplay 80000) displayCtrl 80005) ctrlSetText "node_modules\grad_replay\ui\play.paa";
} else {
	((findDisplay 80000) displayCtrl 80005) ctrlSetText "node_modules\grad_replay\ui\pause.paa";
};