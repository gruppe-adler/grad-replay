disableSerialization;

_control = (findDisplay 80000) ctrlCreate ['RscPicture', -1];
_control ctrlSetText 'modules\grad_replay\ui\pause.paa';
_control ctrlSetPosition [0.45,0.45,(150 / 1920) * SafeZoneW,(150 / 1080) * SafeZoneH];

_control ctrlSetFade 0;
_control ctrlCommit 0;
_control ctrlSetFade 1;
_control ctrlCommit 1;
sleep 1;
ctrlDelete _control;
