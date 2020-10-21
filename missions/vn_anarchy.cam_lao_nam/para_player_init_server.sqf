/*
    File: para_player_init_server.sqf
    Author: Spoffy
    Date: 2020-10-12
    Last Update: 2020-10-12
    Public: Yes
    
    Description:
		Called on the server immediately after preinit_client, and before init_client.
		Perform server-side player initialisation here.
		It is safe to access the player object in this function.

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

params [["_player", objNull, [objNull]], ["_didJIP", true, [true]]];

diag_log format ["Anarchy: Player init server - %1", _player];

// prevent repeated execution of init
private _current_token = _player getVariable "para_player_token";
if !(isNil "_current_token") exitWith {};

private _uid = getPlayerUID _player;
// todo load peristant data here

// broadcast new token to only this player
private _token = random 99999;
_local_vars = [];
_local_vars pushBack ["para_player_token",_token];
_player setVariable ["para_player_token",_token];

// currently handled by "\an_server_c\functions\gear\loadout_set.sqf" (ASC returns)
// _player setPos markerPos "new_player_spawn";

// add event handlers from the harass subsystem.
// [_player] call para_s_fnc_harass_add_player_event_handlers;

// send all variables to player
[_local_vars] remoteExecCall ["para_c_fnc_set_local_var",_player];