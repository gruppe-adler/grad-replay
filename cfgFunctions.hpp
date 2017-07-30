#ifndef MODULES_DIRECTORY
    #define MODULES_DIRECTORY modules
#endif

class GRAD_replay {

    class player {
        file = MODULES_DIRECTORY\GRAD_replay\functions\player;

        class addReplayPart {};
        class drawIcon {};
        class getRecordEntry {};
        class initReplay {};
        class preparePlaybackClient {};
        class receiveData {}
        class showProgressBar {};
        class startPlaybackClient {};
        class stopPlaybackClient {};
    };

	class server {
		file = MODULES_DIRECTORY\GRAD_replay\functions\server;

		class getSideColor {};
        class pauseRecord {};
        class preparePlaybackServer {};
        class setMeSpectator {};
        class startRecord {};
        class stopRecord {};
        class storeValue {};
	};
};