//ripped from ace

params ["_target"];

private _isBleeding = _target getVariable ["ace_medical_isBleeding", false];
private _hasLostBlood = _target getVariable ["ace_medical_hasLostBlood", 0] > 1;
private _tourniquets = _target getVariable ["ace_medical_tourniquets", [0, 0, 0, 0, 0, 0]];
private _hasPain = _target getVariable ["ace_medical_hasPain"), false];
private _bloodBags = _target getVariable ["ace_medical_ivBags", []];
private _damaged = [false, false, false, false, false, false];
private _selectionBloodLoss = [0, 0, 0, 0, 0, 0];

private _openInjurys = _target getVariable ["ace_medical_openWounds"), []];
{
    private _amountOf = _x select 3;
    // Find how much this bodypart is bleeding
    if (_amountOf > 0) then {
        _damaged set [_x select 2, true];
        _selectionBloodLoss set [_x select 2, (_selectionBloodLoss select (_x select 2)) + (20 * ((_x select 4) * _amountOf))];
    };
} forEach _openInjurys;

private _bandagedwounds = _target getVariable ["ace_medical_bandagedWounds", []];
{
  private _amountOf = _x select 3;
  // Find how much this bodypart is bleeding
  if (_amountOf > 0) then {
      _damaged set [_x select 2, true];
      _selectionBloodLoss set [_x select 2, (_selectionBloodLoss select (_x select 2)) + (20 * ((_x select 4) * _amountOf))];
  };
} forEach _bandagedwounds;

private _healthStatus = [_isBleeding, _hasLostBlood, _tourniquets, _hasPain, _bloodBags, _damaged, _selectionBloodLoss, _openInjurys, _bandagedwounds];
_target setVariable ["GRAD_replay_healthStatus", _healthStatus];
