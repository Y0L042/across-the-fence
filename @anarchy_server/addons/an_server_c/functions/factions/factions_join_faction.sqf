/*
    File: fn_factions_join_faction.sqf
    Author: Spoffy
    Date: 2020-10-08
    Last Update: 2020-10-08
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

[_player, _side] call an_s_fnc_factions_set_player_to_faction;

//TODO - Save player via ASC