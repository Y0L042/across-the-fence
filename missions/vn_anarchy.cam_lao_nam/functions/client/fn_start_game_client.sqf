/*
	File: fn_start_game_client.sqf
	Author: Aaron Clark <vbawol>
	Date: 2020-05-23
	Last Update: 2020-07-04
	Public: No

	Description:
		Intializes the game.

	Parameter(s): none

	Returns: nothing

	Example(s): none
*/
0 spawn {
	diag_log "VN: Client Init started";

	cutText ["", "BLACK IN", 1];

	//We can show the loading screen after the player is pretty much fully initialised in-mission.
	waitUntil {
		uiSleep 0.1;
		//After pre-load is completed (all functions initialised)
		missionNamespace getVariable ["bis_fnc_preload_init", false]
		//No loading screens
		&& !(call BIS_fnc_isLoading)
		//After briefing
		&& getClientStateNumber >= 10
		//Player is loaded into game
		&& !isNull findDisplay 46
	};




	// [selectRandom (getArray(missionConfigFile >> "gamemode" >> "loadingScreens" >> "images")),5002] call vn_an_fnc_update_loading_screen;

    	player disableConversation true;

	// start loading screen
	startLoadingScreen ["Welcome to Anarchy!", "para_loadingScreen"];


	vn_an_loading_started = diag_tickTime;

	vn_an_loading_failed = false;

	// make sure server is finished with setup
	waitUntil
	{
		uiSleep 0.1;
		if (diag_tickTime - vn_an_loading_started >= 90) exitWith {vn_an_loading_failed = true; true};
		missionNamespace getVariable ["vn_an_server_ready",false]
	};

	if (vn_an_loading_failed) then {
		endLoadingScreen;
		// reject player
		["TimedOut", false, 2, false] call BIS_fnc_endMission;

		diag_log "VN: Client login timed out";
	}
	else
	{
		// do player init
		[player] remoteExecCall ["vn_an_fnc_init_player",2];

		progressLoadingScreen 0.1;

		diag_log "VN: Client Init finished";
	};
};
