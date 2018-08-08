params ["_target"];

_healthStatus = _target getVariable ["GRAD_replay_healthStatus", []];
_healthStatus params ["_base", "_pain", "_blood", "_body", "_equipment", "_wounds"];

//Base
_base params ["_heartRate", "_isUnconscious", "_inCardiacArrest", "_preventInstaDeath"];

_target setVariable ["ace_medical_heartRate",_heartRate];
_target setVariable ["ACE_isUnconscious", _isUnconscious];
_target setVariable ["ace_medical_inCardiacArrest",_inCardiacArrest];
_target setVariable ["ace_medical_preventInstaDeath", _preventInstaDeath];

//Pain
_pain params ["_hasPain", "_painM", "_painSuppress"];

_target setVariable ["ace_medical_hasPain"), _hasPain];
_target setVariable ["ace_medical_pain", _painM];
_target setVariable "ace_medical_painSuppress", _painSuppress];

//Blood
_blood params ["_isBleeding", "_hasLostBlood", "_bloodBags", "_bloodVolume", "_heartRateAdjustments"];

_target setVariable ["ace_medical_isBleeding", _isBleeding];
_target setVariable ["ace_medical_hasLostBlood", _hasLostBlood];
_target setVariable ["ace_medical_ivBags", _bloodBags];
_target setVariable ["ace_medical_bloodVolume", _bloodVolume];
_target setVariable ["ace_medical_heartRateAdjustments", _heartRateAdjustments];

//Body
_body params ["_bodyPartStatus", "_peripheralResistance", "_airwayStatus"];

_target setVariable ["ace_medical_bodyPartStatus", _bodyPartStatus];
_target setVariable ["ace_medical_peripheralResistance", _peripheralResistance];
_target setVariable ["ace_medical_airwayStatus", _airwayStatus];

//Equipment
_equipment params ["_tourniquets", "_delayedMedications", "_triageLevel", "_morphine"];

_target setVariable ["ace_medical_tourniquets", _tourniquets];
_target setVariable ["ace_medical_occludedMedications", _delayedMedications];
_target setVariable ["ace_medical_triageLevel", _triageLevel];
_target setVariable ["ace_medical_morphine", _morphine];

//Wounds
_wounds params ["_fractures", "_internalWounds", "_openInjurys", "_bandagedwounds"];

_target setVariable["ace_medical_fractures", _fractures];
_target setVariable ["ace_medical_internalWounds", _internalWounds];
_target setVariable ["ace_medical_openWounds"), _openInjurys];
_target setVariable ["ace_medical_bandagedWounds", _bandagedwounds];
