/*
    File: player_faction_set.sqf
    Author: Dscha
    Date: 2020-11-03
    Last Update: 2020-11-03
    Public: No
    
    Description:
        Joins the player to the given Faction

		Player pawn *must exist when this function is called*
		
		Function call type: unscheduled (call)
    
    Parameter(s):
		_dataset = [
						 ["data_puid",123456]
						,["data_faction", "SIDE" ]
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

// rejoin the faction:
private _dataFaction = ENTRY_GET("data_faction",_dataset);
private _sideNames = ["WEST", "EAST", "GUER", "CIV"];	// Determined via "side cursorObject"
private _side = [west, east, independent, civilian]#(_sideNames find _dataFaction);
[_player, _side] call an_s_fnc_factions_set_player_to_faction;

true