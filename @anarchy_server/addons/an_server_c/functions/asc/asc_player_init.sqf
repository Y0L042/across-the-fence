/*
    File: asc_player_init.sqf
    Author: Spoffy
    Date: 2020-11-03
    Last Update: 2020-11-03
    Public: No
    
    Description:
        Initialises a player using data from ASC.
		Sets "asc_initialised_on_server" on player when done.

		Player pawn *must exist when this function is called*
    
    Parameter(s):
		_playerUID - UID of the relevant player
    
    Returns:
		None
    
    Example(s):
		N/A - Called from ASC
*/

params ["_playerUID"]

private _players = allPlayers;
private _playerIndex = _players findIf { getPlayerUID _x == _playerUID };
if (_playerIndex == -1) exitWith {diag_log format ["ERROR Anarchy: Player with UID %1 could not be found", _playerUID];};

private _player = _players select _playerIndex;

//======================
//==== DO INIT HERE ====
//======================


//==================
//==== END INIT ====
//==================

//Mark player as fully initialised by ASC on the server.
_player setVariable ["asc_initialised_on_server", true, true];
