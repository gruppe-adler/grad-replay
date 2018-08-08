if ([(missionConfigFile >> "GRAD_Replay"), "saveHealth", false] call BIS_fnc_returnConfigEntry) then {
  [] call GRAD_replay_fnc_saveHealth;
};
// heal everything
[player, player] call ace_medical_fnc_treatmentAdvanced_fullHealLocal;


[] call GRAD_replay_fnc_preparePlaybackClient;
