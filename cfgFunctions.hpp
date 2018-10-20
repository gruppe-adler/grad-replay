#ifndef MODULES_DIRECTORY
    #define MODULES_DIRECTORY node_modules
#endif

class GRAD_replay {

    class player {
        file = MODULES_DIRECTORY\@gruppe-adler\replay\functions\player;

        class addReplayPart {};
        class animateShot {};
        class assembleReplayData {};
        class createMapOverlay {};
        class drawIcon {};
        class getColorFromID {};
        class getRecordEntry {};
        class initReplay {};
        class onPlaybackPosChanged {};
        class preparePlaybackClient {};
        class receiveData {}
        class setPlayPauseDisplay {};
        class setTimeDisplay {};
        class showHintPause {};
        class showHintPlay {};
        class showHintReplayFinished {};
        class showPlaybackControl {};
        class showProgressBar {};
        class startPlaybackClient {};
        class stopPlaybackClient {};
        class syncPlaybackPos {};
    };

    class server {
        file = MODULES_DIRECTORY\@gruppe-adler\replay\functions\server;

        class canTrackUnit {};
        class getSideColorID {};
        class init {};
        class onFiredMan {};
        class pauseRecord {};
        class preparePlaybackServer {};
        class setMeSpectator {};
        class startRecord {};
        class stopRecord {};
        class storeValue {};
    };
};
