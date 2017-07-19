params ["_side"];

// works in SP but not in MP ON SERVER reliably (player works though)
_colorArrayRGBA = [_side, false] call BIS_fnc_sideColor;


// workaround for REALLY fucking strange problems with bis fnc sidecolor in mp
switch (_side) do {
	case west: { _colorArrayRGBA = [0,0.3,0.6,1]; };	
	case east: { _colorArrayRGBA = [0.5,0,0,1]; };
	case independent : { _colorArrayRGBA = [0,0.5,0,1]; };
	case civilian : { _colorArrayRGBA = [0.7,0.6,0,1]; };
	case sideEmpty: { _colorArrayRGBA = [0.4,0,0.5,1]; };
	default { _colorArrayRGBA = [0.4,0,0.5,1];  };
};


// diag_log format ["converting %1 to %2", _side, _colorArrayRGBA]; 

_colorArrayRGBA