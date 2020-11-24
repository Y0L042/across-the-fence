/*
	File: fn_init_markers.sqf
	Author: Spoffy
	Date: 2020-05-23
	Last Update: 2020-07-04
	Public: No
	
	Description:
		Loads mission-specific map markers into variables.
	
	Parameter(s): none
	
	Returns: nothing
	
	Example(s):
		call an_s_fnc_init_markers
*/

an_s_markers_respawn_east = [];
an_s_markers_respawn_west = [];
an_s_markers_respawn_guer = [];
an_s_markers_respawn_civ = [];

{
	if (_x find "an_respawn_east" isEqualTo 0) then {
		an_s_markers_respawn_east pushBack _x;
	};
	if (_x find "an_respawn_west" isEqualTo 0) then {
		an_s_markers_respawn_west pushBack _x;
	};
	if (_x find "an_respawn_guer" isEqualTo 0) then {
		an_s_markers_respawn_guer pushBack _x;
	};
	if (_x find "an_respawn_civ" isEqualTo 0) then {
		an_s_markers_respawn_civ pushBack _x;
	};
} forEach allMapMarkers;