private ["_xPos", "_yPos", "_width", "_height"];

with uiNamespace do {
    disableSerialization;

    _xPos = SafeZoneX + (160 / 1920) * SafeZoneW;
    _yPos = SafeZoneY + (910 / 1080) * SafeZoneH;
    _width = (1600 / 1920) * SafeZoneW;
    _height = (40 / 1080) * SafeZoneH;

    GRAD_replay_txt_finished = (findDisplay 80000) ctrlCreate ["grad_replay_RscStructuredText", -1];
    GRAD_replay_txt_finished ctrlSetPosition [ _xPos, _yPos, _width, _height];
    GRAD_replay_txt_finished ctrlSetBackgroundColor [0, 0, 0, 0.8];
    GRAD_replay_txt_finished ctrlSetFont "RobotoCondensed";
    GRAD_replay_txt_finished ctrlSetStructuredText parseText format["<t align='center' size='1.2' shadow='0'>REPLAY FINISHED</t>"];
    GRAD_replay_txt_finished ctrlCommit 0;
};