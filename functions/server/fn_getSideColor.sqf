params ["_side"];

_color = "";

switch (_side) do {
	case west: { _color = "colorBlufor"; };
	case east: { _color = "colorOpfor"; };
	case independent: { _color = "colorIndependent"; };
	case civilian: { _color = "colorCivilian"; };
	case sideUnknown: { _color = "ColorUNKNOWN"; };
	default { _color = "ColorUNKNOWN"; };
};

_colorArrayRGBA = (configfile >> "CfgMarkerColors" >> _color >> "color") call BIS_fnc_colorConfigToRGBA;

_colorArrayRGBA