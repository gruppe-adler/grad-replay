params ["_count", "_index", "_playerCount"];

_xPos = SafeZoneX + (160 / 1920) * SafeZoneW;
_yPos = SafeZoneY + (910 / 1080) * SafeZoneH;
_width = (1600 / 1920) * SafeZoneW;
_height = (40 / 1080) * SafeZoneH;

with uiNamespace do {
    disableSerialization;
    GRAD_replay_txt_loading = findDisplay 46 ctrlCreate ["grad_replay_RscStructuredText", -1];
    GRAD_replay_txt_loading ctrlSetPosition [ _xPos, 0.4, _width, 0.1];
    GRAD_replay_txt_loading ctrlSetBackgroundColor [0, 0, 0, 0.8];
    GRAD_replay_txt_loading ctrlSetFont "RobotoCondensed";
    GRAD_replay_txt_loading ctrlSetStructuredText parseText format["<t align='center' size='2.3' shadow='0'>WAITING FOR REPLAY</t>"];
    GRAD_replay_txt_loading ctrlCommit 0;

    GRAD_replay_txt_loadingInfo = findDisplay 46 ctrlCreate ["grad_replay_RscStructuredText", -1];
    GRAD_replay_txt_loadingInfo ctrlSetPosition [ _xPos, 0.475, _width, 0.1];
    GRAD_replay_txt_loadingInfo ctrlSetBackgroundColor [0, 0, 0, 0];
    GRAD_replay_txt_loadingInfo ctrlSetTextColor [1, 1, 1, 0.35];
    GRAD_replay_txt_loadingInfo ctrlSetFont "RobotoCondensed";
    GRAD_replay_txt_loadingInfo ctrlSetStructuredText parseText format["<t align='right' size='0.5' shadow='0'>You are number %1 of %2 players receiving data</t>", _index, _playerCount];
    GRAD_replay_txt_loadingInfo ctrlCommit 0;

    GRAD_replay_rsc_loadingBar = findDisplay 46 ctrlCreate ["grad_replay_RscProgress", -1];
    GRAD_replay_rsc_loadingBar ctrlSetPosition [ _xPos, 0.4, _width, 0.005];
    GRAD_replay_rsc_loadingBar ctrlSetTextColor [209/255, 141/255, 31/255, 1];
    GRAD_replay_rsc_loadingBar progressSetPosition 0;
    GRAD_replay_rsc_loadingBar ctrlCommit 0;
    
    

};

[ "TIMER", "onEachFrame", {
    params[ "_start", "_end" ];
    _progress = linearConversion[ _start, _end, count GRAD_REPLAY_DATABASE_LOCAL, 0, 1 ];
    (uiNamespace getVariable "GRAD_replay_rsc_loadingBar") progressSetPosition _progress;
    
    if (_progress > 0 && _progress < 1) then {
        (uiNamespace getVariable "GRAD_replay_txt_loading") ctrlSetStructuredText parseText format["<t align='center' size='2.3' shadow='0'>LOADING REPLAY</t>"];
    };

    // hintsilent format ["showing progress bar %1", _progress];
    if (_progress >= 1) then {
        (uiNamespace getVariable "GRAD_replay_txt_loading") ctrlSetStructuredText parseText format["<t align='center' size='2.3' shadow='0'>WAITING FOR OTHERS</t>"];
    };
    /*
    // loading bar gets deleted in initreplay
    */

}, [ 0, _count ] ] call BIS_fnc_addStackedEventHandler;