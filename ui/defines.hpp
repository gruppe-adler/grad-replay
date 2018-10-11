#define CT_STATIC           0
#define CT_BUTTON           1
#define CT_EDIT             2
#define CT_SLIDER           3
#define CT_COMBO            4
#define CT_LISTBOX          5
#define CT_TOOLBOX          6
#define CT_CHECKBOXES       7
#define CT_PROGRESS         8
#define CT_HTML             9
#define CT_STATIC_SKEW      10
#define CT_ACTIVETEXT       11
#define CT_TREE             12
#define CT_STRUCTURED_TEXT  13
#define CT_CONTEXT_MENU     14
#define CT_CONTROLS_GROUP   15
#define CT_SHORTCUTBUTTON   16
#define CT_XKEYDESC         40
#define CT_XBUTTON          41
#define CT_XLISTBOX         42
#define CT_XSLIDER          43
#define CT_XCOMBO           44
#define CT_ANIMATED_TEXTURE 45
#define CT_OBJECT           80
#define CT_OBJECT_ZOOM      81
#define CT_OBJECT_CONTAINER 82
#define CT_OBJECT_CONT_ANIM 83
#define CT_LINEBREAK        98
#define CT_USER             99
#define CT_MAP              100
#define CT_MAP_MAIN         101
#define CT_LISTNBOX         102

#define ST_POS            0x0F
#define ST_HPOS           0x03
#define ST_VPOS           0x0C
#define ST_LEFT           0x00
#define ST_RIGHT          0x01
#define ST_CENTER         0x02
#define ST_DOWN           0x04
#define ST_UP             0x08
#define ST_VCENTER        0x0C

#define ST_TYPE           0xF0
#define ST_SINGLE         0x00
#define ST_MULTI          0x10
#define ST_TITLE_BAR      0x20
#define ST_PICTURE        0x30
#define ST_FRAME          0x40
#define ST_BACKGROUND     0x50
#define ST_GROUP_BOX      0x60
#define ST_GROUP_BOX2     0x70
#define ST_HUD_BACKGROUND 0x80
#define ST_TILE_PICTURE   0x90
#define ST_WITH_RECT      0xA0
#define ST_LINE           0xB0

#define ST_SHADOW         0x100
#define ST_NO_RECT        0x200
#define ST_KEEP_ASPECT_RATIO  0x800

#define ST_TITLE          ST_TITLE_BAR + ST_CENTER

#define SL_DIR            0x400
#define SL_VERT           0
#define SL_HORZ           0x400

#define SL_TEXTURES       0x10

#define ST_VERTICAL       0x01
#define ST_HORIZONTAL     0

#define LB_TEXTURES       0x10
#define LB_MULTI          0x20

#define TR_SHOWROOT       1
#define TR_AUTOCOLLAPSE   2

#define MB_BUTTON_OK      1
#define MB_BUTTON_CANCEL  2
#define MB_BUTTON_USER    4

#define GUI_GRID_X    (0)
#define GUI_GRID_Y    (0)
#define GUI_GRID_W    (0.025)
#define GUI_GRID_H    (0.04)
#define GUI_GRID_WAbs    (1)
#define GUI_GRID_HAbs    (1)

class grad_replay_RscSlider
{
    style = "0x400 + 0x10";
    type = 43;  // this is the more "modern" slider. Type = 3 is the old dull one.
    shadow = 0;
    colorActive[] = {1,1,1,1};
    colorDisabled[] = {0.5,0.5,0.5,0.2};

    color[] = {1,1,1,0.4};

    arrowEmpty = "\A3\ui_f\data\gui\cfg\slider\arrowEmpty_ca.paa";
    arrowFull = "\A3\ui_f\data\gui\cfg\slider\arrowFull_ca.paa";
    border = "\A3\ui_f\data\gui\cfg\slider\border_ca.paa";
    thumb = "\A3\ui_f\data\gui\cfg\slider\thumb_ca.paa";
};

