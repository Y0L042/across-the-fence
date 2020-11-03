/*
    File: asc_player_init.sqf
    Author: Spoffy, Dscha
    Date: 2020-11-03
    Last Update: 2020-11-03
    Public: No
    
    Description:
        Initialises a player using data from ASC.
		Sets "asc_initialised_on_server" on player when done.

		Player pawn *must exist when this function is called*
		
		Function call type: unscheduled (call)
    
    Parameter(s):
		_dataset = [
				 ["data_puid",123456]
			]
    
    Returns:
		None
    
    Example(s):
		N/A - Called from ASC
*/

#include "\sgd\anarchy\an_client_c\global\asc_macros.inc"
params["_dataset"];

private _playerUID = ENTRY_GET("data_puid",_dataset);
private _player = [_playerUID] call AN_S_fnc_player_get_by_puid;
if(isNull _player)exitWith{};

//======================
//==== DO INIT HERE ====
//======================


//==================
//==== END INIT ====
//==================

//Mark player as fully initialised by ASC on the server.
_player setVariable ["asc_initialised_on_server", true, true];
