params ["_unit", "_deathPos"];

player setPos [_deathPos select 0, _deathPos select 1, 10];

_unit enableSimulationGlobal false;
_unit hideObjectGlobal true;