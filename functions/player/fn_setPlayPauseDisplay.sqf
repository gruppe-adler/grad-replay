params ["_isPlay"];

disableSerialization;

if (_isPlay) then {
    ((findDisplay 80000) displayCtrl 80005) ctrlSetText "node_modules\@gruppe-adler\replay\ui\play.paa";
} else {
    ((findDisplay 80000) displayCtrl 80005) ctrlSetText "node_modules\@gruppe-adler\replay\ui\pause.paa";
};
