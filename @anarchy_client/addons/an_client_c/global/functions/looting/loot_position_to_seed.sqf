/*
	File: fn_loot_bubble.sqf
	Author: Spoffy
	Date: 2020-07-20
	Last Update: 2020-09-02
	Public: yes

	Description:
		Generates a RNG seed from a position.

	Parameter(s):
		_pos - Position to use [ARRAY]

	Returns:
		Seed [NUMBER]

	Example(s):
		[0, 0, 0] call an_g_fnc_loot_position_to_seed;
*/

params ["_pos"];

//Mod it down to 1021. This gives our posSeed a maximum of 113000 or so.
//This helps us stay within arma's max limit for accurate integers.
private _seedPos = _pos apply {floor _x} apply {_x % 1021};
private _posSeed = (_seedPos # 0 * 100) + (_seedPos # 1 * 10) + (_seedPos # 2);
vn_an_seed + _posSeed;