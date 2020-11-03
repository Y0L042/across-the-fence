/*
    File: player_get_by_puid.sqf
    Author: Spoffy, Dscha
    Date: 2020-11-03
    Last Update: 2020-11-03
    Public: No
    
    Description:
        Cycles through the playerlist, to find the player with the given PUID

		Player pawn *must exist when this function is called*
		
		Function call type: unscheduled (call)
    
    Parameter(s):
		_playerUID - UID of the relevant player
    
    Returns:
		Object / ObjNull on Error
    
    Example(s):
		_player = ["1234567"] call AN_S_fnc_player_get_by_puid;
		if(isNull _player)exitWith{};	// An error message was triggered already
*/


params["_playerUID"];

private _players = allPlayers;
private _playerIndex = _players findIf { getPlayerUID _x == _playerUID };
if (_playerIndex == -1) exitWith
{
	diag_log format ["ERROR Anarchy: Player with UID %1 could not be found", _playerUID];
	// return ObjNull, if nothing was found!
	ObjNull
};
// diag_log ["PLAYER_GET_BY_PUID: ", _playerIndex, (_players select _playerIndex)];


(_players select _playerIndex)

