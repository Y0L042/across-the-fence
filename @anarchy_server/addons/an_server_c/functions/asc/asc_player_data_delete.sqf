/*
	File: asc_player_data_delete.sqf
	Author: Spoffy
	Date: 2020-10-22
	Last Update: 2020-10-22
	Public: No
	
	Description:
		Deletes player data object for the given UID. 
		This object is local to the server.
	
	Parameter(s):
		_uid - UID of the player to create the data object for [STRING]
	
	Returns:
		None
	
	Example(s):
		(getPlayerUID (allPlayers # 0)) call an_s_fnc_player_data_delete
*/

[_this call an_s_fnc_player_data_get] call para_g_fnc_delete_namespace;