class grad_replay_RscProgress {
    type = 8;
    style = 0;
    colorFrame[] = {0,0,0,0};
    colorBar[] = {1,1,1,1};
    texture = "#(argb,8,8,3)color(1,1,1,1)";
    x = 0;
    y = 0;
    w = 1;
    h = 0.03;
};

class grad_replay_RscStructuredText
{
    access = 0;
    idc = -1;
    type =  CT_STRUCTURED_TEXT;
    style = ST_MULTI;
    lineSpacing = 0.5;
    colorBackground[] = {-1,-1,-1,0};
    colorText[] = {1,1,1,0.7};
    size = 0.038;
    text = "";
    fixedWidth = 0;
    x = 0;
    y = 0;
    h = 0;
    w = 0;
    shadow = 0;
};

class grad_replay_RscStructuredTextTooltip
{
    access = 0;
    idc = -1;
    type =  CT_STRUCTURED_TEXT;
    style = ST_MULTI;
    lineSpacing = 0.5;
    colorBackground[] = {-1,-1,-1,0};
    colorText[] = {1,1,1,0.7};
    size = 0.028;
    text = "";
    fixedWidth = 0;
    x = 0;
    y = 0;
    h = 0;
    w = 0;
    shadow = 0;
};

class grad_replay_RscStructuredTextHeadline
{
    access = 0;
    idc = -1;
    type =  CT_STRUCTURED_TEXT;
    style = ST_CENTER;
    colorBackground[] = {-1,-1,-1,0};
    colorText[] = {0.5,0.5,0.5,1};
    size = 0.048;
    text = "";
    fixedWidth = 0;
    x = 0;
    y = 0;
    h = 0;
    w = 0;
    shadow = 0;
    font = "puristaMedium";
};


class grad_replay_RscText
{
    access = 0;
    idc = -1;
    type = CT_STATIC;
    style = ST_MULTI;
    linespacing = 1;
    colorBackground[] = {0,0,0,0};
    colorText[] = {1,1,1,0.5};
    text = "";
    shadow = 0;
    font = "PuristaLight";
    SizeEx = 0.02300;
    fixedWidth = 0;
    x = 0;
    y = 0;
    h = 0;
    w = 0;

};

class grad_replay_RscPicture
{
    access = 0;
    idc = -1;
    type = CT_STATIC;
    style = ST_PICTURE;
    colorBackground[] = {0,0,0,0};
    colorText[] = {1,1,1,1};
    font = "PuristaLight";
    sizeEx = 0;
    lineSpacing = 0;
    text = "";
    fixedWidth = 0;
    shadow = 0;
    x = 0;
    y = 0;
    w = 0.2;
    h = 0.15;
};

class grad_replay_RscButton
{

   access = 0;
    type = CT_BUTTON;
    text = "";
    colorText[] = {1,1,1,.9};
    colorDisabled[] = {0.4,0.4,0.4,1};
    colorBackground[] = {0.75,0.75,0.75,0.8};
    colorBackgroundDisabled[] = {0,0.0,0};
    colorBackgroundActive[] = {0.75,0.75,0.75,1};
    colorFocused[] ={0.75,0.75,0.75,0.8};
    colorShadow[] = {0.023529,0,0.0313725,1};
    colorBorder[] = {0.023529,0,0.0313725,1};
    soundEnter[] = {"\ca\ui\data\sound\onover",0.09,1};
    soundPush[] = {"\ca\ui\data\sound\new1",0,0};
    soundClick[] = {"\ca\ui\data\sound\onclick",0.07,1};
    soundEscape[] = {"\ca\ui\data\sound\onescape",0.09,1};
    style = 2; //2
    x = 0;
    y = 0;
    w = 0.055589;
    h = 0.039216;
    shadow = 2;
    font = "PuristaLight";
    sizeEx = 0.03921;
    offsetX = 0.003;
    offsetY = 0.003;
    offsetPressedX = 0.002;
    offsetPressedY = 0.002;
    borderSize = 0;
    period = 0;
};

