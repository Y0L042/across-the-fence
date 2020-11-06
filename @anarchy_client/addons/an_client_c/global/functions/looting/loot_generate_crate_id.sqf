/*
	File: loot_generate_crate_id.sqf
	Author: Spoffy
	Date: 2020-11-06
	Last Update: 2020-11-06
	Public: No
	
	Description:
		Generates a unique ID for a crate, given that the position is unique to the nearest 100th of a m.
	
	Parameter(s):
		_pos - Position of the crate [ARRAY]
	
	Returns:
		Id [STRING]
	
	Example(s):
		[[0,0,0]] call an_g_fnc_loot_generate_crate_id;
*/

params ["_position"];

private _fnc_hashPos = {
	//Accepts a position as _this
	_this apply {floor (_x * 100) toFixed 0} joinString ""
};

//Hash using the crate position and anarchy seed
(vn_an_seed toFixed 0) + (_position call _fnc_hashPos) 