params ["_side"];

_color = "";

switch (_side) do {
	case "BLU_F": { _color = "colorBlufor"; };
	case "OPF_F": { _color = "colorOpfor"; };
	case "IND_F": { _color = "colorIndependent"; };
	case "CIV_F": { _color = "colorCivilian"; };
	default { _color = "ColorUNKNOWN"; };
};

_colorArrayRGBA = (configfile >> "CfgMarkerColors" >> _color >> "color") call BIS_fnc_colorConfigToRGBA;

diag_log format ["converting %1 to %2", _side, _colorArrayRGBA];

_colorArrayRGBA