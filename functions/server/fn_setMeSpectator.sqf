params ["_unit", "_pos"];

player setPos[_deathPos select 0, _deathPos select 1, 10];

_unit enableSimulationGlobal false;
_unit hideObjectGlobal true;
