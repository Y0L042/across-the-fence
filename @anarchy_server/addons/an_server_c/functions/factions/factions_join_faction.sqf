/*
    File: fn_factions_join_faction.sqf
    Author: Spoffy, Dscha
    Date: 2020-10-08
    Last Update: 2020-10-14
    Public: Yes
    
    Description:
        Attempts to permanently join a player to a faction.
    
    Parameter(s):
        _player - Player to join [OBJECT]
        _side - Faction to join player to [SIDE]
    
    Returns:
        True if player could be joined to the faction, false otherwise. [BOOLEAN]
    
    Example(s):
        [_player, west] call an_s_fnc_factions_join_faction
*/
params ["_player", "_side"];

private _side_types = [west, east, independent, civilian];
private _side_name = ["WEST", "EAST", "GUER", "CIV"]#(_side_types find _side);	// sides determined via "side cursorObject"
private _puid = getPlayerUID _player;

diag_log [str(side _player), _side_name];
if(str(side _player) isEqualTo _side_name)exitWith{diag_log format["DEBUG: join_faction: Player: %1 (%2), tried to rejoin the same faction (%3).", name _player, _puid, _side_name]};

[_player, _side] call an_s_fnc_factions_set_player_to_faction;


// Send update to the backend
// diag_log ["DEBUG: join_faction: ", _puid," - ", _side, _side_name];
["player_update_faction", [_puid, _side_name]] call AN_G_fnc_msg_send;