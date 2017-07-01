#ifndef MODULES_DIRECTORY
    #define MODULES_DIRECTORY modules
#endif

class GRAD_replay {

    class player {
        file = MODULES_DIRECTORY\GRAD_replay\functions\player;

        class drawIcon {};
        class getRecordEntry {};
        class preparePlaybackClient {};
        class startPlaybackClient {};
    };

	class server {
		file = MODULES_DIRECTORY\GRAD_replay\functions\server;

		class getSideColor {};
        class pauseRecord {};
        class preparePlaybackServer {};
        class startRecord {};
        class stopRecord {};
        class storeValue {};
	};
};