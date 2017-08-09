params ["_count", "_index", "_playerCount"];

with uiNamespace do {
    disableSerialization;
    GRAD_replay_txt_loading = findDisplay 46 ctrlCreate ["RscStructuredText", -1];
    GRAD_replay_txt_loading ctrlSetPosition [ safezoneX + 0.5, 0.4, 1, 0.1];
    GRAD_replay_txt_loading ctrlSetBackgroundColor [0, 0, 0, 0.8];
    GRAD_replay_txt_loading ctrlSetFont "RobotoCondensed";
    GRAD_replay_txt_loading ctrlSetStructuredText parseText format["<t align='center' size='2.3' shadow='0'>WAITING FOR REPLAY</t>"];
    GRAD_replay_txt_loading ctrlCommit 0;

    GRAD_replay_txt_loadingInfo = findDisplay 46 ctrlCreate ["RscStructuredText", -1];
    GRAD_replay_txt_loadingInfo ctrlSetPosition [ safezoneX + 0.5, 0.475, 1, 0.1];
    GRAD_replay_txt_loadingInfo ctrlSetBackgroundColor [0, 0, 0, 0];
    GRAD_replay_txt_loadingInfo ctrlSetTextColor [1, 1, 1, 0.35];
    GRAD_replay_txt_loadingInfo ctrlSetFont "RobotoCondensed";
    GRAD_replay_txt_loadingInfo ctrlSetStructuredText parseText format["<t align='right' size='0.5' shadow='0'>You are number %1 of %2 players receiving data</t>", _index, _playerCount];
    GRAD_replay_txt_loadingInfo ctrlCommit 0;

    GRAD_replay_rsc_loadingBar = findDisplay 46 ctrlCreate ["RscProgress", -1];
    GRAD_replay_rsc_loadingBar ctrlSetPosition [ safezoneX + 0.5, 0.4, 1, 0.01];
    GRAD_replay_rsc_loadingBar ctrlSetTextColor [209/255, 141/255, 31/255, 1];
    GRAD_replay_rsc_loadingBar progressSetPosition 0;
    GRAD_replay_rsc_loadingBar ctrlCommit 0;
    
    

};

[ "TIMER", "onEachFrame", {
    params[ "_start", "_end" ];
    _progress = linearConversion[ _start, _end, count GRAD_REPLAY_DATABASE_LOCAL, 0, 1 ];
    (uiNamespace getVariable "GRAD_replay_rsc_loadingBar") progressSetPosition _progress;
    
    if (_progress > 0) then {
        (uiNamespace getVariable "GRAD_replay_txt_loading") ctrlSetStructuredText parseText format["<t align='center' size='2.3' shadow='0'>LOADING REPLAY</t>"];
    };

    // hintsilent format ["showing progress bar %1", _progress];

    if ( _progress >= 1 ) then {
        [ "TIMER", "onEachFrame" ] call BIS_fnc_removeStackedEventHandler;
        ctrlDelete (uiNamespace getVariable "GRAD_replay_rsc_loadingBar");
        ctrlDelete (uiNamespace getVariable "GRAD_replay_txt_loading");
        ctrlDelete (uiNamespace getVariable "GRAD_replay_txt_loadingInfo");
        // hint "FINISHED";
    };
}, [ 0, _count ] ] call BIS_fnc_addStackedEventHandler;