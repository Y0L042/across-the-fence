/*
    File: asc_player_data_create.sqf
    Author: Spoffy
    Date: 2020-10-22
    Last Update: 2020-10-22
    Public: No
    
    Description:
        Creates player data object for the given UID. 
		This object will automatically be destroyed when the player disconnects.
		This object is local to the server.
    
    Parameter(s):
        _uid - UID of the player to create the data object for [STRING]
    
    Returns:
		Created data object [OBJECT]
    
    Example(s):
		(getPlayerUID (allPlayers # 0)) call an_s_fnc_player_data_create
*/

private _namespace = _this call an_s_fnc_asc_player_data_get;

if (isNull _namespace) then {
	_namespace = false call para_g_fnc_create_namespace;
	localNamespace setVariable [_this call an_s_fnc_asc_player_data_key, _namespace];
};

_namespace