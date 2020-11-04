/*
	File: para_player_init_client.sqf
	Author: Spoffy
	Date: 2020-10-12
	Last Update: 2020-10-12
	Public: Yes
	
	Description:
		Called on the client after player_init_server has finished.
		Serverside player initialisation is done at this point.
		It is safe to access the player object in this function.
		Used for setting up UI elements, local event handlers, etc.

		Load order:
			- para_player_preload_client.sqf - Called as soon as possible on the client.
			- para_player_loaded_client.sqf - Called on client as soon as the player is ready
			- para_player_init_server.sqf - Serverside player initialisation.
			- para_player_init_client.sqf - Clientside player initialisation.
			- para_player_postinit_server.sqf - Called on server once all player initialisation is done.
	
	Parameter(s):
		_player - Player to initialise [OBJECT]
		_didJIP - Whether the player joined in progress [BOOLEAN]
	
	Returns:
		None
	
	Example(s):
		//description.ext
		use_paradigm_init = 1;
*/

params ["_player", "_didJIP"];

diag_log "Anarchy: Player init client";



// add notes about current build settings
player createDiaryRecord ["Diary", [localize "STR_vn_mf_howtobuild", localize "STR_vn_mf_howtobuild_long"], taskNull, "", false];

player createDiaryRecord ["Diary", [localize "STR_vn_mf_other_keys", localize "STR_vn_mf_other_keys_long"], taskNull, "", false];

// display initial loading text
[parseText format["<t font='tt2020base_vn' color='#F5F2D0'>%1</t>",localize "STR_vn_mf_loading1"]] call vn_an_fnc_update_loading_screen;

uiSleep 0.4;
progressLoadingScreen 0.2;

[parseText format["<t font='tt2020base_vn' color='#F5F2D0'>%1</t>",localize "STR_vn_mf_loading2"]] call vn_an_fnc_update_loading_screen;

uiSleep 0.4;
progressLoadingScreen 0.3;
// add display event handlers
call para_c_fnc_init_display_event_handler;
[parseText format["<t font='tt2020base_vn' color='#F5F2D0'>%1</t>",localize "STR_vn_mf_loading3"]] call vn_an_fnc_update_loading_screen;

uiSleep 0.4;
progressLoadingScreen 0.4;
// add player event handlers
call para_c_fnc_init_player_event_handlers;
[parseText format["<t font='tt2020base_vn' color='#F5F2D0'>%1</t>",localize "STR_vn_mf_loading4"]] call vn_an_fnc_update_loading_screen;

uiSleep 0.4;
progressLoadingScreen 0.5;

[parseText format["<t font='tt2020base_vn' color='#F5F2D0'>%1</t>",localize "STR_vn_mf_loading5"]] call vn_an_fnc_update_loading_screen;

uiSleep 0.4;
progressLoadingScreen 0.6;

[parseText format["<t font='tt2020base_vn' color='#F5F2D0'>%1</t>",localize "STR_vn_mf_loading6"]] call vn_an_fnc_update_loading_screen;

uiSleep 0.4;
progressLoadingScreen 0.7;
// create UI
// 0 spawn vn_mf_fnc_ui_create;
[parseText format["<t font='tt2020base_vn' color='#F5F2D0'>%1</t>",localize "STR_vn_mf_loading7"]] call vn_an_fnc_update_loading_screen;

uiSleep 0.4;
progressLoadingScreen 0.8;
// master loop
0 spawn para_c_fnc_compiled_loop_init;
[parseText format["<t font='tt2020base_vn' color='#F5F2D0'>%1</t>",localize "STR_vn_mf_loading8"]] call vn_an_fnc_update_loading_screen;

uiSleep 0.4;
progressLoadingScreen 0.9;
[parseText format["<t font='tt2020base_vn' color='#F5F2D0'>%1</t>",localize "STR_vn_mf_loading9"]] call vn_an_fnc_update_loading_screen;

// Spawn and start the Loot-bubble-thingy-function-stuff
vn_an_crates = [];
[] spawn
{
    systemChat "DEBUG: Starting loot bubble check";
    // make loot spawn
    while {true} do
    {
        call AN_C_fnc_loot_bubble;
        uiSleep 0.02;
    };
};
uiSleep 0.4;
progressLoadingScreen 1.0;

[parseText format["<t font='tt2020base_vn' color='#F5F2D0'>%1</t>",localize "STR_vn_mf_loading10"]] call vn_an_fnc_update_loading_screen;

// Start AI processing for local player, if we're not a LAN server (as then serverside processing will kick in)
if (!isServer) then {
	call para_g_fnc_ai_create_behaviour_execution_loop;
};

//LOADING COMPLETE
//Start tidying up ready for play.

// end loading screen
uiSleep 0.4;
endLoadingScreen;
// Fade in
cutText ["", "BLACK IN", 4];
// Bring sound back to normal
4 fadeSound 1;
// Fade out the music
8 fadeMusic 0;
// Restore the music volume in the near future.
[] spawn {sleep 8; playMusic ""; 2 fadeMusic 1};
// Re-enable simulation
player enableSimulation true;

// display location after a little delay
sleep 4;
// call vn_mf_fnc_display_location_time;


//DEV (ToDo): Until client Scheduler is added:
[]spawn
{
	systemchat "starting infopanel handler loop";
	"para_infopanel" cutRsc ["para_infopanel", "PLAIN", -1, true];
	while{true}do
	{
		uisleep 0.5;
		[] call para_c_fnc_infopanel_handler;
	};
};

// Dscha: SPOFFY - HERE - Move me to a proper place please!
// Placeholder addAction to trigger "looting"
player addAction["ASC: get crateData", {[] call AN_C_fnc_loot_inv_request;}, nil, 1.5, true, true, "", "cursorObject in vn_an_crates", 5, false];