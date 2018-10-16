/*  Color lookup table to reduce variable size when saving.
 *
 */


#define DEFAULT_COLOR [0.7,0.6,0,1]

params [["_colorID",-1]];

private _colors = [

    // side color IDs
    [0,0.3,0.6,1],          // 0: WEST
    [0.5,0,0,1],            // 1: EAST
    [0,0.5,0,1],            // 2: INDEPENDENT
    [0.4,0,0.5,1],          // 3: CIVILIAN
    [0.7,0.6,0,1],          // 4: SIDEEMPTY

    // unconscious IDs are currently hardcoded to be exactly +5 in fn_startRecord!
    [0,0.3,0.6,0.5],        // 5: WEST unconscious
    [0.5,0,0,0.5],          // 6: EAST unconscious
    [0,0.5,0,0.5],          // 7: INDEPENDENT unconscious
    [0.4,0,0.5,0.5],        // 8: CIVILIAN unconscious
    [0.7,0.6,0,0.5],        // 9: SIDEEMPTY unconscious

    // other
    [0.2,0.2,0.2,0.5],      // 10: dead unit
    [1,0,0,1]               // 11: funkwagen-red when sending, speciality for mission "breaking contact"
];

_colors param [_colorID,DEFAULT_COLOR]