class grad_replay_RscButtonSmall
{

    access = 0;
    type = CT_BUTTON;
    text = "";
    colorText[] = {1,1,1,.9};
    colorDisabled[] = {0.4,0.4,0.4,1};
    colorBackground[] = {0.75,0.75,0.75,0.8};
    colorBackgroundDisabled[] = {0,0.0,0};
    colorBackgroundActive[] = {0.75,0.75,0.75,1};
    colorFocused[] = {0.75,0.75,0.75,0.8};
    colorShadow[] = {0.023529,0,0.0313725,1};
    colorBorder[] = {0.023529,0,0.0313725,1};
    soundEnter[] = {"\ca\ui\data\sound\onover",0.09,1};
    soundPush[] = {"\ca\ui\data\sound\new1",0,0};
    soundClick[] = {"\ca\ui\data\sound\onclick",0.07,1};
    soundEscape[] = {"\ca\ui\data\sound\onescape",0.09,1};
    style = 2;
    x = 0;
    y = 0;
    w = 0.055589;
    h = 0.039216;
    shadow = 0;
    font = "PuristaLight";
    size = 0.03921;
    sizeEx = 0.02921;
    offsetX = 0.003;
    offsetY = 0.003;
    offsetPressedX = 0.002;
    offsetPressedY = 0.002;
    borderSize = 0;
};

class grad_replay_RscFrame
{
    type = CT_STATIC;
    idc = -1;
    style = ST_FRAME;
    shadow = 2;
    colorBackground[] = {1,1,1,1};
    colorText[] = {1,1,1,0.9};
    font = "PuristaLight";
    sizeEx = 0.03;
    text = "";
};

class grad_replay_RscBackground
{
   type = CT_STATIC;
    idc = -1;
    style = ST_CENTER;
    shadow = 2;
    colorText[] = {1,1,1,1};
    font = "PuristaLight";
    sizeEx = 0.02;
    colorBackground[] = { 0,0,0, 0.8 };
    text = "";

};
class grad_replay_RscModel {
        onObjectMoved = "systemChat str _this";
        idc = -1;
        type = CT_OBJECT_CONTAINER;
        model = "\A3\Structures_F\Items\Food\Can_V3_F.p3d";
        scale = 10;
        direction[] = {0, -0.35, -0.65};
        up[] = {0, 0.65, -0.35};

