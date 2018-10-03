class playbackControl {
    duration = 99999;
    idd = 80000;
    movingenable = 0;
    showOverMap = 0;
    enableSimulation = 0;

    class controlsBackground
        {
            class backgroundMap : grad_replay_RscMapControl {
                idc = 1337;
                x = safezoneXAbs;
                y = safezoneY;
                w = safezoneWAbs;
                h = safezoneH;
            };
        };


    class controls {

        // this can't be a controlsBackground class, or it will disappear while slider is unselected
        class dlgBackground: grad_replay_RscBackground
        {
            idc = 1336;
            x = "SafeZoneX + (160 / 1920) * SafeZoneW";
            y = "SafeZoneY + (910 / 1080) * SafeZoneH";
            w = "(1600 / 1920) * SafeZoneW";
            h = "(40 / 1080) * SafeZoneH";
            colorBackground[] = {0,0,0,0.8};
        };

        // A slider to change the overcast value (look at grad_replay_RscXSlider - more pretty version of RscSlider)
        class overcastSlider: grad_replay_RscSlider {
            idc = 80003;
            x = "SafeZoneX + (160 / 1920) * SafeZoneW";
            y = "SafeZoneY + (920 / 1080) * SafeZoneH";
            w = "(1600 / 1920) * SafeZoneW";
            h = "(20 / 1080) * SafeZoneH";
            // type = CT_XSLIDER;
            // style = SL_HORZ;
            color[] = {1,1,1,1};
            colorActive[] = {1,1,1,1}; // {0.8,0.5,0.1,1};
            colorDisabled[] = {0.5,0.5,0.5,0.2};

            colorFocused[] = {1,1,1,0.4};
            colorBackground[] = {1,1,1,0.4};
            colorBackgroundDisabled[] = {1,1,1,0.4};
            thumb = "#(argb,8,8,3)color(0.8,0.5,0.1,1)";
            arrowEmpty = "#(argb,8,8,3)color(0,0,0,0)";
            arrowFull = "#(argb,8,8,3)color(0,0,0,0)";
            border = "#(argb,8,8,3)color(1,1,1,1)";
            shadow = 0;
            vspacing = 0.5;
            tooltip = "Set replay position";
            onSliderPosChanged = "[_this] call GRAD_replay_fnc_onPlaybackPosChanged"; // added onSliderPosChanged event handler
        };

        class timeDisplay: grad_replay_RscStructuredText {

            idc = 80004;
            access = 0;
            type = CT_STRUCTURED_TEXT;
            style = ST_LEFT;
            colorBackground[] = {0,0,0,0.85};

            size = 0.1;
            text = "00:00:00";
            class Attributes {
                font = "RobotoCondensed";
                color = "#ffffff";
                align = "center";
                valign = "middle";
                shadow = false;
                shadowColor = "#ff0000";
                size = "0.5";
            };

            x = "SafeZoneX + (1760 / 1920) * SafeZoneW";
            y = "SafeZoneY + (910 / 1080) * SafeZoneH";
            w = "(120 / 1920) * SafeZoneW";
            h = "(40 / 1080) * SafeZoneH";
        };

        class playPauseDisplay: grad_replay_RscPicture {

            idc = 80005;
            access = 0;
            colorBackground[] = {0,0,0,0.85};

            text = "node_modules\@gruppe-adler\replay\ui\pause.paa";

            x = "SafeZoneX + (120 / 1920) * SafeZoneW";
            y = "SafeZoneY + (910 / 1080) * SafeZoneH";
            w = "(40 / 1920) * SafeZoneW";
            h = "(40 / 1080) * SafeZoneH";
        };
    };
};
