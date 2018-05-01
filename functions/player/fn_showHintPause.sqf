[true] call GRAD_replay_fnc_setPlayPauseDisplay;

disableSerialization;

private _control = (findDisplay 80000) ctrlCreate ['grad_replay_RscPicture', -1];
_control ctrlSetText 'node_modules\@gruppe-adler\replay\ui\pause.paa';
_control ctrlSetPosition [0.45,0.45,(150 / 1920) * SafeZoneW,(150 / 1080) * SafeZoneH];

_control ctrlSetFade 0;
_control ctrlCommit 0;
_control ctrlSetFade 2;
_control ctrlCommit 2;
uiSleep 2;
ctrlDelete _control;
