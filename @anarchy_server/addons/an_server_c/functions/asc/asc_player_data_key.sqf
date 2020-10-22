/*
    File: asc_player_data_key.sqf
    Author: Spoffy
    Date: 2020-10-22
    Last Update: 2020-10-22
    Public: No
    
    Description:
        Gets the variable name for the data associated with a given UID
    
    Parameter(s):
        _playerUID - Unique ID of the player [STRING]
    
    Returns:
        Variable name of the player's data object
    
    Example(s):
        getPlayerUID player call an_s_fnc_asc_player_data_key
*/

format ["asc_player_data_%1", _this]