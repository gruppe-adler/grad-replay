params ["_count"];

with uiNamespace do {
    disableSerialization;
    my_awesome_text = findDisplay 46 ctrlCreate ["RscStructuredText", -1];
    my_awesome_text ctrlSetPosition [ safezoneX + 0.5, 0.4, 1, 0.1];
    my_awesome_text ctrlSetBackgroundColor [0, 0, 0, 0.8];
    my_awesome_text ctrlSetFont "RobotoCondensed";
    my_awesome_text ctrlCommit 0;

    my_awesome_progressBar = findDisplay 46 ctrlCreate ["RscProgress", -1];
    my_awesome_progressBar ctrlSetPosition [ safezoneX + 0.5, 0.4, 1, 0.01];
    my_awesome_progressBar ctrlSetTextColor [209/255, 141/255, 31/255, 1];
    my_awesome_progressBar progressSetPosition 0;
    my_awesome_progressBar ctrlCommit 0;
    
   

};

[ "TIMER", "onEachFrame", {
    params[ "_start", "_end" ];
    _progress = linearConversion[ _start, _end, count GRAD_REPLAY_DATABASE_LOCAL, 0, 1 ];
    (uiNamespace getVariable "my_awesome_progressBar") progressSetPosition _progress;
    (uiNamespace getVariable "my_awesome_text") ctrlSetStructuredText parseText format["<t align='center' size='2.2' shadow='0'>LOADING REPLAY</t>"];

    // hintsilent format ["showing progress bar %1", _progress];

    if ( _progress >= 1 ) then {
        [ "TIMER", "onEachFrame" ] call BIS_fnc_removeStackedEventHandler;
        ctrlDelete (uiNamespace getVariable "my_awesome_progressBar");
        ctrlDelete (uiNamespace getVariable "my_awesome_text");
        // hint "FINISHED";
    };
}, [ 0, _count ] ] call BIS_fnc_addStackedEventHandler;