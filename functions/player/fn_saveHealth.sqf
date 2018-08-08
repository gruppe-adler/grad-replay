params ["_target"];

//Base
private _heartRate = _target getVariable ["ace_medical_heartRate",80];
private _isUnconscious = _target getVariable ["ACE_isUnconscious", false];
private _inCardiacArrest = _target getVariable ["ace_medical_inCardiacArrest",false];
private _preventInstaDeath = _target getVariable ["ace_medical_preventInstaDeath", ace_medical_preventInstaDeath];

private _base = [_heartRate, _isUnconscious, _inCardiacArrest, _preventInstaDeath];

//Pain
private _hasPain = _target getVariable ["ace_medical_hasPain"), false];
private _painM = _target getVariable ["ace_medical_pain", 0];
private _painSuppress = _target getVariable "ace_medical_painSuppress",0];

private _pain = [_hasPain, _painM, _painSuppress];

//Blood
private _isBleeding = _target getVariable ["ace_medical_isBleeding", false];
private _hasLostBlood = _target getVariable ["ace_medical_hasLostBlood", 0];
private _bloodBags = _target getVariable ["ace_medical_ivBags", []];
private _bloodVolume = _target getVariable ["ace_medical_bloodVolume", 100];
private _heartRateAdjustments = _target getVariable ["ace_medical_heartRateAdjustments", []];

private _blood = [_isBleeding, _hasLostBlood, _bloodBags, _bloodVolume, _heartRateAdjustments];

//Body
private _bodyPartStatus = _target getVariable ["ace_medical_bodyPartStatus", [0,0,0,0,0,0]];
private _peripheralResistance = _target getVariable ["ace_medical_peripheralResistance", 100];
private _airwayStatus = _target getVariable ["ace_medical_airwayStatus", 0];

private _body = [_bodyPartStatus, _peripheralResistance, _airwayStatus];

//Equipment
private _tourniquets = _target getVariable ["ace_medical_tourniquets", [0, 0, 0, 0, 0, 0]];
private _delayedMedications = _target getVariable ["ace_medical_occludedMedications", []];
private _triageLevel = _target getVariable ["ace_medical_triageLevel", -1];
private _morphine = _target getVariable ["ace_medical_morphine", 0];

private _equipment = [_tourniquets, _delayedMedications, _triageLevel, _morphine];

//Wounds
private _fractures = _target getVariable["ace_medical_fractures", []];
private _internalWounds = _target getVariable ["ace_medical_internalWounds", []];
private _openInjurys = _target getVariable ["ace_medical_openWounds"), []];
private _bandagedwounds = _target getVariable ["ace_medical_bandagedWounds", []];

private _wounds = [_fractures, _internalWounds, _openInjurys, _bandagedwounds];

_target setVariable ["GRAD_replay_healthStatus", [_base, _pain, _blood, _body, _equipment, _wounds]];