        position[] = {0,0,0.2};
        x = 0.5; y = 0.5; z = 0.2;
        positionBack[] = {0,0,1.2};
        xBack = 0.5; yBack = 0.5; zBack = 1.2;
        inBack = 1;
        enableZoom = 1;
        zoomDuration = 0.001;
};
class grad_replay_RscCombo {
        access = 0;
        type = 4;
        colorSelect[] =
        {         0,            0,            0,            1
        };
        colorText[] =
        {
            0.95,            0.95,            0.95,            1
        };
        colorBackground[] =
        {
            0,            0,            0,            1
        };
        colograd_replay_rScrollbar[] =
        {
            1,            0,            0,            1
        };
        soundSelect[] =
        {
            "\A3\ui_f\data\sound\grad_replay_RscCombo\soundSelect",
            0.1,
            1
        };
        soundExpand[] =
        {
            "\A3\ui_f\data\sound\grad_replay_RscCombo\soundExpand",
            0.1,
            1
        };
        soundCollapse[] =
        {
            "\A3\ui_f\data\sound\grad_replay_RscCombo\soundCollapse",
            0.1,
            1
        };
        maxHistoryDelay = 1;
        class ScrollBar
        {
            color[] =
            {
                1,                1,                1,                0.6
            };
            colorActive[] =
            {
                1,                1,                1,                1
            };
            colorDisabled[] =
            {
                1,                1,                1,                0.3
            };
            shadow = 0;
            thumb = "\A3\ui_f\data\gui\cfg\scrollbar\thumb_ca.paa";
            arrowFull = "\A3\ui_f\data\gui\cfg\scrollbar\arrowFull_ca.paa";
            arrowEmpty = "\A3\ui_f\data\gui\cfg\scrollbar\arrowEmpty_ca.paa";
            border = "\A3\ui_f\data\gui\cfg\scrollbar\border_ca.paa";
        };
        style = 16;
        x = 0;
        y = 0;
        w = 0.12;
        h = 0.035;
        shadow = 0;
        colorSelectBackground[] =
        {
            1,
            1,
            1,
            0.7
        };
        arrowEmpty = "\A3\ui_f\data\GUI\grad_replay_RscCommon\grad_replay_rsccombo\arrow_combo_ca.paa";
        arrowFull = "\A3\ui_f\data\GUI\grad_replay_RscCommon\grad_replay_rsccombo\arrow_combo_active_ca.paa";
        wholeHeight = 0.45;
        color[] =
        {
            1,
            1,
            1,
            1
        };
        colorActive[] =
        {
            1,
            0,
            0,
            1
        };
        colorDisabled[] =
        {
            1,
            1,
            1,
            0.25
        };
        font = "PuristaMedium";
        sizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
      class ComboScrollBar : ScrollBar
       {
        color[] = {1,1,1,0.6};
        colorActive[] = {1,1,1,1};
        colorDisabled[] = {1,1,1,0.3};
        thumb = "#(argb,8,8,3)color(1,1,1,1)";
        arrowEmpty = "#(argb,8,8,3)color(1,1,1,1)";
        arrowFull = "#(argb,8,8,3)color(1,1,1,1)";
        border = "#(argb,8,8,3)color(1,1,1,1)";
        shadow = 0;
       };
};

class grad_replay_RscMapControl
{
  access = 0;
  idc = -1;
  type = CT_MAP_MAIN;
  style = ST_PICTURE;

  x = 0.10;
  y = 0.10;
  w = 0.80;
  h = 0.60;

  moveOnEdges = 0;
    shadow = 1;
    ptsPerSquareSea = 5;
    ptsPerSquareTxt = 3;
    ptsPerSquareCLn = 10;
    ptsPerSquareExp = 10;
    ptsPerSquareCost = 10;
    ptsPerSquareFor = 9;
    ptsPerSquareForEdge = 9;
    ptsPerSquareRoad = 6;
    ptsPerSquareObj = 9;
    showCountourInterval = 1;
    scaleMin = 0.001;
    scaleMax = 1.0;
    scaleDefault = 0.16;
    maxSatelliteAlpha = 0.4;
    alphaFadeStartScale = 1;
    alphaFadeEndScale = 1;
    colorBackground[] = {0.969,0.957,0.949,1.0};
    colorSea[] = {0.467,0.631,0.851,0.5};
    colorForest[] = {0.624,0.78,0.388,0.5};
    colorForestBorder[] = {0.0,0.0,0.0,0.0};
    colorRocks[] = {0.0,0.0,0.0,0.3};
    colorRocksBorder[] = {0.0,0.0,0.0,0.0};
    colorLevels[] = {0.286,0.177,0.094,0.5};
    colorMainCountlines[] = {0.572,0.354,0.188,0.5};
    colorCountlines[] = {0.572,0.354,0.188,0.25};
    colorMainCountlinesWater[] = {0.491,0.577,0.702,0.6};
    colorCountlinesWater[] = {0.491,0.577,0.702,0.3};
    colorPowerLines[] = {0.1,0.1,0.1,1.0};
    colorRailWay[] = {0.8,0.2,0.0,1.0};
    colorNames[] = {0.1,0.1,0.1,0.9};
    colorInactive[] = {1.0,1.0,1.0,0.5};
    colorOutside[] = {0.0,0.0,0.0,1.0};
    colorTracks[] = {0.84,0.76,0.65,0.15};
    colorTracksFill[] = {0.84,0.76,0.65,1.0};
    colorRoads[] = {0.7,0.7,0.7,1.0};
    colorRoadsFill[] = {1.0,1.0,1.0,1.0};
    colorMainRoads[] = {0.9,0.5,0.3,1.0};
    colorMainRoadsFill[] = {1.0,0.6,0.4,1.0};
    colorGrid[] = {0.1,0.1,0.1,0.6};
    colorGridMap[] = {0.1,0.1,0.1,0.6};
    fontLabel = "PuristaMedium";
    sizeExLabel = "(            (            (            ((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
    fontGrid = "TahomaB";
    sizeExGrid = 0.02;
    fontUnits = "TahomaB";
    sizeExUnits = "(            (            (            ((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
    fontNames = "PuristaMedium";
    sizeExNames = "(            (            (            ((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8) * 2";
    fontInfo = "PuristaMedium";
    sizeExInfo = "(            (            (            ((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
    fontLevel = "TahomaB";
    sizeExLevel = 0.02;

