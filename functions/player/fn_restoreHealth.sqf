params ["_target"];

private _healthStatus = _target getVariable ["GRAD_replay_healthStatus", []];
_healthStatus params ["_isBleeding", "_hasLostBlood", "_tourniquets", "_hasPain", "_bloodBags", "_damaged", "_selectionBloodLoss", "_openInjurys", "_bandagedwounds"];
