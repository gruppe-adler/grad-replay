params ["_side"];

_return = "";

switch (_side) do {
	case west: { _return = "colorBlufor"; };
	case east: { _return = "colorOpfor"; };
	case independent: { _return = "colorIndependent"; };
	case civilian: { _return = "colorCivilian"; };
	case sideUnknown: { _return = "ColorUNKNOWN"; };
	default { _return = "ColorUNKNOWN"; };
};

_return