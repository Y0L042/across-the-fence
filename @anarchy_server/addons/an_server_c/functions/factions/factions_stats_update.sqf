/*
	File: factions_stats_update.sqf
	Author: Dscha
	Date: 2020-10-13
	Last Update: 2020-10-13
	Public: No
	
	Description:
		Updates stats for a faction in the backend.
	
	Parameter(s):
		_type		- STRING	- Stat to update? (UPPERCASE - for convenience, will be done automatically)
								- Available: "int"
		_side		- STRING	- Side/Faction to update(UPPERCASE - for convenience, will be done automatically)
								- Available: "WEST", "EAST", "GUER", "CIV"
		_points 	- INT		- positive or negative Values possible
	
	Returns:
		Nothing
	
	Example(s):
		["int", "wEsT",-12345] call vn_fnc_myFunction
		["int", "EaSt",54321] call vn_fnc_myFunction
*/

params
[
	["_type","int",[""]],
	["_side","",[""]],
	["_points",0,[0]]
];

if !((toUpper _side) in ["WEST","EAST","GUER","CIV"])exitWith{diag_log ["ERROR: factions_stats_update: SIDE NOT FOUND: _side: ", _side];};
// toLower/toUpper == failsafe
["fac_stats_upd", [toUpper _type, toUpper _side,_points]] call AN_G_fnc_msg_send;