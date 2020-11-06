/*
    File: para_server_init.sqf
    Author: Aaron Clark <AWOL>, Spoffy
    Date: 2020-10-12
    Last Update: 2020-10-12
    Public: Yes 
    
    Description:
        Called to initialise the server on game start.
    
    Parameter(s):
        None
    
    Returns:
        None
    
    Example(s):
        //In description.ext
        use_paradigm_init = 1;
*/

private _gamemode_config = (missionConfigFile >> "gamemode");

// setup game optimizations server side
setviewdistance (getNumber(_gamemode_config >> "performance" >> "setviewdistance"));
setobjectviewdistance (getArray(_gamemode_config >> "performance" >> "setobjectviewdistance")); // this also controls ai target range
setterraingrid (getNumber(_gamemode_config >> "performance" >> "setterraingrid"));
(getArray(_gamemode_config >> "performance" >> "enableenvironment")) params ["_ambientlife","_ambientsound"];
enableenvironment [[false,true] select _ambientlife,[false,true] select _ambientsound];

// start scheduler
diag_log "VN Anarchy: Starting scheduler";
call para_g_fnc_scheduler_start;
0 spawn para_g_fnc_scheduler_monitor;

diag_log "VN Anarchy: Loading markers";
call an_s_fnc_init_markers;

diag_log "VN Anarchy: Setting respawn points";
call an_s_fnc_init_respawn_points;

// start the event dispatcher, so anything relying on events can fire.
call para_g_fnc_event_subsystem_init;


// start generic scheduler functions
diag_log "VN Anarchy: Starting game time monitor";
// broadcast total time elapsed - initial
//THIS IS NEEDED BY THE BUILDING SYSTEM RIGHT NOW
//missionNamespace setVariable ["para_g_totalgametime",["GET", "game_time", 0] call para_s_fnc_profile_db select 1,true];
//diag_log format ["VN Anarchy: Total Game Time - %1", para_g_totalgametime];
//["save_time_elapsed", {call vn_mf_fnc_save_time_elapsed}, [], 5] call para_g_fnc_scheduler_add_job;

// spawn buildables and init vars
diag_log "VN Anarchy: Initialising building system";
call para_s_fnc_building_system_init;


diag_log "VN Anarchy: Starting building state tracker";
// building state tracking
["building_state_tracker", {call para_s_fnc_building_state_tracker}, [], 60] call para_g_fnc_scheduler_add_job;

diag_log "VN Anarchy: Starting player list tracker";
// do slow allplayers list updates
["player_list_tracker", {call para_s_fnc_player_list_tracker}, [], 15] call para_g_fnc_scheduler_add_job;

//Set date here - it's as good a place as any. Day is just before a full moon, for good night ops.
// [vn_mf_dawnLength, vn_mf_dayLength, vn_mf_duskLength, vn_mf_nightLength] call para_s_fnc_day_night_subsystem_init;

//Initialise the AI loadbalancer.
diag_log "VN Anarchy: Starting AI loadbalancer";
[] call para_s_fnc_loadbal_subsystem_init;

//Start AI objective subsystem.
[] call para_s_fnc_ai_obj_subsystem_init;

para_g_enemiesPerPlayer = 2;
publicVariable "para_g_enemiesPerPlayer";
// Start harassment subsystem. Depends on the AI subsystem.
// Disabled until it's configured for Anarchy
[] call para_s_fnc_harass_subsystem_init;

// start cleanup subsystem
[] call para_s_fnc_cleanup_subsystem_init;

// start vehicle creation detection subsystem
// [] call vn_mf_fnc_veh_create_detection_subsystem_init;

// start the behaviour subsystem
[] call para_g_fnc_ai_behaviour_subsystem_init;

//Set up slingloaded item locality on helicopters.
["vehicleCreated", [
    {
        params ["_args", "_vehicle"];
        //Call it on every vehicle - it'll abort if it's not a helicopter.
        [_vehicle] call para_g_fnc_localize_slingloaded_objects;
    },
    []
]] call para_g_fnc_event_add_handler;

//Initialise supply officers 
//TEMPORARY - To be removed when we have other supply methods in.
{
    [_x] call vn_an_fnc_create_supply_officer;
} forEach (allMapMarkers select {_x find "supply_officer" == 0});

an_g_looting_crate_probability = 0.2;
publicVariable "an_g_looting_crate_probability";

//Initialise factions
call an_s_fnc_factions_init;