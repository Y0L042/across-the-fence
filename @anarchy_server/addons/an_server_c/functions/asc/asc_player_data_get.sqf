/*
    File: asc_player_data_get.sqf
    Author: Spoffy
    Date: 2020-10-22
    Last Update: 2020-10-22
    Public: Yes
    
    Description:
        Retrieves ASC data object associated with the given UID.
        This object is automatically destroyed when the player disconnects, so use cautiously.
    
    Parameter(s):
        _playerUID - Unique ID of the player [STRING]
    
    Returns:
        Variable name of the player's data object
    
    Example(s):
        getPlayerUID player call an_s_fnc_asc_player_data_get
*/

localNamespace getVariable [_this call an_s_fnc_asc_player_data_key, objNull]