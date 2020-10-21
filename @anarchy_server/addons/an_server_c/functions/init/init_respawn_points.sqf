/*
	File: fn_init_respawn_points.sqf
	Author: Spoffy
	Date: 2020-10-10
	Last Update: 2020-10-10
	Public: No
	
	Description:
		Sets up main mission respawn points
	
	Parameter(s):
		None
	
	Returns:
		None
	
	Example(s):
		[] call vn_mf_fnc_respawn_points_init
*/

{
	private _side = _x;
	private _markers = missionNamespace getVariable format ["an_s_markers_respawn_%1", str _side];
	//Add markers as respawn points, and save the respawn points to a variable.
	missionNamespace setVariable [
		format ["an_s_respawn_points_%1", str _side],
		_markers apply {[_side, _x, markerText _x] call BIS_fnc_addRespawnPosition}
	];
} forEach [west, east, independent];