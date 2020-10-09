/*
	File: fn_faction_set_player.sqf
	Author: Spoffy
	Date: 2020-10-08
	Last Update: 2020-10-08
	Public: No
	
	Description:
		Sets a player to a specific faction until they disconnect.
		This is not the same as the player joining the faction.
	Parameter(s):
		_player - Player to set faction of [UNIT]
		_faction - Faction to set the player to [SIDE]
	
	Returns:
		True if player has been successfully added to that faction.
	
	Example(s):
		[parameter] call vn_fnc_myFunction
*/

params [["_player", nil, [objNull]], ["_faction", nil, [west]]];

private _group = createGroup _faction;
_group deleteGroupWhenEmpty true;
[_player] joinSilent _group;

true