    colorText[] = {1,1,1,1.0};
    font = "PuristaMedium";
    text = "#(argb,8,8,3)color(1,1,1,1)";
    SizeEx = "(            (            (            ((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
    //size = "(            (            (            ((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";

    class Legend
    {
        x = "SafeZoneX +                     (            ((safezoneW / safezoneH) min 1.2) / 40)";
        y = "SafeZoneY + safezoneH - 4.5 *                     (            (            ((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
        w = "10 *                     (            ((safezoneW / safezoneH) min 1.2) / 40)";
        h = "3.5 *                     (            (            ((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
        font = "PuristaMedium";
        sizeEx = "(            (            (            ((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.8)";
        colorBackground[] = {1,1,1,0.5};
        color[] = {0,0,0,1};
    };
    class Task
    {
        icon = "\A3\ui_f\data\map\mapcontrol\taskIcon_CA.paa";
        iconCreated = "\A3\ui_f\data\map\mapcontrol\taskIconCreated_CA.paa";
        iconCanceled = "\A3\ui_f\data\map\mapcontrol\taskIconCanceled_CA.paa";
        iconDone = "\A3\ui_f\data\map\mapcontrol\taskIconDone_CA.paa";
        iconFailed = "\A3\ui_f\data\map\mapcontrol\taskIconFailed_CA.paa";
        color[] = {"(profilenamespace getvariable ['IGUI_TEXT_RGB_R',0])","(profilenamespace getvariable ['IGUI_TEXT_RGB_G',1])","(profilenamespace getvariable ['IGUI_TEXT_RGB_B',1])","(profilenamespace getvariable ['IGUI_TEXT_RGB_A',0.8])"};
        colorCreated[] = {1,1,1,1};
        colorCanceled[] = {0.7,0.7,0.7,1};
        colorDone[] = {0.7,1,0.3,1};
        colorFailed[] = {1,0.3,0.2,1};
        size = 27;
        importance = 1;
        coefMin = 1;
        coefMax = 1;
    };
    class Waypoint
    {
        icon = "\A3\ui_f\data\map\mapcontrol\waypoint_ca.paa";
        color[] = {0,0,0,1};
        size = 27;
        importance = 1;
        coefMin = 1;
        coefMax = 1;
    };
    class WaypointCompleted
    {
        icon = "\A3\ui_f\data\map\mapcontrol\waypointCompleted_ca.paa";
        color[] = {0,0,0,1};
        size = 27;
        importance = 1;
        coefMin = 1;
        coefMax = 1;
    };
    class CustomMark
    {
        icon = "\A3\ui_f\data\map\mapcontrol\custommark_ca.paa";
        size = 24;
        importance = 1;
        coefMin = 1;
        coefMax = 1;
        color[] = {0,0,0,1};
    };
    class Command
    {
        icon = "\A3\ui_f\data\map\mapcontrol\waypoint_ca.paa";
        size = 18;
        importance = 1;
        coefMin = 1;
        coefMax = 1;
        color[] = {1,1,1,1};
    };
    class Bush
    {
        icon = "\A3\ui_f\data\map\mapcontrol\bush_ca.paa";
        color[] = {0.45,0.64,0.33,0.4};
        size = "14/2";
        importance = "0.2 * 14 * 0.05 * 0.05";
        coefMin = 0.25;
        coefMax = 4;
    };
    class Rock
    {
        icon = "\A3\ui_f\data\map\mapcontrol\rock_ca.paa";
        color[] = {0.1,0.1,0.1,0.8};
        size = 12;
        importance = "0.5 * 12 * 0.05";
        coefMin = 0.25;
        coefMax = 4;
    };
    class SmallTree
    {
        icon = "\A3\ui_f\data\map\mapcontrol\bush_ca.paa";
        color[] = {0.45,0.64,0.33,0.4};
        size = 12;
        importance = "0.6 * 12 * 0.05";
        coefMin = 0.25;
        coefMax = 4;
    };
    class Tree
    {
        icon = "\A3\ui_f\data\map\mapcontrol\bush_ca.paa";
        color[] = {0.45,0.64,0.33,0.4};
        size = 12;
        importance = "0.9 * 16 * 0.05";
        coefMin = 0.25;
        coefMax = 4;
    };
    class busstop
    {
        icon = "\A3\ui_f\data\map\mapcontrol\busstop_CA.paa";
        size = 24;
        importance = 1;
        coefMin = 0.85;
        coefMax = 1.0;
        color[] = {1,1,1,1};
    };
    class fuelstation
    {
        icon = "\A3\ui_f\data\map\mapcontrol\fuelstation_CA.paa";
        size = 24;
        importance = 1;
        coefMin = 0.85;
        coefMax = 1.0;
        color[] = {1,1,1,1};
    };
    class hospital
    {
        icon = "\A3\ui_f\data\map\mapcontrol\hospital_CA.paa";
        size = 24;
        importance = 1;
        coefMin = 0.85;
        coefMax = 1.0;
        color[] = {1,1,1,1};
    };
    class church
    {
        icon = "\A3\ui_f\data\map\mapcontrol\church_CA.paa";
        size = 24;
        importance = 1;
        coefMin = 0.85;
        coefMax = 1.0;
        color[] = {1,1,1,1};
    };
    class lighthouse
    {
        icon = "\A3\ui_f\data\map\mapcontrol\lighthouse_CA.paa";
        size = 24;
        importance = 1;
        coefMin = 0.85;
        coefMax = 1.0;
        color[] = {1,1,1,1};
    };
    class power
    {
        icon = "\A3\ui_f\data\map\mapcontrol\power_CA.paa";
        size = 24;
        importance = 1;
        coefMin = 0.85;
        coefMax = 1.0;
        color[] = {1,1,1,1};
    };
    class powersolar
    {
        icon = "\A3\ui_f\data\map\mapcontrol\powersolar_CA.paa";
        size = 24;
        importance = 1;
        coefMin = 0.85;
        coefMax = 1.0;
        color[] = {1,1,1,1};
    };
    class powerwave
    {
        icon = "\A3\ui_f\data\map\mapcontrol\powerwave_CA.paa";
        size = 24;
        importance = 1;
        coefMin = 0.85;
        coefMax = 1.0;
        color[] = {1,1,1,1};
    };
    class powerwind
    {
        icon = "\A3\ui_f\data\map\mapcontrol\powerwind_CA.paa";
        size = 24;
        importance = 1;
        coefMin = 0.85;
        coefMax = 1.0;
        color[] = {1,1,1,1};
    };
    class quay
    {
        icon = "\A3\ui_f\data\map\mapcontrol\quay_CA.paa";
        size = 24;
        importance = 1;
        coefMin = 0.85;
        coefMax = 1.0;
        color[] = {1,1,1,1};
    };
    class shipwreck
    {
        icon = "\A3\ui_f\data\map\mapcontrol\shipwreck_CA.paa";
        size = 24;
        importance = 1;
        coefMin = 0.85;
        coefMax = 1.0;
        color[] = {1,1,1,1};
    };
    class transmitter
    {
        icon = "\A3\ui_f\data\map\mapcontrol\transmitter_CA.paa";
        size = 24;
        importance = 1;
        coefMin = 0.85;
        coefMax = 1.0;
        color[] = {1,1,1,1};
    };
    class watertower
    {
        icon = "\A3\ui_f\data\map\mapcontrol\watertower_CA.paa";
        size = 24;
        importance = 1;
        coefMin = 0.85;
        coefMax = 1.0;
        color[] = {1,1,1,1};
    };
    class Cross
    {
        icon = "\A3\ui_f\data\map\mapcontrol\Cross_CA.paa";
        size = 24;
        importance = 1;
        coefMin = 0.85;
        coefMax = 1.0;
        color[] = {0,0,0,1};
    };
    class Chapel
    {
        icon = "\A3\ui_f\data\map\mapcontrol\Chapel_CA.paa";
        size = 24;
        importance = 1;
        coefMin = 0.85;
        coefMax = 1.0;
        color[] = {0,0,0,1};
    };
    class Bunker
    {
        icon = "\A3\ui_f\data\map\mapcontrol\bunker_ca.paa";
        size = 14;
        importance = "1.5 * 14 * 0.05";
        coefMin = 0.25;
        coefMax = 4;
        color[] = {0,0,0,1};
    };
    class Fortress
    {
        icon = "\A3\ui_f\data\map\mapcontrol\bunker_ca.paa";
        size = 16;
        importance = "2 * 16 * 0.05";
        coefMin = 0.25;
        coefMax = 4;
        color[] = {0,0,0,1};
    };
    class Fountain
    {
        icon = "\A3\ui_f\data\map\mapcontrol\fountain_ca.paa";
        size = 11;
        importance = "1 * 12 * 0.05";
        coefMin = 0.25;
        coefMax = 4;
        color[] = {0,0,0,1};
    };
    class Ruin
    {
        icon = "\A3\ui_f\data\map\mapcontrol\ruin_ca.paa";
        size = 16;
        importance = "1.2 * 16 * 0.05";
        coefMin = 1;
        coefMax = 4;
        color[] = {0,0,0,1};
    };
    class Stack
    {
        icon = "\A3\ui_f\data\map\mapcontrol\stack_ca.paa";
        size = 20;
        importance = "2 * 16 * 0.05";
        coefMin = 0.9;
        coefMax = 4;
        color[] = {0,0,0,1};
    };
    class Tourism
    {
        icon = "\A3\ui_f\data\map\mapcontrol\tourism_ca.paa";
        size = 16;
        importance = "1 * 16 * 0.05";
        coefMin = 0.7;
        coefMax = 4;
        color[] = {0,0,0,1};
    };
    class ViewTower
    {
        icon = "\A3\ui_f\data\map\mapcontrol\viewtower_ca.paa";
        size = 16;
        importance = "2.5 * 16 * 0.05";
        coefMin = 0.5;
        coefMax = 4;
        color[] = {0,0,0,1};
    };

    class ActiveMarker
    {
        //icon = "\A3\ui_f\data\map\mapcontrol\custommark_ca.paa";
        size = 24;
        importance = 1;
        coefMin = 1;
        coefMax = 1;
        color[] = {0,0,0,1};
    };
   class LineMarker { lineDistanceMin = 3e-005; lineLengthMin = 5; lineWidthThick = 0.014; lineWidthThin = 0.008; textureComboBoxColor = "#(argb,8,8,3)color(1,1,1,1)"; };
};
